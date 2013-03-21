//
//  Database.m
//  DatabaseTest
//
//  Created by Gary Black on 3/19/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import "Database.h"
#import <sqlite3.h>

@implementation Database

- (id)init:(NSString *)dbName
{
    self = [super init];
    if (self)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        documentsDirectory = [paths objectAtIndex:0];
        db = nil;
        databaseName = dbName;
    }
    
    return self;
}

/*
 * Open the database.  If create == YES, then create and initialize a new database file,
 * deleting the old file if one exists.
 * Returns YES if successful, NO otherwise.
 */
- (BOOL)open:(BOOL)create
{
    
    // If the current database is open, the close it
    if (db != nil)
    {
        [self close];
    }
    
    NSError *error;
    
    // Build the file name and path
    NSString *dbFileName = [NSString stringWithFormat:@"%@.sqlite", databaseName];
    NSString *dbFilePath = [documentsDirectory stringByAppendingPathComponent:dbFileName];
    
    // Check if the db already exists.  If so, return YES
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL rc = NO;
    BOOL exists = [fileManager fileExistsAtPath:dbFilePath];
    
    // If create flag is YES and the file exists, then delete it
    if ((create == YES) && (exists == YES))
    {
        rc = [fileManager removeItemAtPath:dbFilePath error:&error];
        
        // If the deletion failed, then return NO
        if (rc == NO)
            return rc;
    }
    
    // Create/open the database
    rc = (sqlite3_open([dbFilePath UTF8String], &db) == SQLITE_OK);
    
    if (rc == NO)
    {
        sqlite3_close(db);
        return rc;
    }
    
    // If the create flag is YES then create the tables
    if (create == YES)
    {
        // Database was successfully created - now create tables
        
        rc = [self createTables];
    }
    
    return rc;
}

/*
 * Close the current database.
 * Returns YES if successful, NO otherwise.
 */
- (BOOL)close
{
    return( sqlite3_close(db) == SQLITE_OK );
}

/*
 * Create all of the tables in the database.
 * Returns YES if successful, NO otherwise.
 * This should be overridden in a subclass.
 */
- (BOOL)createTables
{
    return NO;
}

- (BOOL)createTable:(NSString *)name withColumns:(NSArray *)columns
{
    if (db == nil)
    {
        return NO;
    }
    
    NSString *columnArgs = [columns componentsJoinedByString:@", "];
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ ( %@ );", name, columnArgs];
    NSLog(@"createTable: %@", sql);
    
    char *error;
    return(sqlite3_exec(db, [sql UTF8String], NULL, NULL, &error) == SQLITE_OK);
}

/*
 * Create all of the tables in the database.
 * Returns YES if successful, NO otherwise.
 * This should be overridden in a subclass.
 */
- (BOOL)dropTables
{
    return NO;
}

- (BOOL)dropTable:(NSString *)name
{
    if (db == nil)
    {
        return NO;
    }
    
    NSString *sql = [NSString stringWithFormat:@"DROP TABLE %@;", name];
    
    char *error;
    return(sqlite3_exec(db, [sql UTF8String], NULL, NULL, &error) == SQLITE_OK);
}

/*
 * Create all of the tables in the database.
 * Returns YES if successful, NO otherwise.
 * This should be overridden in a subclass.
 */
- (BOOL)resetTables
{
    return NO;
}

- (BOOL)resetTable:(NSString *)name
{
    if (db == nil)
    {
        return NO;
    }
    
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM TABLE %@;", name];
    
    char *error;
    return(sqlite3_exec(db, [sql UTF8String], NULL, NULL, &error) == SQLITE_OK);
}

/*
 * SQLITE wrapper methods
 */
- (BOOL)prepareStatement:(NSString *)sql
{
    return sqlite3_prepare(db, [sql UTF8String], -1, &statement, NULL);
}

- (BOOL)bind:(int)column datetimeValue:(NSDate *)value
{
    return sqlite3_bind_int(statement, column, [value timeIntervalSince1970]);
}

- (BOOL)bind:(int)column doubleValue:(double)value
{
    return sqlite3_bind_double(statement, column, value);
}

- (BOOL)step
{
    return sqlite3_step(statement);
}

- (BOOL)finalize
{
    return sqlite3_finalize(statement);
}

- (BOOL)stepAndFinalize
{
    BOOL rc = sqlite3_step(statement);
    sqlite3_finalize(statement);
    
    return rc;
}

- (int)insertedRow
{
    return sqlite3_last_insert_rowid(db);
}
@end
