//
//  RPDSettings.h
//  RaspberryPiDemo
//
//  Created by 舛田 明寛 on 2013/10/29.
//  Copyright (c) 2013年 AkihiroMasuda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RPDSettings : NSObject
@property NSString *numOfSampleImages;
@property NSString *srcLongSize;
@property NSString *requestURL;
@property NSString *workersIP;
@property NSString *ledEnable;
@property double timerIntarval1;
@property double timerIntarval2;

+ (RPDSettings*)sharedManager;

@end
