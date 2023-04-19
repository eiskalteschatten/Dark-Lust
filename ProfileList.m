#import "ProfileList.h"

@implementation ProfileList

- (void)awakeFromNib {
	NSFileManager *filemanager = [NSFileManager alloc];
	NSString *folder = @"~/Library/Application Support/Dark Lust/Profiles/";
	folder = [folder stringByExpandingTildeInPath];
	
	if ([filemanager fileExistsAtPath:folder] == YES) {
		rawprofiles = [filemanager directoryContentsAtPath:folder];
	}

	profiles = [[NSMutableArray alloc] initWithCapacity:[rawprofiles count]];
	
	NSEnumerator *enumerator = [rawprofiles objectEnumerator];
	id anObject;
 
	while (anObject = [enumerator nextObject]) {
		if ([anObject isEqualToString:@".DS_Store"] == NO) {
			[profiles addObject:[anObject stringByDeletingPathExtension]];
		}
	}
	
	[profileList setEditable: NO];
}

- (int)numberOfRowsInTableView:(NSTableView *)tableView {
    return [profiles count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(int)row {
    return [profiles objectAtIndex:row];
}

@end
