#import "Shell.h"
#import <Cocoa/Cocoa.h>
#import <Security/Authorization.h>

@implementation Shell

- (NSTask*) shellTask:(NSString*)command
{
	NSTask* task = [[NSTask alloc] init];
    [task setLaunchPath: @"/bin/sh"];
	[task setStandardInput:[NSFileHandle fileHandleWithNullDevice]];
    [task setArguments: @[@"-c", command]];
    
    return task;
}

- (NSString*) executeShellTask:(NSString*)command
{
    NSPipe* pipe = [NSPipe pipe];
    NSFileHandle* fileHandle = [pipe fileHandleForReading];
    
	NSTask* task = [self shellTask:command];
    [task setStandardOutput:pipe];
	[task setStandardError:pipe];
    [task launch];
    
    NSData* outputData = [fileHandle readDataToEndOfFile];
    NSLog([[NSString alloc] initWithData:outputData encoding:NSUTF8StringEncoding]);
    
	return [[NSString alloc] initWithData:outputData encoding:NSUTF8StringEncoding];
}

- (NSTask*) executeShellTaskAsync:(NSString*)command usingBlock:(void (^)(NSNotification *))block
{
    NSPipe* pipe = [NSPipe pipe];
    NSFileHandle* fileHandle = [pipe fileHandleForReading];
    
	NSTask* task = [self shellTask:command];
    [task setStandardOutput:pipe];
	[task setStandardError:pipe];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    
    [center addObserverForName:NSFileHandleReadCompletionNotification object:fileHandle queue:mainQueue usingBlock:block];
    [center addObserverForName:NSTaskDidTerminateNotification object:task queue:mainQueue usingBlock:block];
    
    [task launch];
    [fileHandle readInBackgroundAndNotify];
    
    return task;
}

- (void) executeShellTaskAsync:(NSString*)command withCallbackId:(NSString*)aCallbackId
{
    __block NSString* callbackId = aCallbackId;
    __block NSTask* task = nil;
    
    task = [self executeShellTaskAsync:command usingBlock:^(NSNotification* notif){
        if ([notif.object isKindOfClass:[NSFileHandle class]]) {
            NSFileHandle* fileHandle = (NSFileHandle*)notif.object;
            NSData* data = [[notif userInfo] valueForKey:NSFileHandleNotificationDataItem];
            NSString* output = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//            CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:@{ @"data": output }];
//            result.keepCallback = [NSNumber numberWithBool:YES];
//            [plugin.commandDelegate sendPluginResult:result callbackId:callbackId];
            
            if (task && [task isRunning]) {
                [fileHandle readInBackgroundAndNotify];
            }
            
        } else if ([notif.object isKindOfClass:[NSTask class]]) {
            int status = [task terminationStatus];
            task = nil;
            
//            CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
//                                                    messageAsDictionary:@{ @"resultcode" :[NSNumber numberWithInt:status] }];
//            result.keepCallback = [NSNumber numberWithBool:NO];
//            [plugin.commandDelegate sendPluginResult:result callbackId:callbackId];
        }
    }];
}



#pragma mark WebScripting Protocol

+ (BOOL) isSelectorExcludedFromWebScript:(SEL)selector {
    return NO;
}

+ (NSString*) webScriptNameForSelector:(SEL)selector
{
	id	result = nil;
	
	if (selector == @selector(executeShellTask:)) {
		result = @"executeShellTask";
	} else if (selector == @selector(executeShellTaskAsync:withCallbackId:)) {
        result = @"executeShellTaskAsync";
    }
	
	return result;
}

+ (BOOL) isKeyExcludedFromWebScript:(const char*)name {
	return NO;
}

@end
