//
//  Database.h
//  DatabaseTest
//
//  Created by Gary Black on 3/19/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface Database : NSObject
{
    sqlite3 *db;
    NSString *documentsDirectory;
    NSString *databaseName;
    sqlite3_stmt *statement;
}

- (id)init:(NSString *)dbName;
- (BOOL)open:(BOOL)create;
- (BOOL)close;
- (BOOL)createTables;
- (BOOL)createTable:(NSString *)name withColumns:(NSArray *)columns;
- (BOOL)dropTables;
- (BOOL)dropTable:(NSString *)name;
- (BOOL)resetTables;
- (BOOL)resetTable:(NSString *)name;

- (BOOL)prepareStatement:(NSString *)sql;
- (BOOL)bind:(int)column datetimeValue:(NSDate *)value;
- (BOOL)bind:(int)column doubleValue:(double)value;
- (BOOL)step;
- (BOOL)finalize;
- (BOOL)stepAndFinalize;
- (int)insertedRow;

@end
