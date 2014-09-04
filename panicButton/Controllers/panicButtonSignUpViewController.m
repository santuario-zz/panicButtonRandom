//
//  panicButtonSignUpViewController.m
//  panicButton
//
//  Created by 3π on 3/12/14.
//  Copyright (c) 2014 3π. All rights reserved.
//

#import "panicButtonSignUpViewController.h"
#import "panicButtonUser.h"

@interface panicButtonSignUpViewController ()

@end

@implementation panicButtonSignUpViewController


#pragma mark -
#pragma mark Life Cycle Methods
#pragma mark -


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self initialize];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark Sign Up Methods
#pragma mark -


-(void)initialize{
    
    NSLog(@"panicButtonSignUpViewController initialize");
    
    [self initiaizeTextFields];
    [self setupLogoAnimation];

    
}

-(void)initiaizeTextFields{
    
    /*
    for (NSString* family in [UIFont familyNames])
    {
        NSLog(@"%@", family);
        
        for (NSString* name in [UIFont fontNamesForFamilyName: family])
        {
            NSLog(@"  %@", name);
        }
    }
     */
    
    self.registerButton.titleLabel.font = [UIFont fontWithName:kZagRegular size:25];
    
    
    self.userEmailTextField.delegate = self;
    self.userNameTextField.delegate = self;
    self.userPhoneTextField.delegate = self;
    
    self.userNameTextField.font = [UIFont fontWithName:kZagRegular size:20];    
    [self.userNameTextField setTextColor:RGBUIColor(245, 69, 74,1)];
    self.userNameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"   name" attributes:@{NSForegroundColorAttributeName: RGBUIColor(245, 69, 74,0.3)}];
    
    self.userEmailTextField.font = [UIFont fontWithName:kZagRegular size:20];
    [self.userEmailTextField setTextColor:RGBUIColor(245, 69, 74,1)];
    self.userEmailTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"   e-mail" attributes:@{NSForegroundColorAttributeName: RGBUIColor(245, 69, 74,0.3)}];
    
    self.userPhoneTextField.font = [UIFont fontWithName:kZagRegular size:20];
    [self.userPhoneTextField setTextColor:RGBUIColor(245, 69, 74,1)];
    self.userPhoneTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"   phone" attributes:@{NSForegroundColorAttributeName: RGBUIColor(245, 69, 74,0.3)}];
    
    self.adviceLabel.font = [UIFont fontWithName:kZagRegular size:14];
    self.signInLabel.font = [UIFont fontWithName:kZagRegular size:26];
    [self.signInLabel setTextColor:RGBUIColor(245, 69, 74,1)];
    
}



#pragma mark -
#pragma mark Logo Animation Methods
#pragma mark -

-(void)setupLogoAnimation{
    
    self.logoHandShadowImageView.alpha = 0.0;
    
    [self performSelector:@selector(initLogoAnimation) withObject:nil afterDelay:1.0];
}

-(void)initLogoAnimation{
    
    
    [UIView animateWithDuration:0.7 animations:^{
        [self.logoBackgroundImageView setFrame:CGRectMake(9.5, 4, 179, 194)];
        [self.logoHandImageView setFrame:CGRectMake(53, 53, 90, 108)];
        
    }
                     completion:^(BOOL finished){[self initIconAnimation];}];
}


-(void)initIconAnimation{
    [UIView animateWithDuration:0.3 animations:^{
        self.logoHandShadowImageView.alpha = 1.0;
    }
                     completion:^(BOOL finished){[self LogoAnimationComplete];}];
    
}

-(void)LogoAnimationComplete{
    
}



#pragma mark -
#pragma mark Action Buttons Methods
#pragma mark -


- (IBAction)registerNewUser:(UIButton *)sender {
    [[panicButtonUser sharedPanicButtonUser] registerNewUserWithName:self.userNameTextField.text email:self.userEmailTextField.text andPhone:self.userPhoneTextField.text];

}

- (IBAction)initUserRegister:(UIButton *)sender {
    
    if ([self.userEmailTextField.text isEqualToString:@""] || [self.userNameTextField.text isEqualToString:@""] || [self.userPhoneTextField.text isEqualToString:@""]) {
        
        [[panicButtonUser sharedPanicButtonUser] showAlertViewWithMessage:kErrorIncompleteTextFields cancelButtonTitle:kErrorCloseButtonIncompleteTextFields textField:NO andActivityIndicator:NO];
        
    } else {
        
        [[panicButtonUser sharedPanicButtonUser] registerNewUserWithName:self.userNameTextField.text email:self.userEmailTextField.text andPhone:self.userPhoneTextField.text];
    }
    

    [self.userEmailTextField endEditing:YES];
    [self.userNameTextField endEditing:YES];
    [self.userPhoneTextField endEditing:YES];
    
}



- (IBAction)textFieldEditingDidEnd:(id)sender {
    
    
}



#pragma mark -
#pragma mark Text Field Delegate Methods
#pragma mark -




-(BOOL) textFieldShouldReturn: (UITextField *) textField {
    [textField resignFirstResponder];
    return YES;
}



- (void)textFieldDidBeginEditing:(UITextField *)textField {
    //NSLog(@"textFieldDidBeginEditing");
    [self moveForKeyboardUp:YES];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    //NSLog(@"textFieldDidEndEditing");
    [self moveForKeyboardUp:NO];
    
}


-(void)moveForKeyboardUp:(BOOL)up
{
    const int movementDistance = -185;
    const float movementDuration = 0.3f;
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"moveForKeyboardView" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}


@end
