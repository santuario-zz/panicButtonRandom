//
//  panicButtonUser.m
//  panicButton
//
//  Created by 3π on 3/12/14.
//  Copyright (c) 2014 3π. All rights reserved.
//

#import "panicButtonUser.h"

@interface panicButtonUser(){
    SystemSoundID mBeep;
    AVAudioPlayer *audioPlayer;
    NSMutableData *_responseData;
    NSURLConnection * backendConnection;
    
}

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userEmail;
@property (nonatomic, strong) NSString *userPhone;
@property (nonatomic, strong) NSString *userSession;
@property (nonatomic, strong) NSString *userCountryID;
@property (nonatomic, strong) NSString *userDeviceModel;
@property (nonatomic, strong) NSString *userOS;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSMutableDictionary *lastContactInfoDictionary;



@end

@implementation panicButtonUser

@synthesize countdownTimer, remainingTicks, userData;
@synthesize userName,userEmail,userPhone,userSession,userCountryID,userDeviceModel,userOS,userID;



#pragma mark -
#pragma mark Lazy Instantiation Methods
#pragma mark -

// Lazy instantiation of Contacts Array
-(NSMutableArray *) contacts{
    if(!_contacts) _contacts = [[NSMutableArray alloc] initWithArray:[userData objectForKey:@"userContacts"]]; // FIX ME
    return _contacts;
}


-(NSMutableArray *) locations{
    if(!_locations) _locations = [[NSMutableArray alloc] init];
    return _locations;
}


#pragma mark -
#pragma mark Singleton Methods
#pragma mark -



+(id)sharedPanicButtonUser{
    static panicButtonUser *sharedMyPanicButtonUser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        sharedMyPanicButtonUser = [[self alloc] init];
    });
    
    return sharedMyPanicButtonUser;
}

-(id)init{
    
    if(self = [super init]){
        //[self checkIfUserIsRegistered];
        _responseData = [[NSMutableData alloc] init];
        userData = [[NSMutableDictionary alloc] init];
        _lastContactInfoDictionary = [[NSMutableDictionary alloc] init];

    }
    
    return self;
}

-(instancetype)initWithUserID:(NSUInteger)usrID{
    
    self = [super init];
    
    if(self){
        //[self checkIfUserIsRegistered];
    }
    
    return self;
}


-(void)dealloc{
    
}


#pragma mark -
#pragma mark Panic Button USER Methods
#pragma mark -

-(BOOL)checkIfUserIsRegistered{
    
    NSLog(@"panicButtonUser :: checkIfUserIsRegistered");

    BOOL isRegistered = NO;
    
    NSFileManager *filemgr;
    NSString *dataFile;
    NSString *docsDir;
    NSArray *dirPaths;
    
    filemgr = [NSFileManager defaultManager];
    
    // Identify the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the data file
    dataFile = [docsDir stringByAppendingPathComponent: @"userFile.txt"];
    
    // Check if the file already exists
    if ([filemgr fileExistsAtPath: dataFile])
    {
        // Read file contents and display in textBox
        NSData *databuffer;
        databuffer = [filemgr contentsAtPath: dataFile];
        NSError *myError = nil;
        NSDictionary *userFileDictionary = [NSJSONSerialization JSONObjectWithData:databuffer options:NSJSONReadingMutableLeaves error:&myError];
        userData = [[NSMutableDictionary alloc] initWithDictionary:userFileDictionary];
        

        
        NSString *datastring = [[NSString alloc] initWithData: databuffer encoding:NSASCIIStringEncoding];
        
        //NSLog(@"datastring :: %@",datastring);
        NSLog(@"userData :: %@",userData);
        isRegistered = YES;
        
    }
    
    return isRegistered;
}

-(void)saveUserDataInDevice{
    
    NSString *someText = @"{'userName':'','userEmail':'','userPhone':'','userSession':'','userCountryID':'','userDeviceModel':'','userOS':'','userID':'','userContacts':[{'userContactID':'','userContactName':'','userContactEmail':'','userContactPhone':'','userContactReceivesLowBatAlert':'','userContactReceivesRangeAlert':''}]}";
    
    someText = [someText stringByReplacingOccurrencesOfString:@"'" withString:@"\""];
    
    NSError *error = nil;
    
    NSString *path = [[self applicationDocumentsDirectory].path
                      stringByAppendingPathComponent:@"userFile.txt"];
    
    BOOL succeeded = [someText writeToFile:path atomically:YES
                                  encoding:NSUTF8StringEncoding error:nil];
    
    if (succeeded) {
        NSLog(@"Success at: %@",path);
    } else {
        NSLog(@"Failed to store. Error: %@",error);
    }
}

-(void)saveUserDataDictionaryInDevice{
    NSData *data = [NSJSONSerialization dataWithJSONObject:userData
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:data
                                              encoding:NSUTF8StringEncoding];
    
    NSError *error = nil;
    
    NSString *path = [[self applicationDocumentsDirectory].path
                      stringByAppendingPathComponent:@"userFile.txt"];
    
    BOOL succeeded = [jsonStr writeToFile:path atomically:YES
                                  encoding:NSUTF8StringEncoding error:nil];
    
    if (succeeded) {
        NSLog(@"Success at: %@",path);
    } else {
        NSLog(@"Failed to store. Error: %@",error);
    }
}

-(void)registerNewUserWithName:(NSString*)name email:(NSString*)email andPhone:(NSString*)phone{
    
    [self saveUserDataInDevice];
    [self registerNewUserInBackendWithName:name email:email andPhone:phone];
    
}

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                   inDomains:NSUserDomainMask] lastObject];
}



#pragma mark -
#pragma mark Timer Methods
#pragma mark -



-(void)initTimerWithDuration:(NSTimeInterval)timeInterval{
    
    
    self.backgroundTask = UIBackgroundTaskInvalid;
    
    //int hours = (int)(timeInterval/3600.0f);
    //int minutes = ((int)timeInterval - (hours * 3600))/60;
    
    
    //NSLog(@"PANIC BUTTON TIME = %f ::: %d  | %d", timeInterval, hours, minutes);
    
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    //localNotification.fireDate = pickerDate;
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:timeInterval];
    localNotification.alertBody = @"Countdown Timer";
    localNotification.alertAction = @"desactivar el Timer";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    
    
    if (countdownTimer)
        return;
    
    remainingTicks = timeInterval;
    [self updateTimeout];
    
    countdownTimer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target: self selector: @selector(handleTimerTick) userInfo: nil repeats: YES];
    
    
    self.backgroundTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        NSLog(@"Background handler called. Not running background tasks anymore.");
        [[UIApplication sharedApplication] endBackgroundTask:self.backgroundTask];
        self.backgroundTask = UIBackgroundTaskInvalid;
    }];
    
}



-(void)handleTimerTick
{

    remainingTicks--;
    [self updateTimeout];
    
    if (remainingTicks <= 0) {
        [countdownTimer invalidate];
        countdownTimer = nil;
        [self playAlarmSound];
        [[NSNotificationCenter defaultCenter] postNotificationName:kFinalizeCountdownTimer object:[NSString stringWithFormat:@"00:00"]];
        
        if (self.backgroundTask != UIBackgroundTaskInvalid)
        {
            [[UIApplication sharedApplication] endBackgroundTask:self.backgroundTask];
            self.backgroundTask = UIBackgroundTaskInvalid;
        }

    }
    
    
    
}

-(void)updateTimeout{
    
   // NSLog(@"INIT TIMER :: updateTimeout :: %d", remainingTicks);
    int hours = (int)(remainingTicks/3600.0f);
    int minutes = ((int)remainingTicks - (hours * 3600))/60;
    
    
    NSLog(@"PANIC BUTTON TIME = %d ::: %d  | %d", remainingTicks, hours, minutes);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateCountdownTimer object:[NSString stringWithFormat:@"%d",remainingTicks]];

}


-(void)killCountdown{
    
    [countdownTimer invalidate];
    countdownTimer = nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:kFinalizeCountdownTimer object:[NSString stringWithFormat:@"00:00"]];
    if (self.backgroundTask != UIBackgroundTaskInvalid)
    {
        [[UIApplication sharedApplication] endBackgroundTask:self.backgroundTask];
        self.backgroundTask = UIBackgroundTaskInvalid;
    }
}

-(void)playAlarmSound{
    
    [self playSoundFXnamed:@"alarm.mp3" Loop: YES];
    /*
    
    // Create the sound ID
    NSString* path = [[NSBundle mainBundle]
                      pathForResource:@"beep" ofType:@"aiff"];
    NSURL* url = [NSURL fileURLWithPath:path];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &mBeep);
    
    // Play the sound
    AudioServicesPlaySystemSound(mBeep);
     */

}

-(void)stopAlarmSoud{
    
    
    // Dispose of the sound
    //AudioServicesDisposeSystemSoundID(mBeep);
    
    [audioPlayer stop];
}

-(BOOL) playSoundFXnamed: (NSString*) vSFXName Loop: (BOOL) vLoop
{
    NSError *error;
    
    NSBundle* bundle = [NSBundle mainBundle];
    
    NSString* bundleDirectory = (NSString*)[bundle bundlePath];
    
    NSURL *url = [NSURL fileURLWithPath:[bundleDirectory stringByAppendingPathComponent:vSFXName]];
    
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    if(vLoop)
        audioPlayer.numberOfLoops = -1;
    else
        audioPlayer.numberOfLoops = 0;
    
    BOOL success = YES;
    
    if (audioPlayer == nil)
    {
        success = NO;
    }
    else
    {
        success = [audioPlayer play];
    }
    return success;
}



#pragma mark -
#pragma mark Bluetooth Methods
#pragma mark -

-(void)initBluettothConnection{
    
}



#pragma mark -
#pragma mark Location Manager Methods
#pragma mark -

-(void)initLocationManager{
    
    //self.locations;
    self.locationUpdateEnabled = YES;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.delegate = self;
    
    
    const CLLocationAccuracy accuracyValues[] = {
        kCLLocationAccuracyBestForNavigation,
        kCLLocationAccuracyBest,
        kCLLocationAccuracyNearestTenMeters,
        kCLLocationAccuracyHundredMeters,
        kCLLocationAccuracyKilometer,
        kCLLocationAccuracyThreeKilometers};
    
    
    self.locationManager.desiredAccuracy = accuracyValues[0]; // FIX ME
    
    
    [self enabledStateLocationChanged];
    
    
    
    
}


-(void)enabledStateLocationChanged{
    
    if (self.locationUpdateEnabled)
    {
        [self.locationManager startUpdatingLocation];
    }
    else
    {
        [self.locationManager stopUpdatingLocation];
    }
}



- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{

    [self.locations addObject:newLocation];
    
    // Remove values if the array is too big
    while (self.locations.count > 100)
    {
        [self.locations removeObjectAtIndex:0];
    }
    
    if (UIApplication.sharedApplication.applicationState == UIApplicationStateActive)
    {
        //NSLog(@"App active. New location is %@", newLocation);
    }
    else
    {
        //NSLog(@"App is backgrounded. New location is %@", newLocation);
    }
}



#pragma mark -
#pragma mark Backend Methods
#pragma mark -


-(void)registerNewUserInBackendWithName:(NSString*)name email:(NSString*)email andPhone:(NSString*)phone{

    // arc4random() % 50
    
    NSString * UUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    UIDevice *currentDevice = [UIDevice currentDevice];
    NSString *model = [currentDevice model];
    NSString *systemVersion = [currentDevice systemVersion];
    NSArray *languageArray = [NSLocale preferredLanguages];
    NSString *language = [languageArray objectAtIndex:0];
    NSLocale *locale = [NSLocale currentLocale];
    NSString *country = [locale localeIdentifier];
    NSString *appVersion = [[NSBundle mainBundle]
                            objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    
    //NSString *deviceSpecs = [NSString stringWithFormat:@"%@ - %@ - %@ - %@ - %@ - %@",model, systemVersion, language, country, appVersion, UUID];
    
    //NSLog(@"Device Specs --> %@",deviceSpecs);
    
    userName = name;
    userEmail = email;
    userPhone = phone;
    userCountryID = country;
    userDeviceModel = model;
    userOS =systemVersion;
    
    NSString *dataString =[NSString stringWithFormat:@"{'fullname':'%@','mobile':'5500000000%@','email':'%@','country_id':'%d','model':'%@','os':'%@','serial':'XXXXXX-%@'}",name,phone,email,1,model,systemVersion,UUID]; // FIXME
    
    [self initBackendRequestWithService:kUserRegistrationBackdroundService session:nil andDataString:dataString];
    
}

-(void)registerNewUserContactInBackendWithName:(NSString*)contactName email:(NSString*)contactEmail andPhone:(NSString*)contactPhone withLowBatAlert:(bool)lowBatAlert andOffRangeAlert:(bool)offRageAlert{

    
    NSString *dataString =[NSString stringWithFormat:@"{'uid':'%@','fullname':'%@','mobile':'%@','email':'%@','receivesLowBatAlert':%d,'receivesRangeAlert':%d}",[userData objectForKey:@"userID"],contactName,contactPhone,contactEmail,lowBatAlert,offRageAlert];
    
    //NSLog(@"NEW USER :: %@",dataString);
    
    [_lastContactInfoDictionary setObject:contactEmail forKey:@"userContactEmail"];
    [_lastContactInfoDictionary setObject:contactName forKey:@"userContactName"];
    [_lastContactInfoDictionary setObject:contactPhone forKey:@"userContactPhone"];
    [_lastContactInfoDictionary setObject:[NSString stringWithFormat:@"%d",lowBatAlert] forKey:@"userContactReceivesLowBatAlert"];
    [_lastContactInfoDictionary setObject:[NSString stringWithFormat:@"%d",offRageAlert] forKey:@"userContactReceivesRangeAlert"];
    
    
    NSLog(@"NEW _lastContactInfoDictionary :: %@",_lastContactInfoDictionary);
    
    [self initBackendRequestWithService:kContactAddBackdroundService session:[userData objectForKey:@"userSession"] andDataString:dataString];
}



-(void)initBackendRequestWithService:(NSString *)serviceString session:(NSString *)session andDataString:(NSString *)dataString{
    
    NSString *url;
    
    if (session == nil) {
        url = [[NSString stringWithFormat:@"%@index.php?r=app/index&data={'service':'%@','data':%@}",kBackendGeneralURL,serviceString, dataString] stringByReplacingOccurrencesOfString:@"'" withString:@"\""];
    }else{
        url = [[NSString stringWithFormat:@"%@index.php?r=app/index&data={'session':'%@','service':'%@','data':%@}",kBackendGeneralURL,session,serviceString, dataString] stringByReplacingOccurrencesOfString:@"'" withString:@"\""];
    }
    
    
    
    
    NSString *encodedUrl = [url stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    NSLog(@"URL - %@", encodedUrl);              // Checking the url
    
    NSMutableURLRequest *theRequest= [NSMutableURLRequest requestWithURL:[NSURL URLWithString:encodedUrl]
                                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                         timeoutInterval:10.0];
    
    backendConnection =[[NSURLConnection alloc] initWithRequest:theRequest delegate:self startImmediately:YES];


    
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    [_responseData setLength:0];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    
    //NSLog(@"Succeeded! Received %d bytes of data",[_responseData length]);
    NSError *myError = nil;
    NSDictionary *responseData = [NSJSONSerialization JSONObjectWithData:_responseData options:NSJSONReadingMutableLeaves error:&myError];
    
    
    if ([[responseData objectForKey:@"status"] isEqualToString:@"OK"]) {
        [self didBackgroundResponseIsSuccessfulWithDictionaryData:responseData];
    }else{
        [self didBackgroundResponseContainsErrorWithDictionaryData:responseData];
    }
    
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"ResponseData didFailWithError: %@",error);
    
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:kAppName
                                                      message:@"Comprueba tu conexión y vuelve a intertarlo"
                                                     delegate:self
                            
                                            cancelButtonTitle:@"Volver a intentar"
                                            otherButtonTitles:nil];
    [message show];

}




- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Volver a intentar"])
    {
        [backendConnection start];
    }
    
}


-(void)didBackgroundResponseIsSuccessfulWithDictionaryData:(NSDictionary *)responseData{
    
    NSLog(@"didBackgroundResponseIsSuccessfulWithDictionaryData : %@",responseData);

    
    if ([[responseData objectForKey:@"service"] isEqualToString:kUserRegistrationBackdroundService]) {
        
        [userData setObject:[[responseData objectForKey:@"data"] objectForKey:@"uid"] forKey:@"userID"];
        [userData setObject:[responseData objectForKey:@"session"] forKey:@"userSession"];
        
        [userData setObject:userCountryID forKey:@"userCountryID"];
        [userData setObject:userDeviceModel forKey:@"userDeviceModel"];
        [userData setObject:userEmail forKey:@"userEmail"];
        [userData setObject:userName forKey:@"userName"];
        [userData setObject:userOS forKey:@"userOS"];
        [userData setObject:userPhone forKey:@"userPhone"];
        
    }else if ([[responseData objectForKey:@"service"] isEqualToString:kUserConfirmationBackdroundService]){
        
    }else if ([[responseData objectForKey:@"service"] isEqualToString:kContactGetBackdroundService]){
        
    }else if ([[responseData objectForKey:@"service"] isEqualToString:kContactAddBackdroundService]){
        
        [_contacts addObject:@{@"userContactEmail":[_lastContactInfoDictionary objectForKey:@"userContactEmail"],@"userContactID":[[responseData objectForKey:@"data"] objectForKey:@"cid"],@"userContactName":[_lastContactInfoDictionary objectForKey:@"userContactName"],@"userContactPhone":[_lastContactInfoDictionary objectForKey:@"userContactPhone"],@"userContactReceivesLowBatAlert":[_lastContactInfoDictionary objectForKey:@"userContactReceivesLowBatAlert"],@"userContactReceivesRangeAlert":[_lastContactInfoDictionary objectForKey:@"userContactReceivesRangeAlert"]}];
        [userData setObject:_contacts forKey:@"userContacts"];
        [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateContactListTableView object:nil];

        
    }else if ([[responseData objectForKey:@"service"] isEqualToString:kContactRemoveBackdroundService]){
        
    }
    
    [self saveUserDataDictionaryInDevice];
    
    
}

-(void)didBackgroundResponseContainsErrorWithDictionaryData:(NSDictionary *)dictionaryData{
    
    NSLog(@"didBackgroundResponseContainsErrorWithDictionaryData : %@",dictionaryData);

}




@end
