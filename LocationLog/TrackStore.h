//
//  TrackStore.h
//  LocationLog
//
//  Created by sasgwb on 3/18/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Track;

@interface TrackStore : NSObject
{
    NSMutableArray* tracks;
}

+ (TrackStore*)instance;

- (Track*)createTrack;

@end
