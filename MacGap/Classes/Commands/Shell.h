#import <Foundation/Foundation.h>

@interface Shell : NSObject {
    
}

- (NSTask*) shellTask:(NSString*)command;
- (NSTask*) executeShellTaskAsync:(NSString*)command usingBlock:(void (^)(NSNotification *))block;
- (void) executeShellTaskAsync:(NSString*)command withCallbackId:(NSString*)aCallbackId;
- (NSString*) executeShellTask:(NSString*)command;

@end
