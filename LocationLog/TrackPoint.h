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

@property CLLocationDegrees latitude;
@property CLLocationDegrees longitude;
@property CLLocationDirection course;
@property CLLocationSpeed speed;
@property CLLocationDistance altitude;
@property (strong, atomic) NSDate* timestamp;
@property NSInteger key;
@property NSInteger track;

- (id)initWithPoint:(CLLocationCoordinate2D)point
             course:(CLLocationDirection)course
              speed:(CLLocationSpeed)speed
           altitude:(CLLocationDistance)altitude
          timestamp:(NSDate*)timestamp
              track:(Track*)track;

- (id)initWithLocation:(CLLocation *)location track:(Track *)track;

@end
