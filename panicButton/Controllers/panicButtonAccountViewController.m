//
//  panicButtonAccountViewController.m
//  panicButton
//
//  Created by 3π on 3/12/14.
//  Copyright (c) 2014 3π. All rights reserved.
//

#import "panicButtonAccountViewController.h"
#import "panicButtonUser.h"


@interface panicButtonAccountViewController ()

@end

@implementation panicButtonAccountViewController


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

#pragma mark -
#pragma mark Methods
#pragma mark -

-(void)initialize{
    [self initiaizeTextFields];
}



-(void)initiaizeTextFields{
    

    
    
    
    //self.userEmailTextField.delegate = self;

    
    self.userNameTextField.font = [UIFont fontWithName:kZagRegular size:20];
    [self.userNameTextField setTextColor:RGBUIColor(245, 69, 74,1)];
    self.userNameTextField.text = [NSString stringWithFormat:@"   %@",[[[panicButtonUser sharedPanicButtonUser] userData] objectForKey:@"userName"]];

    
    self.userMailTextField.font = [UIFont fontWithName:kZagRegular size:20];
    [self.userMailTextField setTextColor:RGBUIColor(245, 69, 74,1)];
    self.userMailTextField.text = [NSString stringWithFormat:@"   %@",[[[panicButtonUser sharedPanicButtonUser] userData] objectForKey:@"userEmail"]];
    
    self.userPhoneTextField.font = [UIFont fontWithName:kZagRegular size:20];
    [self.userPhoneTextField setTextColor:RGBUIColor(245, 69, 74,1)];
    self.userPhoneTextField.text = [NSString stringWithFormat:@"   %@",[[[panicButtonUser sharedPanicButtonUser] userData] objectForKey:@"userPhone"]];
    
    self.userIDTextField.font = [UIFont fontWithName:kZagRegular size:20];
    [self.userIDTextField setTextColor:RGBUIColor(245, 69, 74,1)];
    self.userIDTextField.text = [NSString stringWithFormat:@"   %@",[[[panicButtonUser sharedPanicButtonUser] userData] objectForKey:@"userID"]];
    
    

    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
