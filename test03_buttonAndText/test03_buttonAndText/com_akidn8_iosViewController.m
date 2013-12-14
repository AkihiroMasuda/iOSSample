//
//  com_akidn8_iosViewController.m
//  test03_buttonAndText
//
//  Created by 舛田 明寛 on 2013/09/08.
//  Copyright (c) 2013年 舛田 明寛. All rights reserved.
//

#import "com_akidn8_iosViewController.h"

@interface com_akidn8_iosViewController ()

@end

@implementation com_akidn8_iosViewController

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

- (IBAction)onBtn01Click:(UIButton *)sender {
    self.lbl01.text = self.txt01.text;
//    self.lbl01.text = @"ハゲ散らかす";
}
@end
