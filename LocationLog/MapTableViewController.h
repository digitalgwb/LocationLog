//
//  MapTableViewController.h
//  LocationLog
//
//  Created by Gary Black on 3/26/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class Track;

@interface MapTableViewController : UIViewController <UITableViewDelegate,
                                                      UITableViewDataSource,
                                                      MKMapViewDelegate>
{
    NSDateFormatter *dateFormatter;
}

- (id)initWithTrack:(Track *)track;
@end
