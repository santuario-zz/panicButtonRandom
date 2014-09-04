//
//  panicButtonWatchersTableViewCell.h
//  panicButton
//
//  Created by adrian santuario on 04/07/14.
//  Copyright (c) 2014 3π. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"

@interface panicButtonWatchersTableViewCell : SWTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *watcherNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *watcherPhoneLabel;
@property (weak, nonatomic) IBOutlet UIImageView *watcherStatusImage;
@property (weak, nonatomic) IBOutlet UILabel *watcherEmailLabel;
@property (weak, nonatomic) IBOutlet UILabel *watcherIDLabel;

@end
