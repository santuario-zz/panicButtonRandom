//
//  panicButtonViewController.m
//  panicButton
//
//  Created by 3π on 3/12/14.
//  Copyright (c) 2014 3π. All rights reserved.
//

#import "panicButtonViewController.h"
#import "panicButtonSignUpViewController.h"
#import "panicButtonUser.h"



@interface panicButtonViewController ()

   @property (nonatomic) BOOL panicButton;
   @property (nonatomic) BOOL timeout;
    
@end

@implementation panicButtonViewController
    
@synthesize panicButtonContainerView, panicButtonView, panicButtonSettiingsView;
@synthesize timeoutContainerView, timeoutView, timeoutSetiingsView;
@synthesize timeCounterDatePicker, timeoutCountLabel, handleTimeCounterButton;
@synthesize panicButton, timeout;


#pragma mark -
#pragma mark Life Cycle Methods
#pragma mark -


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self initialize];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark -
#pragma mark  Methods
#pragma mark -

-(void)initialize{
    
    panicButton = YES;
    timeout = YES;


    [self performSelector:@selector(initPanicButtonApp) withObject:nil afterDelay:0.5];

    
}


-(void)initializeNotificationCenter{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateTimeoutCounter:)
                                                 name:kUpdateCountdownTimer
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(finalizeCountdown:)
                                                 name:kFinalizeCountdownTimer
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dismissSignUpView:)
                                                 name:kDismissSignUpView
                                               object:nil];



}

-(void)initPanicButtonApp
{
    
    /*
    panicButtonSignUpViewController *panicButtonSignUp = (panicButtonSignUpViewController*)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"panicButtonSignUp"];
    [self presentViewController:panicButtonSignUp animated:YES completion:nil];
*/
    
    [self initializeNotificationCenter];
    [self initializeSwipeActions];
    [self initializeTimeoutDatePicker];
    [self initiaizeTextFields];
    [[panicButtonUser sharedPanicButtonUser] initLocationManager];

    
    if ([[panicButtonUser sharedPanicButtonUser] checkIfUserIsRegistered]) {
        NSLog(@"USUARIO REGISTRADO");
        
        [self setupLogoAnimationWithDelay:0.1];


    }else{
        
        [self presentSignUpView];
        
    }
    
    
    
    
}

-(void)presentSignUpView{
    panicButtonSignUpViewController *panicButtonSignUp = (panicButtonSignUpViewController*)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"panicButtonSignUp"];
    
    // present
    [self presentViewController:panicButtonSignUp animated:NO completion:nil];
    
    // dismiss
    //[self dismissViewControllerAnimated:YES completion:nil];
}


-(void)dismissSignUpView:(NSNotification *)notification
{
    NSLog(@"dismissSignUpView");
    //[self locateLogoWithoutAnimation];
    //[self performSelector:@selector(dismissSignUpViewFromViewController) withObject:nil afterDelay:2.5];
    [self dismissSignUpViewFromViewController];
}

-(void)dismissSignUpViewFromViewController{
    NSLog(@"dismissSignUpViewFromViewController");

    [self dismissViewControllerAnimated:YES completion:^{ [self setupLogoAnimationWithDelay:1.0]; }];
    //[self dismissViewControllerAnimated:YES completion:nil];

}


#pragma mark -
#pragma mark Logo Animation Methods
#pragma mark -

-(void)setupLogoAnimationWithDelay:(float)delay{
    
    self.logoHandShadowImageView.alpha = 0.0;

    [self performSelector:@selector(initLogoAnimation) withObject:nil afterDelay:delay];
}

-(void)initLogoAnimation{
    
    self.logoHandShadowImageView.alpha = 0.0;

    [UIView animateWithDuration:0.5 animations:^{
        [self.logoBackgroundImageView setFrame:CGRectMake(9.5, 4, 179, 194)];
        [self.logoHandImageView setFrame:CGRectMake(53, 53, 90, 108)];

        }
                     completion:^(BOOL finished){[self initIconAnimation];}];
}


-(void)initIconAnimation{
    [UIView animateWithDuration:0.2 animations:^{
        self.logoHandShadowImageView.alpha = 1.0;
        }
                     completion:^(BOOL finished){[self LogoAnimationComplete];}];
    
}

-(void)LogoAnimationComplete{
    
}

-(void)locateLogoWithoutAnimation{
    NSLog(@"locateLogoWithoutAnimation");

    self.logoHandShadowImageView.alpha = 1.0;
    [self.logoBackgroundImageView setFrame:CGRectMake(9.5, 4, 179, 194)];
    [self.logoHandImageView setFrame:CGRectMake(53, 53, 90, 108)];
    self.logoHandShadowImageView.alpha = 1.0;


}


#pragma mark -
#pragma mark  Action Buttons Methods
#pragma mark -


- (IBAction)sendPanic:(UIButton *)sender {
    
    NSLog(@"P A N I C");
}


- (IBAction)startTimeout:(UIButton *)sender {
    
    
    if (sender.isSelected) {
        [self killCountDown];
        [[panicButtonUser sharedPanicButtonUser] stopAlarmSoud]; // FIX THIS

        
    }else{
        [self initCountdown];

    }
    
    
}


#pragma mark -
#pragma mark  Timeout Methods
#pragma mark -


-(void)getTimerCount{

    [[panicButtonUser sharedPanicButtonUser] initTimerWithDuration:timeCounterDatePicker.countDownDuration];
    
    //NSLog(@" DATA PICKER :: %f",timeCounterDatePicker.countDownDuration);

}






-(void)updateTimeoutCounter:(NSNotification *)notification
{
    handleTimeCounterButton.selected = YES;
    timeCounterDatePicker.alpha = 0.0;
    timeoutCountLabel.alpha = 1.0;
    timeoutCountLabel.text = [NSString stringWithFormat:@"%@",[notification object]];
}


-(void)initCountdown{
    
    handleTimeCounterButton.selected = YES;
    [UIView beginAnimations: @"initCountdown" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: 0.3];
    timeCounterDatePicker.alpha = 0.0;
    timeoutCountLabel.alpha = 1.0;
    [UIView commitAnimations];
    [self.dataPicerkBackgroundImageView setImage:[UIImage imageNamed:@"backgroundCounterOn"]];
    [self getTimerCount];

    
}

-(void)finalizeCountdown:(NSNotification *)notification{
    
    
    handleTimeCounterButton.selected = NO;

    
    [UIView beginAnimations: @"finalizeCountdown" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: 0.3];
    timeCounterDatePicker.alpha = 1.0;
    timeoutCountLabel.alpha = 0.0;
    [UIView commitAnimations];
    [self.dataPicerkBackgroundImageView setImage:[UIImage imageNamed:@"backgroundCounter"]];

    
    
}

-(void)killCountDown{
    [[panicButtonUser sharedPanicButtonUser] killCountdown];

}

   
#pragma mark -
#pragma mark Swipe Action Methods
#pragma mark -
    

-(void)initializeSwipeActions{
    
    // Panic Button View
    UISwipeGestureRecognizer *swipeToShowSettings = [[UISwipeGestureRecognizer alloc]
                                       initWithTarget:self action:@selector(showPanicButtonSettings)];
    swipeToShowSettings.numberOfTouchesRequired = 1;
    swipeToShowSettings.direction = UISwipeGestureRecognizerDirectionRight;
    [panicButtonContainerView addGestureRecognizer:swipeToShowSettings];
    
    UISwipeGestureRecognizer *swipeToHideSettings = [[UISwipeGestureRecognizer alloc]
                                                     initWithTarget:self action:@selector(hidePanicButtonSettings)];
    swipeToHideSettings.numberOfTouchesRequired = 1;
    swipeToHideSettings.direction = UISwipeGestureRecognizerDirectionLeft ;
    [panicButtonContainerView addGestureRecognizer:swipeToHideSettings];
    
    // Timeout View
    
    UISwipeGestureRecognizer *swipeToShowTimeoutSettings = [[UISwipeGestureRecognizer alloc]
                                                     initWithTarget:self action:@selector(showTimeoutSettings)];
    swipeToShowTimeoutSettings.numberOfTouchesRequired = 1;
    swipeToShowTimeoutSettings.direction = UISwipeGestureRecognizerDirectionRight;
    [timeoutContainerView addGestureRecognizer:swipeToShowTimeoutSettings];
    
    UISwipeGestureRecognizer *swipeToHideTimeoutSettings = [[UISwipeGestureRecognizer alloc]
                                                     initWithTarget:self action:@selector(hideTimeoutSettings)];
    swipeToHideTimeoutSettings.numberOfTouchesRequired = 1;
    swipeToHideTimeoutSettings.direction = UISwipeGestureRecognizerDirectionLeft ;
    [timeoutContainerView addGestureRecognizer:swipeToHideTimeoutSettings];
    
    
    
    
    
}


-(void)showPanicButtonSettings{
    
    
    if (panicButton == YES){
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:kFLIP_ANIMAMTION_TIME];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:panicButtonContainerView cache:YES];
        [panicButtonContainerView sendSubviewToBack:panicButtonView];
        [UIView commitAnimations];
    }
    
    panicButton = NO;
    [self endTextFieldEditing];

    
}

-(void)hidePanicButtonSettings{

    
    if (panicButton == NO){
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:kFLIP_ANIMAMTION_TIME];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:panicButtonContainerView cache:YES];
        [panicButtonContainerView sendSubviewToBack:panicButtonSettiingsView];
        [UIView commitAnimations];
    }
    
    panicButton = YES;
    [self endTextFieldEditing];


}



-(void)showTimeoutSettings{
    
    
    if(timeout == YES){
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:kFLIP_ANIMAMTION_TIME];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:timeoutContainerView cache:YES];
        [timeoutContainerView sendSubviewToBack:timeoutView];
        [UIView commitAnimations];
    }
    
    timeout = NO;
    [self endTextFieldEditing];

    
}


-(void)hideTimeoutSettings{
    

    
    if(timeout == NO){
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:kFLIP_ANIMAMTION_TIME];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:timeoutContainerView cache:YES];
        [timeoutContainerView sendSubviewToBack:timeoutSetiingsView];
        [UIView commitAnimations];
    }
    
    timeout = YES;
    [self endTextFieldEditing];

    
}

#pragma mark -
#pragma mark Date Picker Delegate Methods
#pragma mark -




-(void)initializeTimeoutDatePicker{
    
    timeCounterDatePicker.alpha = 1.0;
    timeoutCountLabel.alpha = 0.0;
    self.handleTimeCounterButton.titleLabel.font = [UIFont fontWithName:kZagRegular size:27];
    timeoutCountLabel.font = [UIFont fontWithName:kZagBold size:80];
    
    [timeCounterDatePicker setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [timeCounterDatePicker setCountDownDuration:(30 * 60)];

}


 
#pragma mark -
#pragma mark Text Field Delegate Methods
#pragma mark -


-(void)initiaizeTextFields{
    
    

    self.panicButtonMessageTextField.delegate = self;
    
    self.panicButtonMessageTextField.font = [UIFont fontWithName:kZagRegular size:20];
    [self.panicButtonMessageTextField setTextColor:RGBUIColor(245, 69, 74,1)];
    self.panicButtonMessageTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"message" attributes:@{NSForegroundColorAttributeName: RGBUIColor(245, 69, 74,0.3)}];
    
    self.timeoutMessageTextField.delegate = self;
    
    self.timeoutMessageTextField.font = [UIFont fontWithName:kZagRegular size:20];
    [self.timeoutMessageTextField setTextColor:RGBUIColor(245, 69, 74,1)];
    self.timeoutMessageTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"message" attributes:@{NSForegroundColorAttributeName: RGBUIColor(245, 69, 74,0.3)}];
    
    
}

-(void)endTextFieldEditing{
    
    [self.panicButtonMessageTextField endEditing:YES];
    [self.timeoutMessageTextField endEditing:YES];


}

- (IBAction)textFieldReturn:(UITextField *)sender {
    
    [sender resignFirstResponder];
}


-(BOOL) textFieldShouldReturn: (UITextField *) textField {
    [textField resignFirstResponder];
    return YES;
}
    

    
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    //NSLog(@"textFieldDidBeginEditing");
    [self moveForKeyboardView:timeoutContainerView up:YES];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    //NSLog(@"textFieldDidEndEditing");
    [self moveForKeyboardView:timeoutContainerView up:NO];

}


-(void)moveForKeyboardView:(UIView*)view up:(BOOL)up
{
    const int movementDistance = -130;
    const float movementDuration = 0.3f;
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"moveForKeyboardView" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}




@end
