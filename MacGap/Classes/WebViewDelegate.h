#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@class Sound;
@class Dock;
@class Growl;
@class Notice;
@class Path;
@class Shell;
@class App;
@class Window;
@class Clipboard;
@class MenuProxy;
@class Fonts;

@class WindowController;

@interface WebViewDelegate : NSObject {
	Sound* sound;
    Dock* dock;
    Growl* growl;
    Notice* notice;
    Path* path;
    App* app;
    Shell* shell;
    Window* window;
    Clipboard* clipboard;
    NSMenu *mainMenu;
    Fonts* fonts;
}



@property (nonatomic, retain) Sound* sound;
@property (nonatomic, retain) Dock* dock;
@property (nonatomic, retain) Growl* growl;
@property (nonatomic, retain) Notice* notice;
@property (nonatomic, retain) Path* path;
@property (nonatomic, retain) App* app;
@property (nonatomic, retain) Shell* shell;
@property (nonatomic, retain) Window* window;
@property (nonatomic, retain) Clipboard* clipboard;
@property (nonatomic, retain) MenuProxy* menu;
@property (nonatomic, retain) Fonts* fonts;

@property (nonatomic, retain) WindowController *requestedWindow;

- (id) initWithMenu:(NSMenu*)menu;
@end
