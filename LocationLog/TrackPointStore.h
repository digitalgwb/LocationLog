//
//  TrackPointStore.h
//  LocationLog
//
//  Created by sasgwb on 3/18/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TrackPoint;
@class CLLocation;
@class Track;

@interface TrackPointStore : NSObject
{
    NSMutableArray* points;
}

+ (TrackPointStore*) instance;

- (void)addPoint:(CLLocation*)location forTrack:(Track*)track;

@end
