//
//  LocationEngine.m
//  LocationLog
//
//  Created by sasgwb on 3/18/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import "LocationEngine.h"
#import "LocationLogDatabase.h"
#import "TrackPoint.h"
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
    currentTrack = [[Track alloc] init];
    [currentTrack setTimestamp:[NSDate date]];
    [currentTrack setKey:[[LocationLogDatabase instance] insertTrack:currentTrack]];
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
        [[LocationLogDatabase instance] insertPoint:[[TrackPoint alloc] initWithLocation:location track:currentTrack]];
    }
}
@end
