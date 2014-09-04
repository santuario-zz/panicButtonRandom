//
//  panicButtonContactListViewController.m
//  panicButton
//
//  Created by 3π on 3/12/14.
//  Copyright (c) 2014 3π. All rights reserved.
//

#import "panicButtonContactListViewController.h"

@interface panicButtonContactListViewController (){
    int indexSelected;
}
@property (weak, nonatomic) IBOutlet UITableView *contactListtableView;


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
    [self initialize];
}

- (void)didReceiveMemoryWarningfv
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark  Methods
#pragma mark -

-(void)initialize{
    
    self.watchersListTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self initializeNotificationCenter];
    indexSelected = 1000;

}


-(void)initializeNotificationCenter{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadContentTable:)
                                                 name:kUpdateContactListTableView
                                               object:nil];
    

}


#pragma mark -
#pragma mark Table View Methods
#pragma mark -

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexSelected == indexPath.row) {
        indexSelected = 1000;
    }else{
        indexSelected = indexPath.row;

    }
    
    [tableView beginUpdates];
    
    
    [tableView endUpdates];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    //NSLog(@"heightForRowAtIndexPath indexPath %@ %@", indexPath, [tableView indexPathForSelectedRow]);

    if (indexPath.row == indexSelected) {
        return 120.0;
    }
    
    return 65.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[panicButtonUser sharedPanicButtonUser] contacts] count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    /*
    static NSString *contactTableIdentifier = @"contactTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:contactTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:contactTableIdentifier];
    }
    
    cell.textLabel.text = [[[[panicButtonUser sharedPanicButtonUser] contacts] objectAtIndex:indexPath.row] objectForKey:@"userContactName"];
    return cell;
    
    
    */
    
    static NSString *cellIdentifier = @"contactCell";
    
     panicButtonWatchersTableViewCell *cell = (panicButtonWatchersTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Add utility buttons
    NSMutableArray *leftUtilityButtons = [NSMutableArray new];
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    
    

    [leftUtilityButtons sw_addUtilityButtonWithColor:RGBUIColor(47, 179, 215, 1) title:@"block" andFont:[UIFont fontWithName:kZagRegular size:20]];

    /*
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
                                                title:@"More"];*/
    
    [rightUtilityButtons sw_addUtilityButtonWithColor:RGBUIColor(226, 57, 62, 1) title:@"delete" andFont:[UIFont fontWithName:kZagRegular size:20]];
    
    
    cell.leftUtilityButtons = leftUtilityButtons;
    cell.rightUtilityButtons = rightUtilityButtons;
    cell.delegate = self;
    
    // Configure the cell...
    cell.watcherNameLabel.text = [[[[panicButtonUser sharedPanicButtonUser] contacts] objectAtIndex:indexPath.row] objectForKey:@"userContactName"];
    cell.watcherNameLabel.font = [UIFont fontWithName:kZagBold size:25];
    
    cell.watcherPhoneLabel.text = [[[[panicButtonUser sharedPanicButtonUser] contacts] objectAtIndex:indexPath.row] objectForKey:@"userContactPhone"];
    cell.watcherPhoneLabel.font = [UIFont fontWithName:kZagRegular size:14];
    
    cell.watcherEmailLabel.text = [[[[panicButtonUser sharedPanicButtonUser] contacts] objectAtIndex:indexPath.row] objectForKey:@"userContactEmail"];
    cell.watcherEmailLabel.font = [UIFont fontWithName:kZagRegular size:14];
    
    cell.watcherIDLabel.text = [[[[panicButtonUser sharedPanicButtonUser] contacts] objectAtIndex:indexPath.row] objectForKey:@"userContactID"];
    cell.watcherIDLabel.font = [UIFont fontWithName:kZagRegular size:14];
    
    
    return cell;
    
    
}


-(void)reloadContentTable:(NSNotification *)notification{
    
    [_contactListtableView reloadData];
}


#pragma mark -
#pragma mark Lazy Instantiation Methods
#pragma mark -

// Lazy instantiation of Contacts Array



#pragma mark -
#pragma mark SWTableViewDelegate Methods
#pragma mark -

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index {
    switch (index) {
        case 0:
            NSLog(@"BLOCK button was pressed");
            break;

    }
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    switch (index) {
        case 0:
            NSLog(@"MORE button was pressed");
            //[[panicButtonUser sharedPanicButtonUser] showAlertViewWithMessage:@"Saving..." cancelButtonTitle:nil andActivityIndicator:YES];
            break;
        case 1:
        {
            // Delete button was pressed
            
            [[panicButtonUser sharedPanicButtonUser] showAlertViewWithMessage:@"Delete..." cancelButtonTitle:nil textField:NO andActivityIndicator:YES];
            

            NSIndexPath *cellIndexPath = [self.watchersListTableView indexPathForCell:cell];
            [[panicButtonUser sharedPanicButtonUser] deleteUserContactInBackendWithID:[[[[panicButtonUser sharedPanicButtonUser] contacts] objectAtIndex:cellIndexPath.row] objectForKey:@"userContactID"]];
            
            [[[panicButtonUser sharedPanicButtonUser] contacts] removeObjectAtIndex:cellIndexPath.row];
            
            [self.watchersListTableView deleteRowsAtIndexPaths:@[cellIndexPath]
                                  withRowAnimation:UITableViewRowAnimationAutomatic];
            
            
            
            break;
        }
        default:
            break;
    }
}

// utility button open/close event
- (void)swipeableTableViewCell:(SWTableViewCell *)cell scrollingToState:(SWCellState)state{
    
}

// prevent multiple cells from showing utilty buttons simultaneously
- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell{
    return YES;
}

// prevent cell(s) from displaying left/right utility buttons
- (BOOL)swipeableTableViewCell:(SWTableViewCell *)cell canSwipeToState:(SWCellState)state{
    return YES;
}


@end
