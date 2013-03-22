//
//  TrackPoint.m
//  LocationLog
//
//  Created by sasgwb on 3/18/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import "TrackPoint.h"
#import "Track.h"

@implementation TrackPoint

@synthesize latitude;
@synthesize longitude;
@synthesize course;
@synthesize speed;
@synthesize altitude;
@synthesize timestamp;
@synthesize key;
@synthesize track;

- (id)initWithPoint:(CLLocationCoordinate2D)point
             course:(CLLocationDirection)pCourse
              speed:(CLLocationSpeed)pSpeed
           altitude:(CLLocationDistance)pAltitude
          timestamp:(NSDate *)pTimestamp
              track:(Track*)pTrack
{
    self = [super init];
    if (self)
    {
        latitude = point.latitude;
        longitude = point.longitude;
        course = pCourse;
        speed = pSpeed;
        altitude = pAltitude;
        timestamp = [pTimestamp copy];
        track = [pTrack key];
    }
    
    return self;
}
@end
