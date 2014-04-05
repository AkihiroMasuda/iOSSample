//
//  MyButton.m
//  test12_ImageButtonTest
//
//  Created by 舛田 明寛 on 2014/04/05.
//  Copyright (c) 2014年 AkihiroMasuda. All rights reserved.
//

#import "MyButton.h"

@interface MyButton()
@property UIImage* img00;
@property UIImage* img01;
@property int stat;
@end


@implementation MyButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self coreInit];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
        [self coreInit];
    }
    return self;
}

// 初期化処理
- (void)coreInit
{
    // メンバ変数初期化
    _stat = 0;
    _img00 = [UIImage imageNamed:@"img00.jpg"];
    _img01 = [UIImage imageNamed:@"img01.jpg"];
    
    // 画像セット
    [[self imageView] setContentMode:UIViewContentModeScaleAspectFill];
    [self setBackgroundImage:_img00 forState:UIControlStateNormal];
    
    // ボタン押下コールバック設定
    [self addTarget:self action:@selector(onButton:) forControlEvents:UIControlEventTouchDown];
    
    // タイマーセット
//    [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(timerAct) userInfo:nil repeats:true];

}

//- (void)timerAct
//{
//    [self update];
//}

- (void)update
{
    _stat = (++_stat) % 3;
    switch(_stat){
        case 0:
            self.hidden = YES;
            break;
        case 1:
            self.hidden = NO;
            [self setBackgroundImage:_img01 forState:UIControlStateNormal];
            break;
        case 2:
            self.hidden = NO;
            [self setBackgroundImage:_img00 forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
