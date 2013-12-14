//
//  MyViewController02.m
//  test04_3_multiViewController
//
//  Created by 舛田 明寛 on 2013/09/15.
//  Copyright (c) 2013年 AkihiroMasuda. All rights reserved.
//

#import "MyViewController02.h"

@interface MyViewController02 ()

@end

@implementation MyViewController02

- (void) dealloc
{
    NSLog(@"MyViewController02 dealloc");
}

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

- (IBAction)onButtonClick:(id)sender {
    NSLog(@"close");
//    [self dismissViewControllerAnimated:YES completion:NULL];
    [[self navigationController] popViewControllerAnimated:TRUE];
}
@end
