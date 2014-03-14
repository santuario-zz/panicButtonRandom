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

@end

@implementation panicButtonViewController


#pragma mark -
#pragma mark Life Cycle Methods
#pragma mark -


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self performSelector:@selector(initPanicButtonApp) withObject:nil afterDelay:1.5];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark -
#pragma mark  Methods
#pragma mark -


-(void)initPanicButtonApp
{
    
    
    
    panicButtonSignUpViewController *panicButtonSignUp = (panicButtonSignUpViewController*)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"panicButtonSignUp"];
    [self presentViewController:panicButtonSignUp animated:YES completion:nil];

    
    /*
    
    
    // present
    [self presentViewController:panicButtonSignUp animated:YES completion:nil];
    
    if ([[panicButtonUser sharedPanicButtonUser] checkIfUserIsRegistered]) {
        NSLog(@"USUARIO REGISTRADO");

    }else{
        
        panicButtonSignUpViewController *panicButtonSignUp = (panicButtonSignUpViewController*)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"panicButtonSignUp"];
        
        // present
        [self presentViewController:panicButtonSignUp animated:YES completion:nil];
        
        // dismiss
        //[self dismissViewControllerAnimated:YES completion:nil];
    }
    
     */
    
}


@end
