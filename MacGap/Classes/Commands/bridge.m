// Expose everything by default.
@implementation NSObject(ExposeEverything)

+ (BOOL)isSelectorExcludedFromWebScript:(SEL)selector {
    return NO;
}

+ (BOOL)isKeyExcludedFromWebScript:(const char *)property {
    return NO;
}

@end



#import "Bridge.h"

@implementation Bridge

- (NSApplication*) NSApp {
    return NSApp;
}

@end
