//
//  PointTableViewController.m
//  LocationLog
//
//  Created by Gary Black on 3/24/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import "PointTableViewController.h"
#import "TrackPoint.h"
#import "TrackPointStore.h"
#import "TrackPointCell.h"

@implementation PointTableViewController

@synthesize trackKey;

- (id)initWithTrack:(Track *)track;
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    
    if (self)
    {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM/dd/YY HH:mm:ss"];
        
        UINavigationItem *navItem = [self navigationItem];
        
        [navItem setTitle:@"Points"];
        
        [[TrackPointStore sharedStore] initialize:track];
    }
    
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"TrackPointCell" bundle:nil];
    
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"TrackPointCell"];
}

- (NSInteger)tableView:(UITableView *)tableview numberOfRowsInSection:(NSInteger)section
{
    return [[[TrackPointStore sharedStore] points] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TrackPoint *point = [[[TrackPointStore sharedStore] points] objectAtIndex:[indexPath row]];
    
    TrackPointCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TrackPointCell"];
    
    [[cell timestamp] setText:[dateFormatter stringFromDate:[point timestamp]]];
    [[cell latitude] setText:[NSString stringWithFormat:@"%9.6f", [point latitude]]];
    [[cell longitude] setText:[NSString stringWithFormat:@"%9.6f", [point longitude]]];
    
    return cell;
}


@end
