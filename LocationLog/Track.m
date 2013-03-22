//
//  Track.m
//  LocationLog
//
//  Created by sasgwb on 3/18/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import "Track.h"

@implementation Track

@synthesize key;
@synthesize timestamp;
@synthesize description;

- (id)init
{
    self = [super init];
    if (self)
    {
        [self setTimestamp:[NSDate date]];
    }
    
    return self;
}
@end
