//
//  panicButtonContactListViewController.m
//  panicButton
//
//  Created by 3π on 3/12/14.
//  Copyright (c) 2014 3π. All rights reserved.
//

#import "panicButtonContactListViewController.h"

@interface panicButtonContactListViewController ()

@end


#pragma mark -
#pragma mark Life Cycle Methods
#pragma mark -



@implementation panicButtonContactListViewController



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
#pragma mark Table View Methods
#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[panicButtonUser sharedPanicButtonUser] contacts] count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *contactTableIdentifier = @"contactTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:contactTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:contactTableIdentifier];
    }
    
    cell.textLabel.text = [[[panicButtonUser sharedPanicButtonUser] contacts] objectAtIndex:indexPath.row];
    return cell;
}




#pragma mark -
#pragma mark Lazy Instantiation Methods
#pragma mark -

// Lazy instantiation of Contacts Array





@end
