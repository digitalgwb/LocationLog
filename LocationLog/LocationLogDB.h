//
//  LocationLogDB.h
//  LocationLog
//
//  Created by Gary Black on 3/18/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Track.h"
#import "TrackPoint.h"

@interface LocationLogDB : NSObject
{
    sqlite3 *database;
}

+ (LocationLogDB *)instance;

- (void)createEditableCopyOfDatabaseIfNeeded;

- (void)open;
- (void)close;

- (NSInteger)addTrack:(Track*)track;
- (NSInteger)addTrackPoint:(TrackPoint*)point;

@end
