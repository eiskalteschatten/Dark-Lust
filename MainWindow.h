/* MainWindow */

#import <Cocoa/Cocoa.h>

@interface MainWindow : NSWindow
{
	IBOutlet id profileList;
}

- (IBAction)loadProfile:(id)sender;

@end
