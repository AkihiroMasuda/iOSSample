//
//  MyViewControllerFactory.h
//  test04_3_multiViewController
//
//  Created by 舛田 明寛 on 2013/09/15.
//  Copyright (c) 2013年 AkihiroMasuda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MyViewControllerFactory : NSObject
+ (UIViewController*) createViewController01;
+ (UIViewController*) createViewController02;
+ (NSString*) getStoryboardName;
@end
