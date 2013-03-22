//
//  TrackTableViewController.m
//  LocationLog
//
//  Created by sasgwb on 3/22/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import "TrackTableViewController.h"
#import "TrackStore.h"
#import "TrackCell.h"
#import "Track.h"

@implementation TrackTableViewController

- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    
    if (self)
    {
        UINavigationItem *navItem = [self navigationItem];
        
        [navItem setTitle:@"Tracks"];
        
        [[TrackStore sharedStore] initialize];
        
        [[self view] setBackgroundColor:[UIColor blackColor]];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"TrackCell" bundle:nil];
    
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"TrackCell"];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[TrackStore sharedStore] tracks] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Track *track = [[[TrackStore sharedStore] tracks] objectAtIndex:[indexPath row]];
    
    TrackCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TrackCell"];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MM/YY/dd HH:mm:ss"];

    [[cell timestamp] setText:[df stringFromDate:[track timestamp]]];
    
    return cell;
}
@end
