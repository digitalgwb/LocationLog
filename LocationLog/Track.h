//
//  Track.h
//  LocationLog
//
//  Created by sasgwb on 3/18/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Track : NSObject
{
    int key;
    NSDate* timestamp;
    NSString* description;
}

@end