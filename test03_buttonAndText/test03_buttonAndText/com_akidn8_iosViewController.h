//
//  com_akidn8_iosViewController.h
//  test03_buttonAndText
//
//  Created by 舛田 明寛 on 2013/09/08.
//  Copyright (c) 2013年 舛田 明寛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface com_akidn8_iosViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lbl01;
- (IBAction)onBtn01Click:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *txt01;

@end
