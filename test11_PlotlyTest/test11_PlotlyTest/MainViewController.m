//
//  MainViewController.m
//  test11_PlotlyTest
//
//  Created by 舛田 明寛 on 2014/03/08.
//  Copyright (c) 2014年 AkihiroMasuda. All rights reserved.
//

#import "MainViewController.h"

#define USER_NAME @"akidn8"
#define API_KEY @"1te408sxxd"

@interface MainViewController ()
@property (atomic) UIButton* btn;
@property (atomic) NSMutableData* receivedData;
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    
    _btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_btn setTitle:@"hogehoge" forState:UIControlStateNormal];
    _btn.frame = CGRectMake(10,10,100,200);
    [_btn addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchDown];
    
    

    
    [self.view addSubview:_btn];
    
}

- (void)onButtonClick:(UIButton*)btn
{
    // ここから追加
    NSURL *theURL = [NSURL URLWithString:@"https://plot.ly/clientresp"];
    
    // リクエスト作成
    NSMutableURLRequest *req=[NSMutableURLRequest requestWithURL:theURL];
    [req setHTTPMethod:@"POST"];	//メソッドをPOSTに指定します

    NSArray *data = @[ @[@(1), @(2), @(3)], @[@(10), @(20), @(30)]];
    NSArray *label = @[ @"x1", @"y1" ];
    NSString *params =[self createParamsStringForPlotlyWithData:data label:label filename:@"newdata"];
    
    [req setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];		//パラメータを渡します
    
    
    NSURLConnection *theConnection=[[NSURLConnection alloc]
                                    initWithRequest:req delegate:self];
    if (theConnection) {
        NSLog(@"start loading");
        _receivedData = [[NSMutableData alloc] init];
    }
    // ここまで追加
    
}

- (UIAlertView*)makeAlert
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Title"
                                                    message:@"message"
                                                   delegate:self
                                          cancelButtonTitle:@"cancel"
                                          otherButtonTitles:@"OK", nil];
    return alert;
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
    
    NSString *params = [NSString stringWithFormat:@"un=akidn8&key=1te408sxxd&"
                        "origin=plot&"
                        "platform=lisp&"
                        "%@"
                        "&"
//                        "kwargs={\"filename\": \"plot from api\","
                        "kwargs={\"filename\": \"%@\","
                        "\"fileopt\": \"overwrite\","
                        "\"layout\": {"
                        "    \"title\": \"experimental data\""
                        "},"
                        "\"world_readable\": true"
                        "}", argStr, fname];
    
    
    
    return params;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
