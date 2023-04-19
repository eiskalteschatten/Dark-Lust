#import "MainWindow.h"

@implementation MainWindow

- (void)becomeKeyWindow {

}

- (void)didEndSheet:(NSWindow *)sheet returnCode:(int)returnCode contextInfo:(void *)contextInfo
{
    [sheet orderOut:self];
}

@end