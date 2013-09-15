//
//  MyHttpCommunication.m
//  test05_httpCommunication
//
//  Created by 舛田 明寛 on 2013/09/15.
//  Copyright (c) 2013年 AkihiroMasuda. All rights reserved.
//

#import "MyHttpCommunication.h"

@implementation MyHttpCommunication
{
    id receivedData;
    connectionDidReceiveResponse resp;
    connectionDidReceiveData data;
    connectionDidReceiveError err;
    connectionDidFinishLoading fin;
}

-(id)initWithResp:(connectionDidReceiveResponse)_resp
    Data:(connectionDidReceiveData)_data
    Error:(connectionDidReceiveError)_err
    FinishLoading:(connectionDidFinishLoading)_fin
{
    self = [super init];
    resp = _resp;
    data = _data;
    err = _err;
    fin = _fin;
    
    // ここから追加
    NSURL *theURL = [NSURL URLWithString:@"http://www.yahoo.co.jp/"];
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:theURL];
    NSURLConnection *theConnection=[[NSURLConnection alloc]
                                    initWithRequest:theRequest delegate:self];
    if (theConnection) {
        NSLog(@"start loading");
        //        receivedData = [[NSMutableData data] retain];
        receivedData = [NSMutableData data];
    }
    // ここまで追加
    return self;
}

- (void)connection:(NSURLConnection *)connection
didReceiveResponse:(NSURLResponse *)response
{
    [receivedData setLength:0];
    resp(connection, response);
}

- (void)connection:(NSURLConnection *)connection
    didReceiveData:(NSData *)_data
{
    [receivedData appendData:_data];
    data(connection, _data);
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    err(connection, error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    fin(connection, receivedData);
}


@end
