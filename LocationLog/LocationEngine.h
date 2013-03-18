//
//  LocationEngine.h
//  LocationLog
//
//  Created by sasgwb on 3/18/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class Track;

@interface LocationEngine : NSObject <CLLocationManagerDelegate>
{
    CLLocationManager* locationManager;
    Track* currentTrack;
}

+ (LocationEngine*) instance;

- (void)start;
- (void)continue;
- (void)stop;

@end
