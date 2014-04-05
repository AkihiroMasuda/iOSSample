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

    {
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        MyButton *btn = [[MyButton alloc] init];
        btn.frame = CGRectMake(100, 100, 200, 200);
        
        [self.view addSubview:btn];
        
        _button = btn;
    }
    
    {
        UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(10, 300, 50, 50);
        btn.backgroundColor = [UIColor blueColor];
        [btn setTitle:@"hoge" forState:UIControlStateNormal];
        [self.view addSubview:btn];
        [btn addTarget:self action:@selector(onButton:) forControlEvents:UIControlEventTouchDown];
        _button2 = btn;
    }
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onButton:(UIButton*)btn
{
    [_button update];
}


@end
