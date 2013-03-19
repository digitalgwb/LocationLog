//
//  TrackPointStore.m
//  LocationLog
//
//  Created by sasgwb on 3/18/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import "TrackPointStore.h"
#import "TrackPoint.h"
#import "Track.h"
#import "LocationLogDB.h"

@implementation TrackPointStore

+ (TrackPointStore*)instance
{
    static TrackPointStore *instance = nil;
    
    if (!instance)
    {
        instance = [[super allocWithZone:nil] init];
    }
    
    return instance;
}

+ (id)allocWithZone:(NSZone*)zone
{
    return [self instance];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        points = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)addPoint:(CLLocation*)location forTrack:(Track*)track
{
    TrackPoint* point = [[TrackPoint alloc] initWithPoint:[location coordinate]
                                                   course:[location course]
                                                    speed:[location speed]
                                                 altitude:[location altitude]
                                                timestamp:[location timestamp]
                                                    track:track];
    
    [point setKey:[[LocationLogDB instance] addTrackPoint:point]];
    [points addObject:point];
}

@end
