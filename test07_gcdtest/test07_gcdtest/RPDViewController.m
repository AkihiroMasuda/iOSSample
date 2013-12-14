//
//  RPDViewController.m
//  test07_gcdtest
//
//  Created by 舛田 明寛 on 2013/12/08.
//  Copyright (c) 2013年 AkihiroMasuda. All rights reserved.
//

#import "RPDViewController.h"

@interface RPDViewController ()
{
    BOOL _flg;
}
@end

@implementation RPDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    _flg = true;
    dispatch_queue_t q = dispatch_queue_create("hogeque", DISPATCH_QUEUE_SERIAL);
    dispatch_async(q, ^{
        int cnt = 0;
        while(true){
            if (_flg){
                NSDate *d = [NSDate date];
                NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
                [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss.SSS"];
                NSString *dateString = [formatter stringFromDate:d];
                NSLog(@"test07 : cnt=%d, %@", cnt, dateString); // 2012-09-03 12:13:01.432
                [NSThread sleepForTimeInterval:1.0];
                ++cnt;
            }
        }
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClicked:(id)sender {
    // ボタン押下
    _flg = !_flg;
}
@end
