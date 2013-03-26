//
//  PointTableViewController.h
//  LocationLog
//
//  Created by Gary Black on 3/24/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Track;

@interface PointTableViewController : UITableViewController
{
    NSDateFormatter *dateFormatter;
}

@property NSInteger trackKey;

- (id)initWithTrack:(Track *)track;

@end
