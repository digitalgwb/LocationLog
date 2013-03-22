//
//  LocationLogDatabase.m
//  LocationLog
//
//  Created by sasgwb on 3/21/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import "LocationLogDatabase.h"
#import "Track.h"
#import "TrackPoint.h"

@implementation LocationLogDatabase

+ (LocationLogDatabase *)instance
{
    static LocationLogDatabase *instance = nil;
    
    if (!instance)
    {
        instance = [[super allocWithZone:nil] init:@"locationlog"];
    }
    
    return instance;
}

+ (id)allocWithZone:(NSZone *)zone;
{
    return [self instance];
}

/*
 * Create the tables for this database - TRACKS and POINTS
 * Returns YES if successful, NO otherwise
 */
- (BOOL)createTables
{
    BOOL rc = NO;
    if ([self createTableTracks] &&
        [self createTablePoints])
    {
        rc = YES;
    }
    
    return rc;
}

/*
 * Create the TRACKS table in the current database.
 * Returns YES if successful, NO otherwise
 */
- (BOOL)createTableTracks
{
    return [self createTable:@"tracks"
                 withColumns:[[NSArray alloc] initWithObjects:@"key INTEGER PRIMARY KEY AUTOINCREMENT",
                                                              @"timestamp DATETIME",
                                                              @"description VARCHAR(60)",
                                                              nil]];
}

/*
 * Insert a new track into the TRACKS table and return the rowid of the newly inserted track
 * Returns rowid if successful, -1 otherwise
 */
- (int)insertTrack:(Track *)track
{
    int key = -1;

    [self beginTransaction];
    
    // Insert a new Track into the Tracks database
    if ([self prepareStatement:@"INSERT INTO tracks(timestamp) VALUES(?)"]  &&
        [self bind:1 datetimeValue:[track timestamp]] &&
        [self stepAndFinalize])
    {
        [self commitTransaction];
        key = [self insertedRow];
    }
    else
    {
        [self rollbackTransaction];
        [self finalize];
    }
    
    return key;
}

/*
 * Delete a track from the TRACKS table, along with its associated points from the POINTS table
 * Returns YES if successful, NO otherwise
 */
- (BOOL)deleteTrack:(Track *)track
{
    BOOL rc = NO;
    
    [self beginTransaction];
    
    if ([self prepareStatement:@"DELETE FROM tracks where key=?"] &&
        [self bind:1 intValue:[track key]] &&
        [self stepAndFinalize] &&
        [self prepareStatement:@"DELETE FROM points where track=?"] &&
        [self bind:1 intValue:[track key]] &&
        [self stepAndFinalize])
    {
        rc = YES;
    }
    
    if (rc == YES)
    {
        [self commitTransaction];
    }
    else
    {
        [self rollbackTransaction];
    }
    
    return rc;
}

/*
 * Find a Track with the given key
 * Returns a Track instance, or nil if no instance was found
 */
- (Track *)findTrack:(int)key
{
    Track *track = nil;
    
    [self prepareStatement:@"SELECT * FROM tracks where key=?"];
    [self bind:1 intValue:key];
    int rc = [self step];
    
    if (rc == SQLITE_DONE)
    {
        track = [[Track alloc] init];
        [track setKey:[self intColumn:1]];
        [track setDescription:[self textColumn:2]];
        [track setTimestamp:[self datetimeColumn:3]];
    }
    
    [self finalize];
    
    return track;
}

/*
 * Retrieve an array of TrackPoint instances for a given track
 * Returns an NSArray of TrackPoint instances, empty if none was found
 */
- (NSArray *)findPointsForTrack:(int)key
{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    
    [self prepareStatement:@"SELECT * FROM points where track=?"];
    [self bind:1 intValue:key];
    int rc = [self step];
    
    while (rc != SQLITE_DONE)
    {
        TrackPoint *point = [[TrackPoint alloc] init];
        [point setKey:[self intColumn:1]];
        [point setTimestamp:[self datetimeColumn:2]];
        [point setLatitude:[self doubleColumn:3]];
        [point setLongitude:[self doubleColumn:4]];
        [point setCourse:[self doubleColumn:5]];
        [point setSpeed:[self doubleColumn:6]];
        [point setAltitude:[self doubleColumn:7]];
        [point setTrack:[self intColumn:8]];
        
        [array addObject:point];
        rc = [self step];
    }
    
    [self finalize];
    
    return array;
}

/*
 * Create the POINTS table in the current database.
 * Returns YES if successful, NO otherwise
 */
- (BOOL)createTablePoints
{
    return [self createTable:@"points"
                 withColumns:[[NSArray alloc] initWithObjects:@"key INTEGER PRIMARY KEY AUTOINCREMENT",
                                                              @"timestamp DATETIME",
                                                              @"latitude NUMERIC",
                                                              @"longitude NUMERIC",
                                                              @"course NUMERIC",
                                                              @"speed NUMERIC",
                                                              @"altitude NUMERIC",
                                                              @"track INTEGER REFERENCES tracks(key)",
                                                              nil]];
}

/*
 * Insert a new point into the POINTS table and return the rowid of the newly inserted point
 * Returns rowid if successful, -1 otherwise
 */
- (int)insertPoint:(TrackPoint *)point
{
    int key = -1;
    
    [self beginTransaction];
    
    if ([self prepareStatement:@"INSERT INTO points(timestamp, latitude, longitude, course, speed, altitude) VALUES(?,?,?,?,?,?)"] &&
        [self bind:1 datetimeValue:[point timestamp]] &&
        [self bind:2 doubleValue:[point latitude]] &&
        [self bind:3 doubleValue:[point longitude]] &&
        [self bind:4 doubleValue:[point course]] &&
        [self bind:5 doubleValue:[point speed]] &&
        [self bind:6 doubleValue:[point altitude]] &&
        [self stepAndFinalize])
    {
        [self commitTransaction];
        key = [self insertedRow];
    }
    else
    {
        [self rollbackTransaction];
        [self finalize];
    }
    
    return key;
    
}

/*
 * Delete a point from the POINTS table
 * Returns YES if successful, NO otherwise
 */
- (BOOL)deletePoint:(TrackPoint *)point
{
    BOOL rc = NO;
    
    [self beginTransaction];
    
    if ([self prepareStatement:@"DELETE FROM points where key=?"] &&
        [self bind:1 intValue:[point key]] &&
        [self stepAndFinalize])
    {
        rc = YES;
    }
    
    if (rc == YES)
    {
        [self commitTransaction];
    }
    else
    {
        [self rollbackTransaction];
    }
    
    return rc;
}

/*
 * Find a TrackPoint instance with the given key
 * Returns a TrackPoint instance, or nil if no instance was found
 */
- (TrackPoint *)findPoint:(int)key
{
    TrackPoint *point = nil;
    
    [self prepareStatement:@"SELECT * FROM tracks where key=?"];
    [self bind:1 intValue:key];
    int rc = [self step];
    
    if (rc == SQLITE_DONE)
    {
        point = [[TrackPoint alloc] init];
        [point setKey:[self intColumn:1]];
        [point setTimestamp:[self datetimeColumn:2]];
        [point setLatitude:[self doubleColumn:3]];
        [point setLongitude:[self doubleColumn:4]];
        [point setCourse:[self doubleColumn:5]];
        [point setSpeed:[self doubleColumn:6]];
        [point setAltitude:[self doubleColumn:7]];
        [point setTrack:[self intColumn:8]];
    }
    
    [self finalize];
    
    return point;
}

/*
 * Drop the POINTS and TRACKS tables
 * Returns YES if successful, NO otherwise
 */
- (BOOL)dropTables
{
    BOOL rc = NO;
    if ([self dropTable:@"tracks"] &&
        [self dropTable:@"points"])
    {
        rc = YES;
    }
    
    return rc;
}

/*
 * Resets the POINTS and TRACKS tables - i.e. removes all records, but the tables aren't DROPped
 * Returns YES if successful, NO otherwise
 */
- (BOOL)resetTables
{
    BOOL rc = NO;
    if ([self resetTable:@"tracks"] &&
        [self resetTable:@"points"])
    {
        rc = YES;
    }
    
    return rc;
}

@end
