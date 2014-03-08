//
//  PlotlyClient.h
//  test11_PlotlyTest
//
//  Created by 舛田 明寛 on 2014/03/08.
//  Copyright (c) 2014年 AkihiroMasuda. All rights reserved.
//

#import <UIKit/UIKit.h>


#define PCL_FILEOPT_NEW @"new"
#define PCL_FILEOPT_OVERWRITE @"overwrite"
#define PCL_FILEOPT_APPEND @"append"
#define PCL_FILEOPT_EXTEND @"extend"

@interface PlotlyClient : NSObject

@property (strong, atomic) NSString* fileopt;
@property (strong, atomic) NSString* username;
@property (strong, atomic) NSString* key;

- (id)initWithUserName:(NSString*)un key:(NSString*)key;

/**
 * plotly送信用パラメータを作成する
 * @arg:data ... 入力データ
 *  data[0] .... xデータの配列
 *  data[1] .... y1データの配列
 *  data[2] .... y2データの配列
 *  label ... ラベル
 *  label[i] ... data[i]のラベル
 */
- (NSString*)createParamsStringForPlotlyWithData:(NSArray*)data label:(NSArray*)label filename:(NSString*)fname;


/**
 * plotlyにplot命令発行
 * @arg:data ... 入力データ
 *  data[0] .... xデータの配列
 *  data[1] .... y1データの配列
 *  data[2] .... y2データの配列
 *  label ... ラベル
 *  label[i] ... data[i]のラベル
 */
- (void)postPlotWithData:(NSArray*)data labels:(NSArray*)labels;

@end
