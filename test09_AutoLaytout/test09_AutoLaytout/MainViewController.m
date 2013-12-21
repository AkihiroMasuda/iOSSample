//
//  MainViewController.m
//  test09_AutoLaytout
//
//  Created by 舛田 明寛 on 2013/12/21.
//  Copyright (c) 2013年 AkihiroMasuda. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // よくわからんが、必要？なくても動くが
    [self.view removeConstraints:self.view.constraints];
    
    // ボタン生成
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"ボタン" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor greenColor];

    // ビューに追加
    [self.view addSubview:btn]; //制約設定前にこれ追加してないとダメっぽい
    
    // AutoLayout有効にするためのおまじない
    [btn setTranslatesAutoresizingMaskIntoConstraints:NO]; // 必須
    
    // AutoLayoutの設定
    // ・水平、垂直それぞれに制約(constraints)を設定する
    // ・水平、垂直とも、すくなくと２つの制約をつける。
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(btn); //ここで指定した変数名が、下の設定で使われる
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(80)-[btn]-(80)-|" //親ビューから左80,右80間を開け、ボタンの幅はそれに合わせる
                                                          options:0
                                                          metrics:nil
                                                            views:viewsDictionary];
    [self.view addConstraints:constraints];
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(100)-[btn(100)]|" //親ビューから上100の間を開け、ボタン高さを100とする
                                                                   options:0
                                                                   metrics:nil
                                                                     views:viewsDictionary];
    [self.view addConstraints:constraints];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
