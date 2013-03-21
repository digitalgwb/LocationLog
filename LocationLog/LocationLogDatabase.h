//
//  LocationLogDatabase.h
//  LocationLog
//
//  Created by sasgwb on 3/21/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import "Database.h"

@class Track;
@class TrackPoint;

@interface LocationLogDatabase : Database

+ (LocationLogDatabase *)instance;

- (BOOL)createTableTracks;
- (int)insertTrack:(Track *)track;
- (BOOL)deleteTrack:(Track *)track;
- (Track *)findTrack:(int)key;
- (NSArray *)findPointsForTrack:(int)key;

- (BOOL)createTablePoints;
- (int)insertPoint:(TrackPoint *)point;
- (BOOL)deletePoint:(TrackPoint *)point;
- (TrackPoint *)findPoint:(int)key;

@end
