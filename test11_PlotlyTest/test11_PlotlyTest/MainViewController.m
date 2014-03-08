//
//  MainViewController.m
//  test11_PlotlyTest
//
//  Created by 舛田 明寛 on 2014/03/08.
//  Copyright (c) 2014年 AkihiroMasuda. All rights reserved.
//

#import "MainViewController.h"
#import "PlotlyClient.h"

#define USER_NAME @"akidn8"
#define API_KEY @"1te408sxxd"

@interface MainViewController ()
@property (atomic) UIButton* btn;
@property (atomic) NSMutableData* receivedData;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    
    _btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_btn setTitle:@"hogehoge" forState:UIControlStateNormal];
    _btn.frame = CGRectMake(10,10,100,200);
    [_btn addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchDown];
    
    

    
    [self.view addSubview:_btn];
    
}

- (void)onButtonClick:(UIButton*)btn
{
//    NSArray *data = @[ @[@(1.5), @(2.2), @(3.9)], @[@(10), @(20), @(30)], @[@(101), @(206.2), @(300.4)]];
    NSArray *data = @[ @[@(15), @(22), @(39)], @[@(10), @(20), @(30)], @[@(101), @(206.2), @(300.4)]];
    NSArray *labels = @[ @"x1", @"y1", @"y2" ];
    PlotlyClient* pcl = [[PlotlyClient alloc] initWithUserName:USER_NAME key:API_KEY];
    [pcl postPlotWithData:data labels:labels filename:@"my"];
}

- (UIAlertView*)makeAlert
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Title"
                                                    message:@"message"
                                                   delegate:self
                                          cancelButtonTitle:@"cancel"
                                          otherButtonTitles:@"OK", nil];
    return alert;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
