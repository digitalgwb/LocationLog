//
//  MainViewController.m
//  LocationLog
//
//  Created by sasgwb on 3/18/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import "MainViewController.h"
#import "LocationEngine.h"
#import "TrackTableViewController.h"

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    if (self)
    {
        UINavigationItem *navItem = [self navigationItem];
        
        [navItem setTitle:@"LocationLog"];
        
        UIBarButtonItem *tracksButton = [[UIBarButtonItem alloc] initWithTitle:@"Tracks"
                                                                         style:UIBarButtonItemStyleBordered
                                                                        target:self
                                                                        action:@selector(showTracks:)];
        [navItem setRightBarButtonItem:tracksButton];
    }
    
    return self;
}

- (IBAction)startAction:(id)sender
{
    [[LocationEngine instance] start];
}

- (IBAction)stopAction:(id)sender
{
    [[LocationEngine instance] stop];
}

- (IBAction)showTracks:(id)sender
{
    TrackTableViewController *trackTableViewController = [[TrackTableViewController alloc] init];
    [[self navigationController] pushViewController:trackTableViewController animated:YES];
}

@end
