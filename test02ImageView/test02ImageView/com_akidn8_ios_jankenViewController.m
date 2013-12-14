//
//  com_akidn8_ios_jankenViewController.m
//  test02ImageView
//
//  Created by 舛田 明寛 on 2013/04/14.
//  Copyright (c) 2013年 舛田 明寛. All rights reserved.
//

#import "com_akidn8_ios_jankenViewController.h"

@interface com_akidn8_ios_jankenViewController ()
{
    bool flg;
}
@end

@implementation com_akidn8_ios_jankenViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    flg = false;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickButton:(UIButton *)sender {
    UIImage *im1 = [UIImage imageNamed:@"kuma_1.png"];
    UIImage *im2 = [UIImage imageNamed:@"P4G_wallHero_1920_1200.jpg"];
    flg = !flg;
    self.imageview.image  = flg ? im1 : im2;
}
@end
