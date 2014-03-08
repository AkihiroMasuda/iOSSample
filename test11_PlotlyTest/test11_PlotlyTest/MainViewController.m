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
//    [self makeAlert].show;
    
    // ここから追加
    NSURL *theURL = [NSURL URLWithString:@"https://plot.ly/clientresp"];
    
    // リクエスト作成
    NSMutableURLRequest *req=[NSMutableURLRequest requestWithURL:theURL];
    [req setHTTPMethod:@"POST"];	//メソッドをPOSTに指定します
    
    NSString *params = [NSString stringWithFormat:@"un=akidn8&key=1te408sxxd&"
                        "origin=plot&"
                        "platform=lisp&"
                        "args=[[0, 1, 2], [3, 4, 5], [0,1, 2], [6, 6, 5]]&"
                        "kwargs={\"filename\": \"plot from api\","
                            "\"fileopt\": \"overwrite\","
//                            "\"style\": {"
//                            "    \"type\": \"bar\""
//                            "},"
//                            "\"traces\": [1],"
                            "\"layout\": {"
                            "    \"title\": \"experimental data\""
                            "},"
                            "\"world_readable\": true"
                        "}"];
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
