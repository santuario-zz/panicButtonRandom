//
//  panicButtonAddContactViewController.h
//  panicButton
//
//  Created by 3π on 3/21/14.
//  Copyright (c) 2014 3π. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>


@interface panicButtonAddContactViewController : UIViewController <ABPeoplePickerNavigationControllerDelegate>


@property (weak, nonatomic) IBOutlet UITextField *nameNewContactTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailNewContactTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNewContactTextField;



@end
