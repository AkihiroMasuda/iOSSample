//
//  RPDSettings.m
//  RaspberryPiDemo
//
//  Created by 舛田 明寛 on 2013/10/29.
//  Copyright (c) 2013年 AkihiroMasuda. All rights reserved.
//

#import "RPDSettings.h"
#import "RPDDefine.h"

@implementation RPDSettings

+ (RPDSettings*)sharedManager {
    static RPDSettings* sharedSingleton;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSingleton = [[RPDSettings alloc]
                           initSharedInstance];
    });
    return sharedSingleton;
}

- (id)initSharedInstance {
    self = [super init];
    if (self) {
        // 初期化処理
        _numOfSampleImages = NUM_OF_SAMPLE_IMAGES;
        _srcLongSize = SRC_LONG_SIZE;
        _requestURL = REQUEST_URL;
        _workersIP = WORKERS_IP;
        _ledEnable = LED_ENABLE;
        _timerIntarval1 = TIMER_INTERVAL1;
        _timerIntarval2 = TIMER_INTERVAL2;
    }
    return self;
}

- (id)init {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}



@end
