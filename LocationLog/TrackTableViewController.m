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
#import "PointTableViewController.h"

@implementation TrackTableViewController

- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    
    if (self)
    {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM/dd/YY HH:mm:ss"];
        
        UINavigationItem *navItem = [self navigationItem];
        
        [navItem setTitle:@"Tracks"];
        
        [[TrackStore sharedStore] initialize];
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
    
    [[cell timestamp] setText:[dateFormatter stringFromDate:[track timestamp]]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Track *track = [[[TrackStore sharedStore] tracks] objectAtIndex:[indexPath row]];
    
    PointTableViewController *pointTableViewController = [[PointTableViewController alloc] initWithTrack:track];
    
    [[self navigationController] pushViewController:pointTableViewController animated:YES];
    
}
@end
