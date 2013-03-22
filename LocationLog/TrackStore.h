//
//  TrackStore.h
//  LocationLog
//
//  Created by sasgwb on 3/22/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrackStore : NSObject
{
    NSMutableArray *arrTracks;
}

+ (TrackStore *)sharedStore;

- (NSArray *)tracks;
- (void)initialize;

@end
