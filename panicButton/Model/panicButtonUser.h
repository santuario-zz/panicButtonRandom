//
//  panicButtonUser.h
//  panicButton
//
//  Created by 3π on 3/12/14.
//  Copyright (c) 2014 3π. All rights reserved.
//


/*
 
 Method to call singeltone
 
panicButtonUser * user = [panicButtonUser sharedPanicButtonUser];

 
 
 */

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>

#define kAppName @"PANIKBTTN"
#define kUpdateCountdownTimer @"kUpdateCountdownTimer"
#define kUpdateContactListTableView @"kUpdateContactListTableView"

#define kFinalizeCountdownTimer @"kFinalizeCountdownTimer"
#define kBackendGeneralURL @"http://panicbutton.randominteractive.net/"

// Backend Services

#define kUserRegistrationBackdroundService @"userRegistration"
#define kUserConfirmationBackdroundService @"userConfirmation"
#define kContactGetBackdroundService @"contactGet"
#define kContactAddBackdroundService @"contactAdd"
#define kContactRemoveBackdroundService @"contactRemove"



@interface panicButtonUser : NSObject <CLLocationManagerDelegate, NSURLConnectionDelegate, UIAlertViewDelegate>{

    
}




-(instancetype)initWithUserID:(NSUInteger)usrID;

-(BOOL)checkIfUserIsRegistered;
-(void)registerNewUserWithName:(NSString*)name email:(NSString*)email andPhone:(NSString*)phone;
-(void)registerNewUserContactInBackendWithName:(NSString*)contactName email:(NSString*)contactEmail andPhone:(NSString*)contactPhone withLowBatAlert:(bool)lowBatAlert andOffRangeAlert:(bool)offRageAlert;
-(void)initTimerWithDuration:(NSTimeInterval)timeInterval;
-(void)killCountdown;
-(void)playAlarmSound;
-(void)stopAlarmSoud;
-(void)initLocationManager;



+(id)sharedPanicButtonUser;



@property (nonatomic, strong) NSMutableArray *contacts;
@property (nonatomic, strong) NSMutableDictionary *userData;


@property (nonatomic) BOOL panicButtonEnable;
@property (nonatomic) BOOL timeOutEnable;
@property (nonatomic) BOOL userExist;

@property (retain, nonatomic) NSTimer * countdownTimer;
@property (nonatomic) int remainingTicks;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSMutableArray *locations;
@property (nonatomic) BOOL locationUpdateEnabled;

@property (nonatomic) UIBackgroundTaskIdentifier backgroundTask;




@end
