//
//  TrackPointStore.h
//  LocationLog
//
//  Created by sasgwb on 3/26/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Track;

@interface TrackPointStore : NSObject
{
    NSMutableArray *arrPoints;
}

+ (TrackPointStore *)sharedStore;

@property NSInteger trackKey;

- (NSArray *)points;
- (void)initialize:(Track *)track;

@end
