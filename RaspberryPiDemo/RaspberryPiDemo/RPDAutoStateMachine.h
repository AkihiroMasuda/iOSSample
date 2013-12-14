//
//  RPDAutoStateMahcine.h
//  RaspberryPiDemo
//
//  Created by 舛田 明寛 on 2013/10/28.
//  Copyright (c) 2013年 AkihiroMasuda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPDViewControllerAuto.h"

@interface RPDAutoStateMachine : NSObject

// 状態定義
enum {
    STATUS_STOP, //初回起動時の未初期化状態.INITに遷移するまでの暫定状態
    STATUS_INIT,
    STATUS_DIST,
    STATUS_FIN,
};

// イベント定義
enum {
    EVENT_NEXT, //次の状態への遷移促す
    EVENT_INIT, //初期化状態へ戻れ命令
    EVENT_BUTTON, //ボタン押下
    EVENT_END, //終了命令
};

- (id) initWith:(RPDViewControllerAuto*)vcAuto;

- (void) dispatchEvent:(int)event;


@end
