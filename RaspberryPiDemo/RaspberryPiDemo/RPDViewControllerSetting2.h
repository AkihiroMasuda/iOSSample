//
//  RPDViewControllerSetting2.h
//  RaspberryPiDemo
//
//  Created by 舛田 明寛 on 2013/10/29.
//  Copyright (c) 2013年 AkihiroMasuda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RPDViewControllerBase.h"

@interface RPDViewControllerSetting2 : UIViewController <RPDTabBarChildProtocol>
@property (weak, nonatomic) IBOutlet UITextField *NumOfSampleImages;
@property (weak, nonatomic) IBOutlet UITextField *srcLongSize;
@property (weak, nonatomic) IBOutlet UITextField *requestURL;
@property (weak, nonatomic) IBOutlet UITextField *workersIP;
@property (weak, nonatomic) IBOutlet UISwitch *ledEnable;
- (IBAction)pushSaveButton:(UIButton *)sender;
- (IBAction)pushCancelButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *timerInterval1;
@property (weak, nonatomic) IBOutlet UITextField *timerInterval2;

@end
