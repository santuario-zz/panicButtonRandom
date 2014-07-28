//
//  SwipeTableViewController.m
//  SwipeTableCell
//
//  Created by Simon on 3/5/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "SwipeTableViewController.h"
#import "CustomTableViewCell.h"

@interface SwipeTableViewController () {
    NSMutableArray *patterns;
    NSMutableArray *patternImages;
}

@end

@implementation SwipeTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    patterns = [NSMutableArray arrayWithObjects:@"Neon Autumn", @"Alchmey", @"White Wood", @"Green Goblin", @"Subway Lines", @"Canvas Orange", @"Kiwis", @"Cuadros", @"HodgePodge", @"Naranjas", @"Bunting", nil];
    
    patternImages = [NSMutableArray arrayWithObjects:@"neon-autumn.gif", @"alchemy.jpg", @"white-wood.jpg", @"green-goblin.png", @"subway-lines.png", @"canvas-orange.jpg", @"kiwis.png", @"cuadros.png", @"hodgepodge.png", @"naranjas.png", @"bunting-flag.png", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [patterns count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.patternLabel.text = [patterns objectAtIndex:indexPath.row];
    cell.patternImageView.image = [UIImage imageNamed:[patternImages objectAtIndex:indexPath.row]];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

@end
