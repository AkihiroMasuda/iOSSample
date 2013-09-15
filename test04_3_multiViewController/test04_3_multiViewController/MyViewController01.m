//
//  MyViewController01.m
//  test04_3_multiViewController
//
//  Created by 舛田 明寛 on 2013/09/15.
//  Copyright (c) 2013年 AkihiroMasuda. All rights reserved.
//

#import "MyViewController01.h"
#import "MyViewControllerFactory.h"

@interface MyViewController01 ()

@end

@implementation MyViewController01

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

- (IBAction)onClick:(id)sender {
    
    // 次の画面へ遷移
    UIViewController* vc2 = [MyViewControllerFactory createViewController02];
    [self presentViewController:vc2 animated:YES completion:NULL];
}
@end
