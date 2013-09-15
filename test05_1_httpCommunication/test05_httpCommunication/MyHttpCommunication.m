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
    NSString* surl;
    connectionDidReceiveResponse resp;
    connectionDidReceiveData data;
    connectionDidReceiveError err;
    connectionDidFinishLoading fin;
}

-(id)initAndOpenUrl:(NSString*)_surl
             Method:(MyHTTPRequestMethod)_method
             Params:(NSString*)_params
               Resp:(connectionDidReceiveResponse)_resp
               Data:(connectionDidReceiveData)_data
              Error:(connectionDidReceiveError)_err
      FinishLoading:(connectionDidFinishLoading)_fin
{
    self = [super init];
    surl = _surl;
    resp = _resp;
    data = _data;
    err = _err;
    fin = _fin;
    
    // ここから追加
    NSURL *theURL = [NSURL URLWithString:surl];
    NSMutableURLRequest *theRequest;
    switch (_method) {
        case POST:{
            theRequest = [NSMutableURLRequest requestWithURL:theURL];
            [theRequest setHTTPMethod:@"POST"];
            [theRequest setHTTPBody:[_params dataUsingEncoding:NSUTF8StringEncoding]];
            break;
        }
        default:{
            NSString *paramsAppendedUrlString;
			if (_params != nil && [_params length] > 0) {
				paramsAppendedUrlString = [NSString stringWithFormat:@"%@?%@", surl, _params];
			}else{
				paramsAppendedUrlString = surl;
			}
			theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:paramsAppendedUrlString]
								   cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
//            [theRequest setHTTPMethod:@"GET"];
            break;
        }
    }
    
    
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
    if (resp!=NULL){
        resp(connection, response);
    }
}

- (void)connection:(NSURLConnection *)connection
    didReceiveData:(NSData *)_data
{
    [receivedData appendData:_data];
    if (data!=NULL){
        data(connection, _data);
    }
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    if (err!=NULL){
        err(connection, error);
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (fin!=NULL){
        fin(connection, receivedData);
    }
}

@end
