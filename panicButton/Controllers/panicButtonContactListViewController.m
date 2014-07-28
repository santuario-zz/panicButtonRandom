//
//  panicButtonContactListViewController.m
//  panicButton
//
//  Created by 3π on 3/12/14.
//  Copyright (c) 2014 3π. All rights reserved.
//

#import "panicButtonContactListViewController.h"

@interface panicButtonContactListViewController ()
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
    

    [self initializeNotificationCenter];

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
    
    cell.textLabel.text = [[[[panicButtonUser sharedPanicButtonUser] contacts] objectAtIndex:indexPath.row] objectForKey:@"userContactName"];
    return cell;
}


-(void)reloadContentTable:(NSNotification *)notification{
    
    [_contactListtableView reloadData];
}


#pragma mark -
#pragma mark Lazy Instantiation Methods
#pragma mark -

// Lazy instantiation of Contacts Array





@end
