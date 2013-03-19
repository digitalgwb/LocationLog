//
//  LocationLogDB.m
//  LocationLog
//
//  Created by Gary Black on 3/18/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import "LocationLogDB.h"
#import "TrackPoint.h"

@implementation LocationLogDB

+ (LocationLogDB *)instance
{
    static LocationLogDB *instance = nil;
    
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

- (void)open
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"locationlog.sqlite"];
    
    NSLog(@"Database file: %@", path);
    
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK)
    {
        
    }
    else
    {
        sqlite3_close(database);
        NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
    }
    
}

- (void)close
{
    if (database != nil)
        sqlite3_close(database);
}

- (NSInteger)addTrack:(Track *)track
{
    // Insert a new Track into the Tracks database
    const char *sql = "insert into tracks(timestamp) values(?)";
    sqlite3_stmt *stmt;
    sqlite3_prepare(database, sql, -1, &stmt, NULL);
    sqlite3_bind_int(stmt, 1, [[track timestamp] timeIntervalSince1970]);
    
    // Execute the statement
    sqlite3_step(stmt);
    
    sqlite3_finalize(stmt);
    
    // Return the key created for the newly inserted track
    return sqlite3_last_insert_rowid(database);
}

- (NSInteger)addTrackPoint:(TrackPoint*)trackPoint
{
    // Insert a new TrackPoint into the Points database 
    const char *sql = "insert into points(timestamp,latitude,longitude,course,speed,altitude) values(?,?,?,?,?,?)";
    sqlite3_stmt *stmt;
    sqlite3_prepare(database, sql, -1, &stmt, NULL);
    sqlite3_bind_int(stmt, 1, [[trackPoint timestamp] timeIntervalSince1970]);
    sqlite3_bind_double(stmt, 2, [trackPoint latitude]);
    sqlite3_bind_double(stmt, 3, [trackPoint longitude]);
    sqlite3_bind_double(stmt, 4, [trackPoint course]);
    sqlite3_bind_double(stmt, 5, [trackPoint speed]);
    sqlite3_bind_double(stmt, 6, [trackPoint altitude]);
    
    // Execute the statement
    sqlite3_step(stmt);
    
    sqlite3_finalize(stmt);
    
    // Return the key created for the newly inserted point
    return sqlite3_last_insert_rowid(database);
}

- (void)createEditableCopyOfDatabaseIfNeeded
{
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"locationlog.sqlite"];
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (success)
        return;
    
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"locationlog.sqlite"];
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (!success)
    {
        NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
}


@end
