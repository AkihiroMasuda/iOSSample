//
//  MyViewController.m
//  test04_multiWindows
//
//  Created by 舛田 明寛 on 2013/09/14.
//  Copyright (c) 2013年 AkihiroMasuda. All rights reserved.
//

#import "MyViewController.h"
#import "MyNewController.h"


@implementation MyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onButtonClick:(id)sender {
    // アラートを出してみる
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Demo Alert"
                                                    message:@"demo appl"
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"OK", nil];
//    [alert show];
    
    
    /// Storyboardからビューコントローラを生成する方法
    //Storyboardを特定して
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
    //そのStoryboardにある遷移先のViewConrollerを用意して
    UIViewController *vc2 = [storyboard instantiateViewControllerWithIdentifier:@"MyNewController"];
    
    // コントローラ生成
//    MyNewController* controller = [[MyNewController alloc] init];
    // 次の画面へ遷移
//    [self presentViewController:controller animated:YES completion:NULL];
    [self presentViewController:vc2 animated:YES completion:NULL];
    
}
@end
