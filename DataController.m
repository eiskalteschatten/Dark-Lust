#import "DataController.h"

@implementation DataController

#pragma mark -
#pragma mark Load Profile Functions

- (IBAction)tableViewSelected:(id)sender {
    int row = [sender selectedRow];
	
	if (row > -1) {
		[loadProfile setEnabled: YES];
		[loadProfile setTag: row + 1];
	}
	else {
		[loadProfile setEnabled: NO];
	}
	
	//NSLog(@"the user just clicked on row %d", row);
}

- (IBAction)loadProfile:(id)sender {
	[startWindow close];
	
	[self openLoadingWindow];
	
	profileInfo = [self loadDataFromList];
	
	[self openMainWindow:profileInfo];

}

- (NSMutableDictionary *)loadDataFromList {
	NSFileManager *filemanager = [NSFileManager alloc];
	NSString *folder = @"~/Library/Application Support/Dark Lust/Profiles/";
	NSString *folder2 = [folder stringByExpandingTildeInPath];
	
	NSArray *rawprofiles;
	
	if ([filemanager fileExistsAtPath:folder2] == YES) {
		rawprofiles = [filemanager directoryContentsAtPath:folder2];
	}
	else {
		NSRunAlertPanel(@"No profile to load!", @"You must either select an existing profile or create a new one.", @"OK", nil, nil);
	}
	
	NSString *profilePath = [[folder stringByAppendingString: [rawprofiles objectAtIndex:[loadProfile tag]]] stringByExpandingTildeInPath];
	
	return [NSDictionary dictionaryWithContentsOfFile: profilePath];
}

- (IBAction)loadStats:(id)sender {
	[statsExperience setMinValue: 0];
	[statsExperience setMaxValue: [[sender objectForKey:@"ExperienceNextLevel"] doubleValue]];
	
	[statsExperience setDoubleValue:[[sender objectForKey:@"Experience"] doubleValue]];
	[statsExperienceNum setStringValue:[sender valueForKey:@"Experience"]];
	[statsExperienceNextLevel setStringValue:[sender valueForKey:@"ExperienceNextLevel"]];
	
	[statsBlood setMinValue: 0];
	[statsBlood setMaxValue: 100];
	
	[statsBlood setDoubleValue:[[sender objectForKey:@"Blood"] doubleValue]];
	[statsBloodNum setStringValue:[sender valueForKey:@"Blood"]];
	
	NSString* age;
	NSString* creation;
	
	NSCalendarDate* today = [NSDate date];
	NSCalendarDate* dateStarted = [[NSCalendarDate alloc] initWithString:[sender valueForKey:@"Date Started"]];
	double dateDifference = [today timeIntervalSinceDate: dateStarted];
	dateDifference = dateDifference / 86400;
	[dateStarted setCalendarFormat:@"%b %d, %Y   %H:%M"];
	
	age = [NSString stringWithFormat:@"%1.2f days", dateDifference];
	creation = [NSString stringWithFormat:@"%@", dateStarted];

	[statsName setStringValue:[sender valueForKey:@"Name"]];
	[statsLevel setStringValue:[sender valueForKey:@"Level"]];
	[statsRank setStringValue:[sender valueForKey:@"Rank"]];
	[statsGender setStringValue:[sender valueForKey:@"Gender"]];
	[statsAge setStringValue: age];
	[statsCreation setStringValue: creation];
	[statsStrength setStringValue:[sender valueForKey:@"Strength"]];
	[statsDefense setStringValue:[sender valueForKey:@"Defense"]];
	[statsAgility setStringValue:[sender valueForKey:@"Agility"]];
	[statsStamina setStringValue:[sender valueForKey:@"Stamina"]];
	[statsDexterity setStringValue:[sender valueForKey:@"Dexterity"]];
	[statsAlignment setStringValue:[sender valueForKey:@"Alignment"]];
	[statsVictims setStringValue:[sender valueForKey:@"Victims"]];
	[statsKills setStringValue:[sender valueForKey:@"Kills"]];
	[statsBattles setStringValue:[sender valueForKey:@"Battles"]];
	[statsDamageFromEnemies setStringValue:[sender valueForKey:@"Damage From Enemies"]];
	[statsDamageToEnemies setStringValue:[sender valueForKey:@"Damage To Enemies"]];
	[statsCharacterStatus setStringValue:[sender valueForKey:@"Character Status"]];
	
	[valuesAge setDoubleValue: dateDifference];
	[valuesWages setStringValue:[sender valueForKey:@"Wages"]];
	[valuesTimeStarted setStringValue:[sender valueForKey:@"Date Status Started"]];
	[valuesPrayedtoday setStringValue:[sender valueForKey:@"Prayed Today"]];
}

#pragma mark -
#pragma mark New Profile Functions

- (IBAction)createNewProfile:(id)sender {	
	NSString *path = [self pathForNewProfile];
	NSNumber *cash = [[NSNumber alloc] initWithInt:500];
	NSNumber *bank = [[NSNumber alloc] initWithInt:0];
	NSNumber *level = [[NSNumber alloc] initWithInt:1];
	NSNumber *health = [[NSNumber alloc] initWithInt:100];
	NSNumber *experience = [[NSNumber alloc] initWithInt:1];
	NSNumber *experienceNextLevel = [[NSNumber alloc] initWithInt:15];
	NSNumber *blood = [[NSNumber alloc] initWithInt:100];
	NSNumber *age = [[NSNumber alloc] initWithInt:0];
	NSNumber *strength = [[NSNumber alloc] initWithInt:1];
	NSNumber *defense = [[NSNumber alloc] initWithInt:1];
	NSNumber *agility = [[NSNumber alloc] initWithInt:1];
	NSNumber *stamina = [[NSNumber alloc] initWithInt:1];
	NSNumber *dexterity = [[NSNumber alloc] initWithInt:1];
	NSNumber *alignment = [[NSNumber alloc] initWithInt:0];
	NSNumber *victims = [[NSNumber alloc] initWithInt:0];
	NSNumber *kills = [[NSNumber alloc] initWithInt:0];
	NSNumber *battles = [[NSNumber alloc] initWithInt:0];
	NSNumber *damageFromEnemies = [[NSNumber alloc] initWithInt:0];
	NSNumber *damageToEnemies = [[NSNumber alloc] initWithInt:0];
	NSNumber *wages = [[NSNumber alloc] initWithInt:10];
	NSNumber *workingHours = [[NSNumber alloc] initWithInt:0];
	
	NSCalendarDate* today = [NSCalendarDate calendarDate];
	NSString* dateStarted = [NSString stringWithFormat:@"%@", today];
	
	if ([path isEqualToString:@"nope"]) {
		NSRunAlertPanel(@"Error!", @"There was an internal problem. Try restarting the program. If that does not work, please submit a bug report by selecting 'Report a Bug' in the Help menu.", @"OK", nil, nil);
	}
	else {
		NSMutableDictionary * profile;

		profile = [[NSMutableDictionary alloc] init];

		[profile setObject:[name stringValue] forKey:@"Name"];
		[profile setObject:[gender titleOfSelectedItem] forKey:@"Gender"];
		[profile setObject:dateStarted forKey:@"Date Started"];
		[profile setObject:cash forKey:@"Cash"];
		[profile setObject:bank forKey:@"Bank"];
		[profile setObject:level forKey:@"Level"];
		[profile setObject:age forKey:@"Age"];
		[profile setObject:health forKey:@"Health"];
		[profile setObject:@"Fledgling Vampire" forKey:@"Rank"];
		[profile setObject:experience forKey:@"Experience"];
		[profile setObject:experienceNextLevel forKey:@"ExperienceNextLevel"];
		[profile setObject:blood forKey:@"Blood"];
		[profile setObject:strength forKey:@"Strength"];
		[profile setObject:defense forKey:@"Defense"];
		[profile setObject:agility forKey:@"Agility"];
		[profile setObject:stamina forKey:@"Stamina"];
		[profile setObject:dexterity forKey:@"Dexterity"];
		[profile setObject:alignment forKey:@"Alignment"];
		[profile setObject:victims forKey:@"Victims"];
		[profile setObject:kills forKey:@"Kills"];
		[profile setObject:battles forKey:@"Battles"];
		[profile setObject:damageFromEnemies forKey:@"Damage From Enemies"];
		[profile setObject:damageToEnemies forKey:@"Damage To Enemies"];
		[profile setObject:wages forKey:@"Wages"];
		[profile setObject:@"Idle" forKey:@"Character Status"];
		[profile setObject:workingHours forKey:@"Working Hours"];
		[profile setObject:@"" forKey:@"Date Status Started"];
		[profile setObject:@"No" forKey:@"Prayed Today"];
    
		[profile writeToFile:[path stringByExpandingTildeInPath] atomically: YES];
	
		[profileList reloadData];
		[newProfileWindow close];
		[startWindow close];
		
		[self openMainWindow:profile];
//		[self openNewStory:@"1 The Night It Began.rtf"];
	}
}

- (NSString *)pathForNewProfile {
	NSFileManager *fileManager = [NSFileManager defaultManager];
    
	NSString *folder = @"~/Library/Application Support/Dark Lust/";
	folder = [folder stringByExpandingTildeInPath];

	if ([fileManager fileExistsAtPath: folder] == NO) {
		[fileManager createDirectoryAtPath: folder attributes: nil];
	}
    
	NSString *folder2 = @"~/Library/Application Support/Dark Lust/Profiles/";
	folder2 = [folder2 stringByExpandingTildeInPath];

	if ([fileManager fileExistsAtPath: folder2] == NO) {
		[fileManager createDirectoryAtPath: folder2 attributes: nil];
	}
    
	NSString *fileName = [[name stringValue] stringByAppendingString:@".plist"];
	
	if ([fileManager fileExistsAtPath:[folder2 stringByAppendingPathComponent: fileName]]) {
		NSRunAlertPanel(@"This profile already exists!", @"You must either select an existing profile or create a new one.", @"OK", nil, nil);
		return @"nope";
	}
	return [folder2 stringByAppendingPathComponent: fileName];   
}

#pragma mark -
#pragma mark Profile Management Functions

- (IBAction)manageTableViewSelected:(id)sender {
    int row = [sender selectedRow];
	
	if (row > -1) {
		[deleteProfileButton setEnabled: YES];
		[deleteProfileButton setTag: row + 1];
		[renameProfileButton setEnabled: YES];
		[renameProfileButton setTag: row + 1];
	}
	else {
		[deleteProfileButton setEnabled: NO];
		[renameProfileButton setEnabled: NO];
	}
}

- (IBAction)deleteProfile:(id)sender {
	NSFileManager *filemanager = [NSFileManager alloc];
	NSString *folder = @"~/Library/Application Support/Dark Lust/Profiles/";
	NSString *folder2 = [folder stringByExpandingTildeInPath];
	
	NSArray *rawprofiles;
	
	if ([filemanager fileExistsAtPath:folder2] == YES) {
		rawprofiles = [filemanager directoryContentsAtPath:folder2];
	}
	else {
		NSRunAlertPanel(@"No profile to load!", @"You must either select an existing profile or create a new one.", @"OK", nil, nil);
	}

	NSString *profilePath = [[folder stringByAppendingString: [rawprofiles objectAtIndex:[deleteProfileButton tag]]] stringByExpandingTildeInPath];
	
	if (NSRunAlertPanel(@"Are you sure?", @"Are you sure that you would like this profile to be deleted? This CANNOT be undone.", @"Yes", @"No", nil) == NSAlertDefaultReturn) {
		if ([filemanager removeFileAtPath:profilePath handler:nil] == YES) {
			NSRunAlertPanel(@"Success!", @"The profile you selected has been successfully deleted.", @"OK", nil, nil);
			[profileList reloadData];
		}
		else {
			NSRunAlertPanel(@"Could not delete profile!", @"The profile you have selected does not exist! Please restart Dark Lust to fix this problem.", @"OK", nil, nil);
		}
	}
}

- (IBAction)renameProfile:(id)sender {

}

- (bool)updateProfile:(NSDictionary*)profile {
	NSFileManager *fileManager = [NSFileManager defaultManager];
    
	NSString *folder = @"~/Library/Application Support/Dark Lust/";
	folder = [folder stringByExpandingTildeInPath];

	if ([fileManager fileExistsAtPath: folder] == NO) {
		return NO;
	}
    
	NSString *folder2 = @"~/Library/Application Support/Dark Lust/Profiles/";
	folder2 = [folder2 stringByExpandingTildeInPath];

	if ([fileManager fileExistsAtPath: folder2] == NO) {
		return NO;
	}
    
	NSString *fileName = [[profile valueForKey:@"Name"] stringByAppendingString:@".plist"];
	NSString *path = [folder2 stringByAppendingPathComponent: fileName];
	
	if ([profile writeToFile:[path stringByExpandingTildeInPath] atomically: YES] == YES) {
		return YES;
	}
	else {
		return NO;
	}
}

#pragma mark -
#pragma mark Window Management Functions

- (void)openLoadingWindow {
	[loadingBar startAnimation: self];
	[loadingWindow makeKeyAndOrderFront: nil];
}

- (void)closeLoadingWindow {
	[loadingWindow close];
	[loadingBar stopAnimation: self];
}

- (void)openMainWindow:(NSDictionary*)profileInfoLoc {	
	[cashDisplay setStringValue:[profileInfoLoc valueForKey:@"Cash"]];	
	[bankDisplay setStringValue:[profileInfoLoc valueForKey:@"Bank"]];
	profileName = [profileInfoLoc valueForKey:@"Name"];
	
	[healthDisplay setMinValue: 0];
	[healthDisplay setMaxValue: 100];
	
	[healthDisplay setDoubleValue:[[profileInfoLoc objectForKey:@"Health"] doubleValue]];
	
	[self loadStats: profileInfoLoc];
	
	[mainWindow makeKeyAndOrderFront: nil];	

	[self closeLoadingWindow];
}

- (void)openNewStory:(NSString*)story {
	[storyWindow makeKeyAndOrderFront: nil];
	
	NSBundle *bundle = [NSBundle mainBundle];
	NSString *storyPath = [[[bundle bundlePath] stringByAppendingString:@"/Contents/Resources"] stringByExpandingTildeInPath];
	storyPath = [storyPath stringByAppendingString:@"/"];
	storyPath = [storyPath stringByAppendingString: story];
	
//	[storyBox insertText:@"TESTING!!!"];//[NSString stringWithContentsOfFile: storyPath]];
	NSAttributedString *attrString = [[NSAttributedString alloc] initWithPath: storyPath documentAttributes: (NSDictionary **) NULL];
	[[storyBox textStorage] setAttributedString: attrString];
    [attrString release];
}

#pragma mark -
#pragma mark Alter Functions

- (IBAction)prayToGod:(id)sender {
	double alignment;
	
	alignment = [statsAlignment doubleValue] + 1;
	[statsAlignment setDoubleValue: alignment];
	
	profileInfo = [self loadDataFromList];	
	[profileInfo setObject:[[NSNumber alloc] initWithDouble: alignment] forKey:@"Alignment"];
	
	if ([self updateProfile: profileInfo] == YES) {
		NSRunAlertPanel(@"God thanks you!", @"You've prayed to God. Your alignment is now 1 point towards good.", @"OK", nil, nil);
	}
	else {
			NSRunAlertPanel(@"Error!", @"There was a problem saving your changes. Try restarting the program. If that does not work, please submit a bug report by selecting 'Report a Bug' in the Help menu.", @"OK", nil, nil);
	}
}

- (IBAction)prayToSatan:(id)sender {
	double alignment;
	
	alignment = [statsAlignment doubleValue] - 1;
	[statsAlignment setDoubleValue: alignment];
	
	profileInfo = [self loadDataFromList];	
	[profileInfo setObject:[[NSNumber alloc] initWithDouble: alignment] forKey:@"Alignment"];
	
	if ([self updateProfile: profileInfo] == YES) {
		NSRunAlertPanel(@"Satan thanks you!", @"You've prayed to Satan. You are now 1 point more evil.", @"OK", nil, nil);
	}
	else {
			NSRunAlertPanel(@"Error!", @"There was a problem saving your changes. Try restarting the program. If that does not work, please submit a bug report by selecting 'Report a Bug' in the Help menu.", @"OK", nil, nil);
	}
}

#pragma mark -
#pragma mark Bank Functions

- (IBAction)deposit:(id)sender {
	double cash, cashNew;
	double bank, bankNew;
	
	cash = [cashDisplay doubleValue];
	bank = [bankDisplay doubleValue];

	cashNew = cash - [bankDepositBox doubleValue];
	bankNew = bank + [bankDepositBox doubleValue];
	
	if (cashNew >= 0) {
		[cashDisplay setDoubleValue: cashNew];
		[bankDisplay setDoubleValue: bankNew];		
	
		profileInfo = [self loadDataFromList];	
		[profileInfo setObject:[[NSNumber alloc] initWithDouble: cashNew] forKey:@"Cash"];
		[profileInfo setObject:[[NSNumber alloc] initWithDouble: bankNew] forKey:@"Bank"];
	
		if ([self updateProfile: profileInfo] == NO) {
			NSRunAlertPanel(@"Error!", @"There was a problem saving your changes. Try restarting the program. If that does not work, please submit a bug report by selecting 'Report a Bug' in the Help menu.", @"OK", nil, nil);
		}
	}
	else {
		NSRunAlertPanel(@"Not enough cash!", @"You don't have that much cash to deposit.", @"OK", nil, nil);
	}
}

- (IBAction)withdraw:(id)sender {
	double cash, cashNew;
	double bank, bankNew;
	
	cash = [cashDisplay doubleValue];
	bank = [bankDisplay doubleValue];

	cashNew = cash + [bankWithdrawBox doubleValue];
	bankNew = bank - [bankWithdrawBox doubleValue];
	
	if (bankNew >= 0) {
		[cashDisplay setDoubleValue: cashNew];
		[bankDisplay setDoubleValue: bankNew];		
	
		profileInfo = [self loadDataFromList];	
		[profileInfo setObject:[[NSNumber alloc] initWithDouble: cashNew] forKey:@"Cash"];
		[profileInfo setObject:[[NSNumber alloc] initWithDouble: bankNew] forKey:@"Bank"];
	
		if ([self updateProfile: profileInfo] == NO) {
			NSRunAlertPanel(@"Error!", @"There was a problem saving your changes. Try restarting the program. If that does not work, please submit a bug report by selecting 'Report a Bug' in the Help menu.", @"OK", nil, nil);
		}
	}
	else {
		NSRunAlertPanel(@"Not enough money!", @"You don't have that much money in your bank.", @"OK", nil, nil);
	}
}

#pragma mark -
#pragma mark Graveyard Functions

- (IBAction)work:(id)sender {
	if ([[statsCharacterStatus stringValue] isEqualToString:@"Working"]) {
		NSRunAlertPanel(@"You are already working!", @"You cannot start another work session while you are still working.", @"OK", nil, nil);	
	}
	else if ([[statsCharacterStatus stringValue] isEqualToString:@"Hunting"]) {
		NSRunAlertPanel(@"You are out on a hunt!", @"You cannot start working while you are hunting.", @"OK", nil, nil);	
	}
	else {	
		profileInfo = [self loadDataFromList];	
		[profileInfo setObject:@"Working" forKey:@"Character Status"];
		[profileInfo setObject:[[NSNumber alloc] initWithInt:[graveyardWorkHours tag]] forKey:@"Working Hours"];
		
		NSCalendarDate* today = [NSCalendarDate calendarDate];
		NSString* dateStarted = [NSString stringWithFormat:@"%@", today];
		[valuesTimeStarted setStringValue: dateStarted];
		[profileInfo setObject:dateStarted forKey:@"Date Status Started"];
		
		[statsCharacterStatus setStringValue:@"Working"];
	
		if ([self updateProfile: profileInfo] == YES) {
			NSRunAlertPanel(@"You have begun to work!", @"You have started to work. You will not be able to do anything until you have finished.", @"OK", nil, nil);
		}
		else {
			NSRunAlertPanel(@"Error!", @"There was a problem saving your changes. Try restarting the program. If that does not work, please submit a bug report by selecting 'Report a Bug' in the Help menu.", @"OK", nil, nil);
		}
	}
}

- (IBAction)visitRelatives:(id)sender {
	NSRunAlertPanel(@"Your relatives are pleased!", @"Your deceased relatives have enjoyed your company.", @"OK", nil, nil);
}

@end