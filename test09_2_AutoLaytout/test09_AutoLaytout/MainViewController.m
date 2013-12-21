//
//  MainViewController.m
//  test09_AutoLaytout
//
//  Created by 舛田 明寛 on 2013/12/21.
//  Copyright (c) 2013年 AkihiroMasuda. All rights reserved.
//
/**
 *　AutoLayoutサンプル
 *　ビューの入れ子構造
 *
 */

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

    // 基礎ビュー作成
    UIView *viewBase = [[UIView alloc]init];
    viewBase.backgroundColor = [UIColor blueColor];
    // 追加
    [self.view addSubview:viewBase];
    // AutoLayout有効にするためのおまじない
    [viewBase setTranslatesAutoresizingMaskIntoConstraints:NO]; // 必須
    
    // ボタン生成
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"ボタン" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor greenColor];
    // 基礎ビューに追加
    [viewBase addSubview:btn]; //制約設定前にこれ追加してないとダメっぽい
    // AutoLayout有効にするためのおまじない
    [btn setTranslatesAutoresizingMaskIntoConstraints:NO]; // 必須
    
    // AutoLayoutの設定(基礎ビュー上のボタンについて)
    {
        NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(btn); //ここで指定した変数名が、下の設定で使われる
        NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(8)-[btn]-(60)-|" //親ビューから左8,右60間を開け、ボタンの幅はそれに合わせる
                                                                       options:0
                                                                       metrics:nil
                                                                         views:viewsDictionary];
        [viewBase addConstraints:constraints];
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(16)-[btn(100)]|" //親ビューから上16の間を開け、ボタン高さを100とする
                                                              options:0
                                                              metrics:nil
                                                                views:viewsDictionary];
        [viewBase addConstraints:constraints];
    }

    // AutoLayoutの設定(基礎ビューについて)
    {
        NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(viewBase); //ここで指定した変数名が、下の設定で使われる
        NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(30)-[viewBase]-(30)-|" //親ビューから左30,右30間を開け、viewBaseの幅はそれに合わせる
                                                                       options:0
                                                                       metrics:nil
                                                                         views:viewsDictionary];
        [self.view addConstraints:constraints];
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(100)-[viewBase]-(100)-|" //親ビューから上100の間を開け、ボタン高さを100とする
                                                              options:0
                                                              metrics:nil
                                                                views:viewsDictionary];
        [self.view addConstraints:constraints];
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
