//
//  PlotlyClient.m
//  test11_PlotlyTest
//
//  Created by 舛田 明寛 on 2014/03/08.
//  Copyright (c) 2014年 AkihiroMasuda. All rights reserved.
//

#import "PlotlyClient.h"

@interface PlotlyClient ()
@property (atomic) NSMutableData* receivedData;
@end

@implementation PlotlyClient

- (id)initWithUserName:(NSString*)un key:(NSString*)key
{
    self = [super init];
    if (self){
        // something to init
        _fileopt = PCL_FILEOPT_OVERWRITE;
        _username = un;
        _key = key;
    }
    return self;
}

#pragma mark -param editor for plotly

/**
 * plotly送信用パラメータを作成する
 * @arg:data ... 入力データ
 *  data[0] .... xデータの配列
 *  data[1] .... y1データの配列
 *  data[2] .... y2データの配列
 *  label ... ラベル
 *  label[i] ... data[i]のラベル
 */
- (NSString*)createParamsStringForPlotlyWithData:(NSArray*)data label:(NSArray*)label filename:(NSString*)fname
{
    NSString *argStr = @"args=[";
    NSArray *dx = data[0];
    int i=0;
    for (NSArray *d in data){
        NSString *argStrOne = @"{";
        
        NSString *strX = @"\"x\":[";
        strX = [[strX stringByAppendingString:[dx componentsJoinedByString:@","]] stringByAppendingString:@"],"];
        NSString *strY = @"\"y\":[";
        strY = [[strY stringByAppendingString:[d componentsJoinedByString:@","]] stringByAppendingString:@"],"];
        NSString *strN = @"\"name\":\"";
        strN = [[strN stringByAppendingString:label[i]] stringByAppendingString:@"\""];
        argStrOne = [argStrOne stringByAppendingString:strX];
        argStrOne = [argStrOne stringByAppendingString:strY];
        argStrOne = [argStrOne stringByAppendingString:strN];
        argStrOne = [argStrOne stringByAppendingString:@"},"];
        
        argStr = [argStr stringByAppendingString:argStrOne];
        ++i;
    }
    // 最後の一文字(カンマ)を削除
    int length = [argStr length];
    argStr = [argStr substringToIndex:(length-1)];
    argStr = [argStr stringByAppendingString:@"]"];
    
    NSString *params = [NSString stringWithFormat:@"un=%@&"
                        "key=%@&"
                        "origin=plot&"
                        "platform=lisp&"
                        "%@"
                        "&"
                        //                        "kwargs={\"filename\": \"plot from api\","
                        "kwargs={\"filename\": \"%@\","
                        "\"fileopt\": \"%@\","
                        "\"layout\": {"
                        "    \"title\": \"experimental data\""
                        "},"
                        "\"world_readable\": true"
                        "}", _username, _key, argStr, fname, _fileopt];
    
    return params;
}


- (void)postPlotWithData:(NSArray*)data labels:(NSArray*)labels
{
    NSURL *theURL = [NSURL URLWithString:@"https://plot.ly/clientresp"];
    
    // リクエスト作成
    NSMutableURLRequest *req=[NSMutableURLRequest requestWithURL:theURL];
    [req setHTTPMethod:@"POST"];	//メソッドをPOSTに指定します
    
//    NSArray *data = @[ @[@(1.5), @(2.2), @(3.9)], @[@(10), @(20), @(30)], @[@(101), @(206.2), @(300.4)]];
//    NSArray *label = @[ @"x1", @"y1", @"y2" ];
//    PlotlyClient* pcl = [[PlotlyClient alloc] initWithUserName:USER_NAME key:API_KEY];
    NSString *params =[self createParamsStringForPlotlyWithData:data label:labels filename:@"newdata"];
    [req setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];		//パラメータを渡します
    
    NSURLConnection *theConnection=[[NSURLConnection alloc]
                                    initWithRequest:req delegate:self];
    if (theConnection) {
        NSLog(@"start loading");
        _receivedData = [[NSMutableData alloc] init];
    }
}

#pragma mark -NSURL delegate

- (void)connection:(NSURLConnection *)connection
didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"receive response");
}

- (void)connection:(NSURLConnection *)connection
    didReceiveData:(NSData *)data
{
    NSLog(@"receive data");
    _receivedData = data;
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"Succeeded! Received %d bytes of data",[_receivedData length]);
    NSLog(@"%@", [[NSString alloc]initWithData:_receivedData
                                      encoding:NSUTF8StringEncoding]);
}




@end
