//
//  Header.h
//  RaspberryPiDemo
//
//  Created by 舛田 明寛 on 2013/10/28.
//  Copyright (c) 2013年 AkihiroMasuda. All rights reserved.
//

#ifndef RaspberryPiDemo_Header_h
#define RaspberryPiDemo_Header_h

#define TIMER_INTERVAL1 (3.0f)
#define TIMER_INTERVAL2 (5.0f)
#define HEADER_HEIGHT (60)
#define TABBAR_HEIGHT (60)
#define NUM_OF_SAMPLE_IMAGES @"500" // モザイク画作成につかうサンプル数。多いほど精度良くなる
#define SRC_LONG_SIZE @"32" // 画像をダウンスケールしたときの長編の画素数。多いほど細かい画像になる
#define REQUEST_URL @"http://192.168.1.2:8080/posttest" //サーバへのリクエストURL
#define WORKERS_IP @"192.168.1.240,192.168.1.241,192.168.1.242,192.168.1.243" //分散処理サーバのIP
#define LED_ENABLE @"False"

#define IMAGE_VIEW_MIN_SCALE (0.02f)
#define IMAGE_VIEW_MAX_SCALE (10.f)

#define BUTTON_WIDTH (140)
#define BUTTON_HEIGHT (30)
#define PLAY_WIDTH (10)


#endif
