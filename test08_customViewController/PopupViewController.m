//
//  PopupViewController.m
//  test08_customViewController
//
//  Created by 舛田 明寛 on 2013/12/14.
//  Copyright (c) 2013年 AkihiroMasuda. All rights reserved.
//

#import "PopupViewController.h"
#import "AppDelegate.h"

@interface PopupViewController ()

@end

@implementation PopupViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(200,300,500,30);
    btn.backgroundColor = [UIColor greenColor];
    [btn setTitle:@"モーダルビューのボタン" forState:UIControlStateNormal];
    self.view.backgroundColor = [UIColor clearColor]; //モーダルビューを透明化
    [self.view addSubview:btn];
 
    
    AppDelegate *delegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.window addSubview:self.view];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
