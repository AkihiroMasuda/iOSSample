//
//  com_akidn8_ios_jankenViewController.h
//  janken
//
//  Created by 舛田 明寛 on 2013/04/14.
//  Copyright (c) 2013年 舛田 明寛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface com_akidn8_ios_jankenViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *label;
- (IBAction)button:(UIButton *)sender;
@end
