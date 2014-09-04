//
//  panicButtonAboutViewController.m
//  panicButton
//
//  Created by 3π on 3/12/14.
//  Copyright (c) 2014 3π. All rights reserved.
//

#import "panicButtonAboutViewController.h"
#import "panicButtonUser.h"


@interface panicButtonAboutViewController ()

@end

@implementation panicButtonAboutViewController


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
	// Do any additional setup after loading the view4
    [self initialize];
}


#pragma mark -
#pragma mark Methods
#pragma mark -

-(void)initialize{
    
    self.aboutAppDescriptionTextView.font = [UIFont fontWithName:kZagRegular size:14];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
