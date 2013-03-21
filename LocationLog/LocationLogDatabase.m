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

    // Insert a new Track into the Tracks database
    if ([self prepareStatement:@"INSERT INTO tracks(timestamp) VALUES(?)"]  &&
        [self bind:1 datetimeValue:[track timestamp]] &&
        [self stepAndFinalize])
    {
        key = [self insertedRow];
    }
    else
    {
        [self finalize];
    }
    
    return key;
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
    
    if ([self prepareStatement:@"INSERT INTO points(timestamp, latitude, longitude, course, speed, altitude) VALUES(?,?,?,?,?,?)"] &&
        [self bind:1 datetimeValue:[point timestamp]] &&
        [self bind:2 doubleValue:[point latitude]] &&
        [self bind:3 doubleValue:[point longitude]] &&
        [self bind:4 doubleValue:[point course]] &&
        [self bind:5 doubleValue:[point speed]] &&
        [self bind:6 doubleValue:[point altitude]] &&
        [self stepAndFinalize])
    {
        key = [self insertedRow];
    }
    else
    {
        [self finalize];
    }
    
    return key;
    
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
