//
//  MyViewControllerFactory.m
//  test04_3_multiViewController
//
//  Created by 舛田 明寛 on 2013/09/15.
//  Copyright (c) 2013年 AkihiroMasuda. All rights reserved.
//

#import "MyViewControllerFactory.h"


@implementation MyViewControllerFactory
+ (UIViewController*) createViewController01
{
    //Storyboardを特定して
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:[MyViewControllerFactory getStoryboardName] bundle:nil];
    //そのStoryboardにある遷移先のViewConrollerを用意して
    UIViewController *c = [storyboard instantiateViewControllerWithIdentifier:@"MyViewController01"];
    return c;
}

+ (UIViewController*) createViewController02
{
    //Storyboardを特定して
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:[MyViewControllerFactory getStoryboardName] bundle:nil];
    //そのStoryboardにある遷移先のViewConrollerを用意して
    UIViewController *c = [storyboard instantiateViewControllerWithIdentifier:@"MyViewController02"];
    return c;
}


+ (NSString*) getStoryboardName
{
    return @"Storyboard";
}

@end
