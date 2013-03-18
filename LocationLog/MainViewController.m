//
//  MainViewController.m
//  LocationLog
//
//  Created by sasgwb on 3/18/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import "MainViewController.h"
#import "LocationEngine.h"

@implementation MainViewController

- (IBAction)startAction:(id)sender
{
    [[LocationEngine instance] start];
}

- (IBAction)stopAction:(id)sender
{
    [[LocationEngine instance] stop];
}

@end
