//
//  panicButtonViewController.h
//  panicButton
//
//  Created by 3π on 3/12/14.
//  Copyright (c) 2014 3π. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kFLIP_ANIMAMTION_TIME 0.8


@interface panicButtonViewController : UIViewController <UIGestureRecognizerDelegate, UITextFieldDelegate>

    @property (weak, nonatomic) IBOutlet UIView *panicButtonContainerView;
    @property (weak, nonatomic) IBOutlet UIView *panicButtonView;
    @property (weak, nonatomic) IBOutlet UIView *panicButtonSettiingsView;

    @property (weak, nonatomic) IBOutlet UIView *timeoutContainerView;
    @property (weak, nonatomic) IBOutlet UIView *timeoutSetiingsView;
    @property (weak, nonatomic) IBOutlet UIView *timeoutView;


    
@end

