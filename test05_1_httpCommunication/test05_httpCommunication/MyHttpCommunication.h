//
//  MyHttpCommunication.h
//  test05_httpCommunication
//
//  Created by 舛田 明寛 on 2013/09/15.
//  Copyright (c) 2013年 AkihiroMasuda. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
	GET,
	POST
} MyHTTPRequestMethod;

typedef void (^connectionDidReceiveResponse)(NSURLConnection*, NSURLResponse*);
typedef void (^connectionDidReceiveData)(NSURLConnection*, NSData*);
typedef void (^connectionDidReceiveError)(NSURLConnection*, NSError*);
typedef void (^connectionDidFinishLoading)(NSURLConnection*, id);

@interface MyHttpCommunication : NSObject
-(id)initAndOpenUrl:(NSString*)surl
             Method:(MyHTTPRequestMethod)method
             Params:(NSString*)params
               Resp:(connectionDidReceiveResponse)resp
               Data:(connectionDidReceiveData)data
              Error:(connectionDidReceiveError)err
      FinishLoading:(connectionDidFinishLoading)fin;
@end
