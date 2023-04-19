/* DataController */

#import <Cocoa/Cocoa.h>

@interface DataController : NSObject
{
    IBOutlet id startWindow;
    IBOutlet id loadProfile;
	
    IBOutlet id loadingWindow;
    IBOutlet id loadingBar;

	IBOutlet id newProfileWindow;	
    IBOutlet id name;
	IBOutlet id gender;

    IBOutlet id profileWindow;
	IBOutlet id profileList;
	IBOutlet id deleteProfileButton;
	IBOutlet id renameProfileButton;
	
	IBOutlet id storyWindow;
	IBOutlet id storyBox;

	IBOutlet id valuesAge;
	IBOutlet id valuesTimeStarted;
	IBOutlet id valuesPrayedtoday;
	IBOutlet id valuesWages;

    IBOutlet id mainWindow;
    IBOutlet id bankDisplay;
    IBOutlet id cashDisplay;
    IBOutlet id healthDisplay;
	
	IBOutlet id statsName;	
	IBOutlet id statsLevel;
	IBOutlet id statsRank;
	IBOutlet id statsGender;
	IBOutlet id statsAge;
	IBOutlet id statsCreation;
	IBOutlet id statsStrength;
	IBOutlet id statsDefense;
	IBOutlet id statsAgility;
	IBOutlet id statsStamina;
	IBOutlet id statsDexterity;
	IBOutlet id statsAlignment;
	IBOutlet id statsExperience;
	IBOutlet id statsExperienceNum;
	IBOutlet id statsExperienceNextLevel;
	IBOutlet id statsBlood;
	IBOutlet id statsBloodNum;
	IBOutlet id statsVictims;
	IBOutlet id statsKills;
	IBOutlet id statsBattles;
	IBOutlet id statsDamageFromEnemies;
	IBOutlet id statsDamageToEnemies;
	IBOutlet id statsCharacterStatus;
	
	IBOutlet id bankDepositBox;
	IBOutlet id bankWithdrawBox;
	
	IBOutlet id graveyardWorkHours;
	
	NSMutableDictionary *profileInfo;
	
	NSString *profileName;
}

- (IBAction)tableViewSelected:(id)sender;
- (IBAction)loadProfile:(id)sender;
- (NSMutableDictionary *)loadDataFromList;
- (IBAction)loadStats:(id)sender;

- (IBAction)manageTableViewSelected:(id)sender;
- (IBAction)deleteProfile:(id)sender;
- (IBAction)renameProfile:(id)sender;
- (bool)updateProfile:(NSDictionary*)profile;

- (IBAction)createNewProfile:(id)sender;
- (NSString *)pathForNewProfile;

- (void)openLoadingWindow;
- (void)closeLoadingWindow;
- (void)openMainWindow:(NSDictionary*)profileInfoLoc;
- (void)openNewStory:(NSString*)story;

- (IBAction)prayToGod:(id)sender;
- (IBAction)prayToSatan:(id)sender;

- (IBAction)deposit:(id)sender;
- (IBAction)withdraw:(id)sender;

- (IBAction)work:(id)sender;
- (IBAction)visitRelatives:(id)sender;

@end
