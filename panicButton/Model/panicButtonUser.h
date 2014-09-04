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

// General

#define kAppName @"PANIKBTTN"
#define kUpdateCountdownTimer @"kUpdateCountdownTimer"
#define kUpdateContactListTableView @"kUpdateContactListTableView"

#define kFinalizeCountdownTimer @"kFinalizeCountdownTimer"
#define kBackendGeneralURL @"http://panicbutton.randominteractive.net/"
#define kDismissSignUpView @"kDismissSignUpView"

// Backend Services

#define kUserRegistrationBackdroundService @"userRegistration"
#define kUserConfirmationBackdroundService @"userConfirmation"
#define kContactGetBackdroundService @"contactGet"
#define kContactAddBackdroundService @"contactAdd"
#define kContactRemoveBackdroundService @"contactRemove"
#define kSendLocationBackdroundService @"locationSet"


// Strings Messages

#define kErrorConnectionMessageString @"Try again" // No hay conexión AlertView
#define kErrorIncompleteTextFields @"You must fill out all required data" // OK
#define kErrorCloseButtonIncompleteTextFields @"OK" // OK
#define kSendCodeRegistrationButtonString @"Send code" // Botón Mandar Code AlertView
#define kSendCodeRegistrationMessageString @"Enter your registration code" // Mensaje Code AlertView
#define kInternetConnectionFailedMessage @"Comprueba tu conexión y vuelve a intertarlo"

// UI


#define RGBUIColor(r, g, b,a)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:a]

#define kZagRegular @"ZagRegular"

#define kZagBold @"ZagBold"



@interface panicButtonUser : NSObject <CLLocationManagerDelegate, NSURLConnectionDelegate, UIAlertViewDelegate, UITextFieldDelegate>{

    
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
-(void)showAlertViewWithMessage:(NSString *)messageString cancelButtonTitle:(NSString *)cancelString textField:(BOOL)isTextField andActivityIndicator:(BOOL)isActivityIndicator;
-(void)deleteUserContactInBackendWithID:(NSString*)contactID;
-(void)sendLocationInBackedWithLongitud:(double)longitud latitud:(double)latitud andCourse:(double)course;


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
