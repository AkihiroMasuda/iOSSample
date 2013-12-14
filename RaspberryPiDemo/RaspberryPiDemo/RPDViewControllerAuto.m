//
//  RPDViewController02.m
//  RaspberryPiDemo
//
//  Created by 舛田 明寛 on 2013/10/27.
//  Copyright (c) 2013年 AkihiroMasuda. All rights reserved.
//

#import "RPDViewControllerAuto.h"
#import "RPDAutoStateMachine.h"

@interface RPDViewControllerAuto ()
@property RPDAutoStateMachine* stateMachine;
@end


@implementation RPDViewControllerAuto

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
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
    //ナビゲーションコントロールを表示する
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    _stateMachine = [[RPDAutoStateMachine alloc] initWith:self];
//    self.view.backgroundColor = [UIColor yellowColor];
    
    // 初期化命令を発行
    [_stateMachine dispatchEvent:EVENT_INIT];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// implement protcol
- (void)tabBarDidSelect
{
    // 初期化命令を発行
    [_stateMachine dispatchEvent:EVENT_INIT];
}
- (void)tabBarDidReleased
{
    // 
    [_stateMachine dispatchEvent:EVENT_END];
}

@end
