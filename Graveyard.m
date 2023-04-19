#import "Graveyard.h"

@implementation Graveyard

- (void)becomeKeyWindow {		
	if ([[statsCharacterStatus stringValue] isEqualToString:@"Working"]) {
		[workBox setHidden: YES];
		[workStatus setStringValue: @"You are already hard at work."];
	}
	else if ([[statsCharacterStatus stringValue] isEqualToString:@"Hunting"]) {
		[workBox setHidden: YES];
		[workStatus setStringValue: @"You are hunting right now! Please come back when you are finished."];
	}
	else {
		[workBox setHidden: NO];
		[workWages setStringValue: [valuesWages stringValue]];
		[workStatus setStringValue: @""];
	}
}

@end