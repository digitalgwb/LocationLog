//
//  MapTableViewController.m
//  LocationLog
//
//  Created by Gary Black on 3/26/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import "MapTableViewController.h"
#import <MapKit/MapKit.h>
#import "Track.h"
#import "TrackPoint.h"
#import "TrackPointStore.h"
#import "TrackPointCell.h"

@implementation MapTableViewController

- (id)initWithTrack:(Track *)track;
{
    self = [super init];
    
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 240, 320, 240)
                                                          style:UITableViewStylePlain];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    [self.view addSubview:tableView];
    
    UINib *nib = [UINib nibWithNibName:@"TrackPointCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:@"TrackPointCell"];
    
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 240)];
    [mapView setDelegate:self];
    [self.view addSubview:mapView];
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
