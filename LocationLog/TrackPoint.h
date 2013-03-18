//
//  TrackPoint.h
//  LocationLog
//
//  Created by sasgwb on 3/18/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class Track;

@interface TrackPoint : NSObject
{
    int key;
    
    CLLocationDegrees latitude;
    CLLocationDegrees longitude;
    
    CLLocationDirection course;
    CLLocationSpeed speed;
    CLLocationDistance altitude;
    
    NSDate* timestamp;
    
    NSString* trackKey;
}

- (id)initWithPoint:(CLLocationCoordinate2D)point
             course:(CLLocationDirection)course
              speed:(CLLocationSpeed)speed
           altitude:(CLLocationDistance)altitude
          timestamp:(NSDate*)timestamp
              track:(Track*)track;

@end
