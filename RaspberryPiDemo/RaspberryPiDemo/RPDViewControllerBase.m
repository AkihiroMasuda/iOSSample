//
//  RPDViewControllerBase.m
//  RaspberryPiDemo
//
//  Created by 舛田 明寛 on 2013/10/27.
//  Copyright (c) 2013年 AkihiroMasuda. All rights reserved.
//

#import "RPDViewControllerBase.h"

@interface UIViewController ()

@end

@implementation UIViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
