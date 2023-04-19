/* ProfileList */

#import <Cocoa/Cocoa.h>

@interface ProfileList : NSObject
{
    IBOutlet id profileList;

	NSArray *rawprofiles;
	NSMutableArray *profiles;
}

@end
