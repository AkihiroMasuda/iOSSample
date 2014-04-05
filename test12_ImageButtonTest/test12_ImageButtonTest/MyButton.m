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
@property int type;
@property NSTimer *animTimer;
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
    // 画像用意
    _img00 = [UIImage imageNamed:@"img00.jpg"];
    _img01 = [UIImage imageNamed:@"img01.jpg"];
    
    // 画像の初期設定
    [[self imageView] setContentMode:UIViewContentModeScaleAspectFill];
    _type = 0;
    [self update];
    
    // ボタン押下コールバック設定
    [self addTarget:self action:@selector(onButton:) forControlEvents:UIControlEventTouchDown];

}

#pragma  mark -appearance
- (void)update
{
    _type = (++_type) % 4;
    switch(_type){
        case 0:
            [self setAppearance00];
            break;
        case 1:
            [self setAppearance01];
            break;
        case 2:
            [self setAppearance02];
            break;
        case 3:
            [self setAppearance03];
            break;
        default:
            break;
    }
}

- (void)setAppearance00
{
    // 一旦タイマーをリセット
    [_animTimer invalidate];
    // 非表示
    self.hidden = YES;
}

- (void)setAppearance01
{
    // 一旦タイマーをリセット
    [_animTimer invalidate];
    // 変身前の画像
    self.hidden = NO;
    [self setBackgroundImage:_img00 forState:UIControlStateNormal];
}

- (void)setAppearance02
{
    // 一旦タイマーをリセット
    [_animTimer invalidate];
    // 変化中アニメーション
    self.hidden = NO;
    [self startAnimationTimer];
}


- (void)setAppearance03
{
    // 一旦タイマーをリセット
    [_animTimer invalidate];
    // 変身後の画像
    self.hidden = NO;
    [self setBackgroundImage:_img01 forState:UIControlStateNormal];
}


#pragma mark -AnimationTimer
// アニメーション表示のためのタイマー
- (void)startAnimationTimer
{
    // タイマーセット
    _animTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(timerAct) userInfo:nil repeats:true];
}

- (void)timerAct
{
    if (self.currentBackgroundImage == _img00){
        [self setBackgroundImage:_img01 forState:UIControlStateNormal];
    }else{
        [self setBackgroundImage:_img00 forState:UIControlStateNormal];
    }
}

#pragma mark -button Call Back
- (void)onButton:(UIButton*)button
{
    NSLog([NSString stringWithFormat:@"Button Clicked!   cur Type = %d", self.type] );
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
