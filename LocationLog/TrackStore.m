//
//  TrackStore.m
//  LocationLog
//
//  Created by sasgwb on 3/18/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import "TrackStore.h"
#import "Track.h"
#import "LocationLogDB.h"

@implementation TrackStore

+ (TrackStore*)instance
{
    static TrackStore *instance = nil;
    
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
        tracks = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (Track*)createTrack
{
    Track* track = [[Track alloc] init];
    [track setTimestamp:[NSDate date]];
    [track setKey:[[LocationLogDB instance] addTrack:track]];
    
    [tracks addObject:track];
    
    return track;
}
@end
