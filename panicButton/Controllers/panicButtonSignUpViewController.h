//
//  panicButtonSignUpViewController.h
//  panicButton
//
//  Created by 3π on 3/12/14.
//  Copyright (c) 2014 3π. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface panicButtonSignUpViewController : UIViewController <UITextFieldDelegate>

//Logo
@property (weak, nonatomic) IBOutlet UIView *logoView;

@property (weak, nonatomic) IBOutlet UIImageView *logoHandImageView;
@property (weak, nonatomic) IBOutlet UIImageView *logoHandShadowImageView;
@property (weak, nonatomic) IBOutlet UIImageView *logoBackgroundImageView;

// UI
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *userEmailTextField;

@property (weak, nonatomic) IBOutlet UITextField *userPhoneTextField;

@property (weak, nonatomic) IBOutlet UILabel *adviceLabel;

@property (weak, nonatomic) IBOutlet UILabel *signInLabel;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@end
