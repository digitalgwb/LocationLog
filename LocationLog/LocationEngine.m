//
//  LocationEngine.m
//  LocationLog
//
//  Created by sasgwb on 3/18/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import "LocationEngine.h"
#import "TrackPoint.h"
#import "TrackPointStore.h"
#import "TrackStore.h"
#import "Track.h"

@implementation LocationEngine

+ (LocationEngine*)instance
{
    static LocationEngine* instance;
    
    if (!instance)
    {
        @synchronized(instance)
        {
            instance = [[LocationEngine alloc] init];
        }
    }
    
    return instance;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        locationManager = [[CLLocationManager alloc] init];
        [locationManager setDelegate:self];
        [locationManager setDistanceFilter:kCLDistanceFilterNone];
        [locationManager setHeadingFilter:kCLHeadingFilterNone];
        currentTrack = nil;
    }
    
    return self;
}

/*
 * Start a new track
 */
- (void)start
{
    currentTrack = [[TrackStore instance] createTrack];
    [locationManager startUpdatingLocation];
}

/*
 * Continue on the existing track
 */
- (void)continue
{
    [locationManager startUpdatingLocation];
}

/*
 * Stop tracking
 */
- (void)stop
{
    [locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    for (int i = 0; i < [locations count]; i++)
    {
        CLLocation* location = [locations objectAtIndex:i];
        
        [[TrackPointStore instance] addPoint:location forTrack:currentTrack];
        
    }
}
@end
