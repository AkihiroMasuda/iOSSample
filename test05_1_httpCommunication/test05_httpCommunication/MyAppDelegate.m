//
//  MyAppDelegate.m
//  test04_3_multiViewController
//
//  Created by 舛田 明寛 on 2013/09/15.
//  Copyright (c) 2013年 AkihiroMasuda. All rights reserved.
//

#import "MyAppDelegate.h"
#import "MyViewControllerFactory.h"
#import "MyHttpCommunication.h"

@implementation MyAppDelegate
{
    UIViewController *vc01;
    id receivedData;
    id com;
}

//typedef void (^hoge)(NSURLConnection*, NSData*);

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    // 初期表示のビューコントローラを作成、ヒョじ
    vc01 = [MyViewControllerFactory createViewController01];
    [self.window setRootViewController:vc01];

    // 通信オブジェクト生成
    connectionDidReceiveResponse r =^(NSURLConnection* con, NSURLResponse* dat){
        NSLog(@"receive response");
    };
    connectionDidReceiveData d =^(NSURLConnection* con, NSData* dat){
        NSLog(@"receive data");
    };
    connectionDidReceiveError e =^(NSURLConnection* con, NSError* error){
        NSLog(@"Connection failed! Error - %@ %@",
              [error localizedDescription],
              [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
    };
    connectionDidFinishLoading f =^(NSURLConnection* con, id receivedData){
        NSLog(@"Succeeded! Received %d bytes of data",[receivedData length]);
        NSLog(@"%@", [[NSString alloc]initWithData:receivedData
                                          encoding:NSUTF8StringEncoding]);
    };
    com = [[MyHttpCommunication alloc] initWithResp:r Data:d Error:e FinishLoading:f];
    
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

@end
