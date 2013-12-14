//
//  ViewController.m
//  Counter
//
//  Created by 舛田 明寛 on 2013/04/07.
//  Copyright (c) 2013年 Akihiro. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

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

- (IBAction)plusButton:(id)sender {
    counter++;
    label.text = [NSString stringWithFormat:@"%d", counter];
    
}
@end
