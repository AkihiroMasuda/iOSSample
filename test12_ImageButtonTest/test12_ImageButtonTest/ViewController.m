//
//  ViewController.m
//  test12_ImageButtonTest
//
//  Created by 舛田 明寛 on 2014/04/05.
//  Copyright (c) 2014年 AkihiroMasuda. All rights reserved.
//

#import "ViewController.h"
#import "MyButton.h"

@interface ViewController ()
@property MyButton* button;
@property UIButton* button2;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // 画像ボタン作成
    {
        MyButton *btn = [[MyButton alloc] init];
        btn.frame = CGRectMake(100, 100, 200, 200);
        [self.view addSubview:btn];
        _button = btn;
    }
    
    // 画像ボタンの画像を切替えるボタン作成
    {
        UIButton *btn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame = CGRectMake(10, 400, 150, 50);
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitle:@"画像切替" forState:UIControlStateNormal];
        [self.view addSubview:btn];
        _button2 = btn;

        // コールバック設定
        [btn addTarget:self action:@selector(onButton:) forControlEvents:UIControlEventTouchDown];
    }
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// ボタン押下コールバック
- (void)onButton:(UIButton*)btn
{
    [_button update];
}


@end
