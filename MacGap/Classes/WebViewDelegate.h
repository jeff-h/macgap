#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@class Bridge;
@class Sound;
@class Dock;
@class Growl;
@class Notice;
@class Path;
@class App;
@class Window;
@class Clipboard;

@class WindowController;

@interface WebViewDelegate : NSObject {
	Bridge* bridge;
	Sound* sound;
    Dock* dock;
    Growl* growl;
    Notice* notice;
    Path* path;
    App* app;
    Window* window;
    Clipboard* clipboard;
}



@property (nonatomic, retain) Bridge* bridge;
@property (nonatomic, retain) Sound* sound;
@property (nonatomic, retain) Dock* dock;
@property (nonatomic, retain) Growl* growl;
@property (nonatomic, retain) Notice* notice;
@property (nonatomic, retain) Path* path;
@property (nonatomic, retain) App* app;
@property (nonatomic, retain) Window* window;
@property (nonatomic, retain) Clipboard* clipboard;

@property (nonatomic, retain) WindowController *requestedWindow;

@end
