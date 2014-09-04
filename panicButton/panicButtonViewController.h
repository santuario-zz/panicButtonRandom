//
//  panicButtonViewController.h
//  panicButton
//
//  Created by 3π on 3/12/14.
//  Copyright (c) 2014 3π. All rights reserved.
//

#import <UIKit/UIKit.h>


#define kFLIP_ANIMAMTION_TIME 0.8


@interface panicButtonViewController : UIViewController <UIGestureRecognizerDelegate, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

    // Logo

    @property (weak, nonatomic) IBOutlet UIView *logoView;

    @property (weak, nonatomic) IBOutlet UIImageView *logoHandImageView;
    @property (weak, nonatomic) IBOutlet UIImageView *logoHandShadowImageView;
    @property (weak, nonatomic) IBOutlet UIImageView *logoBackgroundImageView;


    // Panic Button
    @property (weak, nonatomic) IBOutlet UIButton *panicButtonButton;

    @property (weak, nonatomic) IBOutlet UIView *panicButtonContainerView;
    @property (weak, nonatomic) IBOutlet UIView *panicButtonView;
    @property (weak, nonatomic) IBOutlet UIView *panicButtonSettiingsView;
@property (weak, nonatomic) IBOutlet UITextField *panicButtonMessageTextField;


    // Time Counter

    @property (weak, nonatomic) IBOutlet UIView *timeoutContainerView;
    @property (weak, nonatomic) IBOutlet UIView *timeoutSetiingsView;
    @property (weak, nonatomic) IBOutlet UIView *timeoutView;

    @property (weak, nonatomic) IBOutlet UIDatePicker *timeCounterDatePicker;
    @property (weak, nonatomic) IBOutlet UILabel *timeoutCountLabel;

    @property (weak, nonatomic) IBOutlet UIButton *handleTimeCounterButton;
    @property (weak, nonatomic) IBOutlet UIImageView *dataPicerkBackgroundImageView;


    @property (weak, nonatomic) IBOutlet UITextField *timeoutMessageTextField;

@end

