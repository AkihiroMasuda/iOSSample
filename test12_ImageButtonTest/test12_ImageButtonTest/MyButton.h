//
//  MyButton.h
//  test12_ImageButtonTest
//
//  Created by 舛田 明寛 on 2014/04/05.
//  Copyright (c) 2014年 AkihiroMasuda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyButton : UIButton

// ボタンのタイプを変更し、表示を変える
- (void)update;

// ボタンのタイプによらず、常に非表示にする
- (void)setPemmanentlyHidden:(bool)isHidden;

@end
