//
//  com_akidn8_ios_jankenViewController.m
//  janken
//
//  Created by 舛田 明寛 on 2013/04/14.
//  Copyright (c) 2013年 舛田 明寛. All rights reserved.
//

#import "com_akidn8_ios_jankenViewController.h"

@interface com_akidn8_ios_jankenViewController ()

@end

@implementation com_akidn8_ios_jankenViewController

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

- (IBAction)button:(UIButton *)sender {
    self.label.text = @"ジャーンジャーン";
}
@end
