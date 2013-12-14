//
//  RPDViewControllerBase.h
//  RaspberryPiDemo
//
//  Created by 舛田 明寛 on 2013/10/27.
//  Copyright (c) 2013年 AkihiroMasuda. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RPDTabBarChildProtocol
@required 
- (void) tabBarDidSelect;
- (void) tabBarDidReleased;
@end


