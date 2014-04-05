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
@property UIButton* button3;
@property bool isButtonHidden;
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

    // 画像ボタンを常に非表示にするためのボタン
    {
        UIButton *btn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame = CGRectMake(160, 400, 120, 50);
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitle:@"常に非表示" forState:UIControlStateNormal];
        [self.view addSubview:btn];
        _button3 = btn;
        
        // コールバック設定
        [btn addTarget:self action:@selector(onButton:) forControlEvents:UIControlEventTouchDown];
    }
    
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.isButtonHidden = false;
    
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
    if (btn == _button2){
        // ボタン画像を変更
        [_button nextType];
    }else{
        // ボタンを強制非表示にする
        self.isButtonHidden = !self.isButtonHidden;
        [_button setPemmanentlyHidden:self.isButtonHidden];
    }
}


@end
