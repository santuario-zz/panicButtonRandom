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


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark Action Buttons Methods
#pragma mark -


- (IBAction)registerNewUser:(UIButton *)sender {
    [[panicButtonUser sharedPanicButtonUser] registerNewUserWithName:self.userNameTextField.text email:self.userEmailTextField.text andPhone:self.userPhoneTextField.text];

}


- (IBAction)textFieldEditingDidEnd:(id)sender {
    
    
}


@end
