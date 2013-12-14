//
//  RPDAppDelegate.m
//  RaspberryPiDemo
//
//  Created by 舛田 明寛 on 2013/10/27.
//  Copyright (c) 2013年 AkihiroMasuda. All rights reserved.
//

#import "RPDAppDelegate.h"
#import "RPDViewControllerCamera.h"
#import "RPDViewControllerAuto.h"
#import "RPDViewControllerSetting.h"

@interface RPDAppDelegate ()
@property RPDViewControllerCamera *vcCamera;
@property RPDViewControllerAuto *vcAuto;
@property RPDViewControllerSetting *vcSetting;
@property UIViewController *curVC;
@end

@implementation RPDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
  
    // View Controllers for tabController (one viewController per tab)
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];

    // 各ビューコントローラの生成と登録
    _vcCamera = [[RPDViewControllerCamera alloc] init];
    _vcAuto = [[RPDViewControllerAuto alloc] init];
    _vcSetting = [[RPDViewControllerSetting alloc] init];

    [viewControllers addObject:_vcCamera];
    [viewControllers addObject:_vcAuto];
    [viewControllers addObject:_vcSetting];
    
    // create the tab controller and add the view controllers
    UITabBarController *tabController = [[UITabBarController alloc] init];
    [tabController setViewControllers:viewControllers];
    tabController.delegate = self;
    _curVC = [viewControllers objectAtIndex:0];
    
    // タブバーのアイコン・文言設定
    UITabBarItem *item = [tabController.tabBar.items objectAtIndex:0];
    item.title = @"カメラ";
    item.image = [UIImage imageNamed:@"image_32.png"];
    item = [tabController.tabBar.items objectAtIndex:1];
    item.title = @"オート";
    item.image = [UIImage imageNamed:@"refresh_32.png"];
    item = [tabController.tabBar.items objectAtIndex:2];
    item.title = @"設定";
    item.image = [UIImage imageNamed:@"settings_32.png"];
    
    // add tabbar and show
    self.window.rootViewController = tabController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


///  以下TabBarViewControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    UIViewController *oldVC = _curVC;
    _curVC = viewController;
    {
        id obj = oldVC;
        if( [obj conformsToProtocol:@protocol(RPDTabBarChildProtocol)] )
        {
            //対応している時の処理
            [obj tabBarDidReleased];
        }
    }
    {
        id obj = viewController;
        if( [obj conformsToProtocol:@protocol(RPDTabBarChildProtocol)] )
        {
            //対応している時の処理
            [obj tabBarDidSelect];
        }
    }
}

@end
