//
//  MyViewController.h
//  test05_2_R9HTTPRequest
//
//  Created by 舛田 明寛 on 2013/09/15.
//  Copyright (c) 2013年 AkihiroMasuda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyViewController : UIViewController <UIScrollViewDelegate>
- (IBAction)onButton1Click:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *sv;
@property (weak, nonatomic) IBOutlet UITextField *txtSearchImageNum;

@property (weak, nonatomic) IBOutlet UIImageView *vi;
@end
