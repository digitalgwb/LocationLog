//
//  TrackPointCell.h
//  LocationLog
//
//  Created by sasgwb on 3/26/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrackPointCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *timestamp;
@property (weak, nonatomic) IBOutlet UILabel *latitude;
@property (weak, nonatomic) IBOutlet UILabel *longitude;

@end
