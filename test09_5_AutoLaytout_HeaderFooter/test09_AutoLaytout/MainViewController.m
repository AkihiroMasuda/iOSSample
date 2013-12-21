//
//  MainViewController.m
//  test09_AutoLaytout
//
//  Created by 舛田 明寛 on 2013/12/21.
//  Copyright (c) 2013年 AkihiroMasuda. All rights reserved.
//
/**
 *　AutoLayoutサンプル
 *　ビューの入れ子構造
 *
 */

#import "MainViewController.h"

#define ROW_HEIGHT 50

@interface MainViewController ()

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

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // よくわからんが、必要？なくても動くが
    [self.view removeConstraints:self.view.constraints];
    
    
    //ヘッダ作成
    UIView *headerBase = [[UIView alloc]init];
    headerBase.backgroundColor = [self headerColor];
    //追加
    [self.view addSubview:headerBase];

    //WebView作成
    UIWebView *webView = [[UIWebView alloc]init];
    webView.delegate = self;
    //追加
    [self.view addSubview:webView];
    
    //フッタ作成
    UIView *footerBase = [[UIView alloc]init];
    footerBase.backgroundColor = [self footerColor];
    //追加
    [self.view addSubview:footerBase];
    
    //おまじない
    [headerBase setTranslatesAutoresizingMaskIntoConstraints:NO];
    [webView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [footerBase setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    //AutoLayout設定
    {
        NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(headerBase, webView, footerBase); //ここで指定した変数名が、下の設定で使われる
        [self setAutoLayoutWidthFillParent:headerBase parent:self.view];
        [self setAutoLayoutWidthFillParent:webView parent:self.view];
        [self setAutoLayoutWidthFillParent:footerBase parent:self.view];
        NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(20)-[headerBase(49)][webView][footerBase(49)]|"
                                                              options:0
                                                              metrics:nil
                                                                views:viewsDictionary];
        [self.view addConstraints:constraints];
    }
    
    // ヘッダ内部を作成
    [self buildHeader:headerBase];
    // フッタ内部を作成
    [self buildFooter:footerBase];
    
    
    //WebViewに何か読み込ませておく
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.kill-la-kill.jp/sp/"]];
    [webView loadRequest:request];

}

// フッターのベース色
- (UIColor*) footerColor
{
//    return [UIColor grayColor];
    return [UIColor colorWithWhite:0.3 alpha:1.];
}

// ヘッダーのベース色
- (UIColor*) headerColor
{
    return [UIColor colorWithWhite:0.3 alpha:1.];
}


// ベース上にボタンを作る
- (UIButton*)createButtonOnBase:(UIView*)baseView
{
    UIButton *btn = [[UIButton alloc]init];
    btn.backgroundColor = [self footerColor];
    [baseView addSubview:btn];
    
    return btn;
}

// フッター作成
- (void)buildFooter:(UIView*)footerBase
{
    UIButton *btn1 = [self createButtonOnBase:footerBase];
    UIButton *btn2 = [self createButtonOnBase:footerBase];
    UIButton *btn3 = [self createButtonOnBase:footerBase];

    // 画像設定
    [btn1 setImage:[UIImage imageNamed:@"node-link.png"] forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"link.png"] forState:UIControlStateNormal];
    [btn3 setImage:[UIImage imageNamed:@"equalizer.png"] forState:UIControlStateNormal];
    
    // AutoLayoutのためのおまじない
    [btn1 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [btn2 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [btn3 setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    //横方向のAutoLayout設定
    {
        NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(btn1, btn2, btn3); //ここで指定した変数名が、下の設定で使われる
        NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(8)-[btn1]-[btn2(==btn1)]-[btn3(==btn1)]-(8)-|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:viewsDictionary];
        [footerBase addConstraints:constraints];
    }

    //縦方向のAutoLayout設定
    [self setAutoLayoutHeightFillParent:btn1 parent:footerBase];
    [self setAutoLayoutHeightFillParent:btn2 parent:footerBase];
    [self setAutoLayoutHeightFillParent:btn3 parent:footerBase];
    
    
}

// ヘッダー作成
- (void)buildHeader:(UIView*)headerBase
{
    UIButton *btn1 = [self createButtonOnBase:headerBase];
    UIButton *btn2 = [self createButtonOnBase:headerBase];
    
    // 画像設定
    [btn1 setImage:[UIImage imageNamed:@"node-link.png"] forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"link.png"] forState:UIControlStateNormal];
    
    // AutoLayoutのためのおまじない
    [btn1 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [btn2 setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    //横方向のAutoLayout設定
    {
        NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(btn1, btn2); //ここで指定した変数名が、下の設定で使われる
        NSArray *constraints;
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(8)-[btn1]"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:viewsDictionary];
        [headerBase addConstraints:constraints];
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[btn2]-(8)-|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:viewsDictionary];
        [headerBase addConstraints:constraints];
    }
    
    //縦方向のAutoLayout設定
    [self setAutoLayoutHeightFillParent:btn1 parent:headerBase];
    [self setAutoLayoutHeightFillParent:btn2 parent:headerBase];
    
}


-(void)webViewDidFinishLoad:(UIWebView*)webView
{
    NSString* url = [webView stringByEvaluatingJavaScriptFromString:@"document.URL"];
    NSLog(@"url:%@", url);
}

/**
 * AutoLayout設定
 * 幅を親のビューに合わせる
 */
- (void)setAutoLayoutWidthFillParent:(UIView*)v parent:(UIView*)p
{
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(v); //ここで指定した変数名が、下の設定で使われる
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[v]|"
                                                          options:0
                                                          metrics:nil
                                                            views:viewsDictionary];
    [p addConstraints:constraints];
}

/**
 * AutoLayout設定
 * 高さを親のビューに合わせる
 */
- (void)setAutoLayoutHeightFillParent:(UIView*)v parent:(UIView*)p
{
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(v); //ここで指定した変数名が、下の設定で使われる
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[v]|"
                                                                   options:0
                                                                   metrics:nil
                                                                     views:viewsDictionary];
    [p addConstraints:constraints];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
