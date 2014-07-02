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


#define kUpdateCountdownTimer @"kUpdateCountdownTimer"
#define kFinalizeCountdownTimer @"kFinalizeCountdownTimer"



@interface panicButtonUser : NSObject <CLLocationManagerDelegate>{

    
}




-(instancetype)initWithUserID:(NSUInteger)usrID;

-(BOOL)checkIfUserIsRegistered;
-(void)registerNewUser;
-(void)initTimerWithDuration:(NSTimeInterval)timeInterval;
-(void)killCountdown;
-(void)playAlarmSound;
-(void)stopAlarmSoud;
-(void)initLocationManager;




+(id)sharedPanicButtonUser;

@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userEmail;
@property (nonatomic, strong) NSString *userNumber;

@property (nonatomic, strong) NSMutableArray *contacts;


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
