//
//  panicButtonAddContactViewController.m
//  panicButton
//
//  Created by 3π on 3/21/14.
//  Copyright (c) 2014 3π. All rights reserved.
//

#import "panicButtonAddContactViewController.h"

@interface panicButtonAddContactViewController ()

@end

@implementation panicButtonAddContactViewController


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
#pragma mark Action Button Methods
#pragma mark -


- (IBAction)getContactFromAddressBook:(UIButton *)sender {
    
    ABPeoplePickerNavigationController *picker =
    [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];

}

#pragma mark -
#pragma mark Get Contact From Address Book Methods
#pragma mark -



- (void)peoplePickerNavigationControllerDidCancel:
(ABPeoplePickerNavigationController *)peoplePicker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)peoplePickerNavigationController:
(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    
    [self displayPerson:person];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    return NO;
}

- (BOOL)peoplePickerNavigationController:
(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person
                                property:(ABPropertyID)property
                              identifier:(ABMultiValueIdentifier)identifier
{
    return NO;
}


- (void)displayPerson:(ABRecordRef)person
{
    NSString* name = (__bridge_transfer NSString*)ABRecordCopyValue(person,
                                                                    kABPersonFirstNameProperty);
    
    NSString* lastName = (__bridge_transfer NSString*)ABRecordCopyValue(person,
                                                                    kABPersonLastNameProperty);
    
    if (!lastName) {
        lastName = @"";
    }
    
    
    
    self.nameNewContactTextField.text = [NSString stringWithFormat:@"%@ %@", name, lastName];
    
    
    NSString* phone = nil;
    ABMultiValueRef phoneNumbers = ABRecordCopyValue(person,
                                                     kABPersonPhoneProperty);
    if (ABMultiValueGetCount(phoneNumbers) > 0) {
        phone = (__bridge_transfer NSString*)
        ABMultiValueCopyValueAtIndex(phoneNumbers, 0);
    } else {
        phone = @"[None]";
    }
    self.phoneNewContactTextField.text = phone;
    CFRelease(phoneNumbers);
    
    
    
    NSString* email = nil;
    ABMultiValueRef emails = ABRecordCopyValue(person,
                                                     kABPersonEmailProperty);
    
    if (ABMultiValueGetCount(emails) > 0) {
        email = (__bridge_transfer NSString*)
        ABMultiValueCopyValueAtIndex(emails, 0);
    } else {
        email = @"[None]";
    }

    self.emailNewContactTextField.text = email;
    
     CFRelease(emails);
}



#pragma mark -
#pragma mark New Contact Methods
#pragma mark -


-(void)initialize{
    
    NSLog(@"panicButtonAddContactViewController initialize");
    
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
