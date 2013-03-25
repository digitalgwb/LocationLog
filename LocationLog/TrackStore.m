//
//  TrackStore.m
//  LocationLog
//
//  Created by sasgwb on 3/22/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import "TrackStore.h"
#import "LocationLogDatabase.h"

@implementation TrackStore

+ (TrackStore *)sharedStore
{
    static TrackStore *sharedStore = nil;
    
    if (!sharedStore)
    {
        sharedStore = [[super allocWithZone:nil] init];
    }
    
    return sharedStore;
}

+ (id)allocWithZone:(NSZone *)zone;
{
    return [self sharedStore];
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        arrTracks = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (NSArray *)tracks
{
    return arrTracks;
}

- (void)initialize
{
    NSArray* dbTracks = [[LocationLogDatabase instance] getTracks];
    [arrTracks removeAllObjects];
    
    for (int i = 0; i < [dbTracks count]; i++)
    {
        [arrTracks addObject:[dbTracks objectAtIndex:i]];
    }
}
@end
