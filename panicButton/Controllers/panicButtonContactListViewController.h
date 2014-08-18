//
//  panicButtonContactListViewController.h
//  panicButton
//
//  Created by 3π on 3/12/14.
//  Copyright (c) 2014 3π. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "panicButtonUser.h"
#import "SWTableViewCell.h"
#import "panicButtonWatchersTableViewCell.h"



@interface panicButtonContactListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, SWTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *watchersListTableView;



@end
