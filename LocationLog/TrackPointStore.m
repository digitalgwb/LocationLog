//
//  TrackPointStore.m
//  LocationLog
//
//  Created by sasgwb on 3/26/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import "TrackPointStore.h"
#import "LocationLogDatabase.h"
#import "Track.h"

@implementation TrackPointStore

@synthesize trackKey;

 + (TrackPointStore *)sharedStore
{
    static TrackPointStore *sharedStore = nil;
    
    
    if (!sharedStore)
    {
        sharedStore = [[super allocWithZone:nil] init];
    }
    
    return sharedStore;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedStore];
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        arrPoints = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (NSArray *)points
{
    return arrPoints;
}

- (void)initialize:(Track *)track
{
    trackKey = [track key];
    NSArray *dbPoints = [[LocationLogDatabase instance] findPointsForTrack:trackKey];
    [arrPoints removeAllObjects];
    
    for (int i = 0; i < [dbPoints count]; i++)
    {
        [arrPoints addObject:[dbPoints objectAtIndex:i]];
    }
}

@end
