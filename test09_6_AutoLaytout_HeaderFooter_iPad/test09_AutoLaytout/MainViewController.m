//
//  MainViewController.m
//  test09_AutoLaytout
//
//  Created by 舛田 明寛 on 2013/12/21.
//  Copyright (c) 2013年 AkihiroMasuda. All rights reserved.
//
/**
 *　AutoLayoutサンプル
 *　ヘッダー・フッターを作ってみた
 *
 */

#import "MainViewController.h"

#define ROW_HEIGHT 50
#define FOOTER_HEIGHT 61
#define HEADER_HEIGHT 49

#define BUTTON_HEADER_BACK 101
#define BUTTON_HEADER_LINK 102
#define BUTTON_FOOTER_SHARE 201
#define BUTTON_FOOTER_LINK 202
#define BUTTON_FOOTER_EQUALIZER 203
#define BUTTON_FOOTER_SONGS 204

@interface MainViewController ()
@property UIWebView* webView;
@property UILabel* titleLabel;
@property UIView* footerBase;
@property UIView* footerBtn1;
@property UIView* footerBtn2;
@property UIView* footerBtn3;
@property UIView* footerBtn4;
@property UISearchBar* footerSearchBar;
@property (nonatomic, getter = footerColor) UIColor* footerColor;
@property (nonatomic, getter = headerColor) UIColor* headerColor;
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
    headerBase.backgroundColor = self.headerColor;
    //追加
    [self.view addSubview:headerBase];

    //WebView作成
    UIWebView *webView = [[UIWebView alloc]init];
    webView.delegate = self;
    _webView = webView;
    //追加
    [self.view addSubview:webView];
    
    //フッタ作成
    UIView *footerBase = [[UIView alloc]init];
    // フッタの背景画像設定
    [self setBackgrowndImage:@"base_black_gradation2.png" view:footerBase];
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
        NSString* fmt = [NSString stringWithFormat:@"V:|-(20)-[headerBase(%d)][webView][footerBase(%d)]|", HEADER_HEIGHT, FOOTER_HEIGHT];
        NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:fmt
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

- (void)delayExec
{
    
}


// フッターのベース色
- (UIColor*) footerColor
{
//    return [UIColor grayColor];
    return [UIColor colorWithWhite:0.1 alpha:1.];
}

// ヘッダーのベース色
- (UIColor*) headerColor
{
    return [UIColor colorWithWhite:0.1 alpha:1.];
}

// UIViewの背景に画像を設定する
- (void) setBackgrowndImage:(NSString*)imageName view:(UIView*)view
{
    if (false){
        // タイプ１：普通の方法。タイル状に貼り付け
        UIImage *footerBaseImage = [UIImage imageNamed:imageName]; //フッター背景
        view.backgroundColor = [UIColor colorWithPatternImage:footerBaseImage];
    }else{
        //  タイプ２：領域いっぱいに拡大 こちらのほうが素材のサイズに依らないため望ましい
        // 注意！！　viewDidLoadが呼び終わった後で無いと、viewのサイズが確定しないらしいので一旦キューに積んで後のMainスレッドで実行されるようにする。
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_async(mainQueue, ^{
            CGSize size = view.frame.size;
            CGRect bounds = view.bounds;
            UIGraphicsBeginImageContext(size);
            [[UIImage imageNamed:imageName] drawInRect:bounds];
            UIImage *backgroundImage = UIGraphicsGetImageFromCurrentImageContext();
            UIColor *backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
            UIGraphicsEndImageContext();
            view.backgroundColor = backgroundColor;
        });
    }
}

// ベース上にボタンを作る
- (UIButton*)createButtonOnBase:(UIView*)baseView
{
    UIButton *btn = [[UIButton alloc]init];
    btn.backgroundColor = baseView.backgroundColor;
    [baseView addSubview:btn];
    
    return btn;
}

// ベース上にラベルを作る
- (UILabel*)createLabelOnBase:(UIView*)baseView
{
    UILabel *label = [[UILabel alloc]init];
    [baseView addSubview:label];
    return label;
}

// ベース上に検索窓を作る
- (UISearchBar*)createSearchBarOnBase:(UIView*)baseView
{
    UISearchBar *search = [[UISearchBar alloc]init];
    [baseView addSubview:search];
    return search;
}


// フッターのアイテムを作り、AutoLayout設定する
- (UIView*)createAndLayoutFooterParent:(UIView*)parent ItemImageNamed:(NSString*)imageName labelText:(NSString*)labelText action:(SEL)selector buttonTag:(NSInteger)tag
{
    
    UIView* footerItemBase = [[UIView alloc]init];
    [parent addSubview:footerItemBase];
    
    UIButton *btn = [self createButtonOnBase:footerItemBase];
    UILabel *lbl = [self createLabelOnBase:footerItemBase];
    [btn setTranslatesAutoresizingMaskIntoConstraints:NO];
    [lbl setTranslatesAutoresizingMaskIntoConstraints:NO];

    // ボタン画像設定
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [[btn imageView] setContentMode:UIViewContentModeScaleAspectFill]; //アスペクト比を固定
    btn.backgroundColor = [UIColor colorWithWhite:0 alpha:0]; //ボタン背景は透過して、ベースの色・画像を出させる

    // ラベル設定
    [lbl setText:labelText];
    lbl.textColor = [UIColor whiteColor];
    lbl.textAlignment = NSTextAlignmentCenter; //中央揃え
    lbl.font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]]; //フォントサイズ
//    lbl.backgroundColor = [UIColor greenColor];
    lbl.backgroundColor = [UIColor colorWithWhite:0 alpha:0]; //背景は透過して、ベースの色・画像を出させる
   
    // AutoLayout設定
    // 横方向
    [self setAutoLayoutWidthFillParent:btn parent:footerItemBase];
    [self setAutoLayoutWidthFillParent:lbl parent:footerItemBase];
    // 縦方向AutoLayout設定
    {
        NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(btn, lbl); //ここで指定した変数名が、下の設定で使われる
        NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[btn][lbl(>=0)]|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:viewsDictionary];
        [footerItemBase addConstraints:constraints];
    }
    
    // ボタン押下時のコールバック設定
    footerItemBase.userInteractionEnabled = YES; //通常は不要。ボタンを配置するビューがImageViewのときは、デフォルトがNOになっているため必要らしい
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    btn.tag = tag;
    
    return footerItemBase;
}

// フッターのオートレイアウト設定 (横向き画面用)
- (void)setFooterAutoLayoutForLandscape:(UIView*)footerBase :(UIView *)btn1 :(UIView *)btn2 :(UIView *)btn3 :(UIView *)btn4 :(UISearchBar *)search
{
    // AutoLayoutのためのおまじない
    [btn1 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [btn2 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [btn3 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [btn4 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [search setTranslatesAutoresizingMaskIntoConstraints:NO];

    //横方向のAutoLayout設定
    {
        NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(btn1, btn2, btn3, btn4, search); //ここで指定した変数名が、下の設定で使われる
        NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[btn1][btn2(==btn1)][btn3(==btn1)][btn4(==btn1)]-(200)-[search(400)]|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:viewsDictionary];
        [footerBase addConstraints:constraints];
    }
    
    //縦方向のAutoLayout設定
    [self setAutoLayoutHeightFillParent:btn1 parent:footerBase];
    [self setAutoLayoutHeightFillParent:btn2 parent:footerBase];
    [self setAutoLayoutHeightFillParent:btn3 parent:footerBase];
    [self setAutoLayoutHeightFillParent:btn4 parent:footerBase];
    [self setAutoLayoutHeightFillParent:search parent:footerBase];
    
    NSArray *a = footerBase.constraints;
    NSLog(@"size : %d",[a count]);
}

// フッターのオートレイアウト設定 (縦向き画面用)
- (void)setFooterAutoLayoutForPortrait:(UIView*)footerBase :(UIView *)btn1 :(UIView *)btn2 :(UIView *)btn3 :(UIView *)btn4 :(UISearchBar *)search
{
    // AutoLayoutのためのおまじない
    [btn1 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [btn2 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [btn3 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [btn4 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [search setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    //横方向のAutoLayout設定
    {
        NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(btn1, btn2, btn3, btn4, search); //ここで指定した変数名が、下の設定で使われる
        NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[btn1][btn2(==btn1)][btn3(==btn1)][btn4(==btn1)][search(400)]|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:viewsDictionary];
        [footerBase addConstraints:constraints];
    }
    
    //縦方向のAutoLayout設定
    [self setAutoLayoutHeightFillParent:btn1 parent:footerBase];
    [self setAutoLayoutHeightFillParent:btn2 parent:footerBase];
    [self setAutoLayoutHeightFillParent:btn3 parent:footerBase];
    [self setAutoLayoutHeightFillParent:btn4 parent:footerBase];
    [self setAutoLayoutHeightFillParent:search parent:footerBase];
    
}

// フッターのオートレイアウト設定
- (void)setFooterAutoLayout:(UIView*)footerBase :(UIView *)btn1 :(UIView *)btn2 :(UIView *)btn3 :(UIView *)btn4 :(UISearchBar *)search
{
    // 一旦すべての制約を解除
    NSArray *consts =footerBase.constraints;
    [footerBase removeConstraints:consts];
    
    //向きを調べる
    int orientation = [[UIDevice currentDevice] orientation];
    switch ( orientation ) {
        case UIDeviceOrientationLandscapeLeft:
        case UIDeviceOrientationLandscapeRight:
            // 横画面用
            [self setFooterAutoLayoutForLandscape:footerBase :btn1 :btn2 :btn3 :btn4 :search];
            break;
        case UIDeviceOrientationPortraitUpsideDown:
        case UIDeviceOrientationPortrait:
            //縦画面用
            [self setFooterAutoLayoutForPortrait:footerBase :btn1 :btn2 :btn3 :btn4 :search];
            break;
        default:
            break;
    }
}

// 画面回転許可
- (BOOL)shouldAutorotate
{
    [self setFooterAutoLayout:self.footerBase
                                        :self.footerBtn1
                                        :self.footerBtn2
                                        :self.footerBtn3
                                        :self.footerBtn4
                                        :self.footerSearchBar];
    
    return YES;
}
// 画面回転コールバック
- (NSUInteger)supportedInterfaceOrientations
{
    //Portrait, LandscapeLeft, LandscapeRight の場合画面回転を許可する
    //※ステータスバーが回転する
    return UIInterfaceOrientationMaskAll;
}

// フッター作成
- (void)buildFooter:(UIView*)footerBase
{
    UIView *btn1 = [self createAndLayoutFooterParent:footerBase ItemImageNamed:@"node-link.png" labelText:@"共有" action:@selector(clickButton:) buttonTag:BUTTON_FOOTER_SHARE];
    UIView *btn2 = [self createAndLayoutFooterParent:footerBase ItemImageNamed:@"link.png" labelText:@"リンク" action:@selector(clickButton:) buttonTag:BUTTON_FOOTER_LINK];
    UIView *btn3 = [self createAndLayoutFooterParent:footerBase ItemImageNamed:@"equalizer.png" labelText:@"イコライザ" action:@selector(clickButton:) buttonTag:BUTTON_FOOTER_EQUALIZER];
    UIView *btn4 = [self createAndLayoutFooterParent:footerBase ItemImageNamed:@"g-clef.png" labelText:@"songs" action:@selector(clickButton:) buttonTag:BUTTON_FOOTER_SONGS];
    UISearchBar *search = [self createSearchBarOnBase:footerBase];
    
    self.footerBase = footerBase;
    self.footerBtn1 = btn1;
    self.footerBtn2 = btn2;
    self.footerBtn3 = btn3;
    self.footerBtn4 = btn4;
    self.footerSearchBar = search;
    
    // 検索窓の設定
    search.barTintColor = [UIColor colorWithWhite:0. alpha:0.]; //背景を透明に
    
    // AutoLayout設定
    [self setFooterAutoLayoutForPortrait:footerBase :btn1 :btn2 :btn3 :btn4 :search];
}

// ヘッダー作成
- (void)buildHeader:(UIView*)headerBase
{
    UIButton *btn1 = [self createButtonOnBase:headerBase];
    UIButton *btn2 = [self createButtonOnBase:headerBase];
    UILabel *label = [self createLabelOnBase:headerBase];
    self.titleLabel = label;
    
    // 画像設定
    [btn1 setImage:[UIImage imageNamed:@"arrow-left.png"] forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"link.png"] forState:UIControlStateNormal];
    [[btn1 imageView] setContentMode:UIViewContentModeScaleAspectFill]; //アスペクト比を固定
    [[btn2 imageView] setContentMode:UIViewContentModeScaleAspectFill]; //アスペクト比を固定

    // ラベル設定
    [label setText:@"タイトル"];
    label.textColor = [UIColor whiteColor];
    //    label.backgroundColor = [UIColor blueColor];
    label.textAlignment = NSTextAlignmentCenter; //中央揃え
    
    // ボタン押下時のコールバック設定
    void (^setButtonCallback)(UIButton*, NSInteger) = ^(UIButton* btn, NSInteger tag){
        [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = tag;
    };
    headerBase.userInteractionEnabled = YES; //通常は不要。ボタンを配置するビューがImageViewのときは、デフォルトがNOになっているため必要らしい
    setButtonCallback(btn1, BUTTON_HEADER_BACK);
    setButtonCallback(btn2, BUTTON_HEADER_LINK);
    
    // AutoLayoutのためのおまじない
    [btn1 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [btn2 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [label setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    
    //横方向のAutoLayout設定
    {
        // 左ボタン、中央タイトル、右ボタン、とすべて一つのconstraintsで設定できると良かったのだが、失敗したので
        // 左、右ボタンを１セット、タイトルは別で設定した。
        NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(btn1, btn2, label); //ここで指定した変数名が、下の設定で使われる
        NSArray *constraints;
        // 左、右ボタンの設定
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(8@100)-[btn1(30@100)]-(100@1)-[btn2(==btn1@100)]-(8@100)-|"
                                                              options:0
                                                              metrics:nil
                                                                views:viewsDictionary];
        [headerBase addConstraints:constraints];
        // 中央タイトルの設定
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(40)-[label]-(40)-|"
                                                              options:0
                                                              metrics:nil
                                                                views:viewsDictionary];
        [headerBase addConstraints:constraints];
    }
    
    //縦方向のAutoLayout設定
    [self setAutoLayoutHeightFillParent:btn1 parent:headerBase];
    [self setAutoLayoutHeightFillParent:btn2 parent:headerBase];
    [self setAutoLayoutHeightFillParent:label parent:headerBase];
    
}

/**
 * WebViewコールバック
 */
-(void)webViewDidFinishLoad:(UIWebView*)webView
{
    // タイトル更新
    NSString* title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [self.titleLabel setText:title];
    // ログ
    NSString* url = [webView stringByEvaluatingJavaScriptFromString:@"document.URL"];
    NSLog(@"url:%@   title:%@", url, title);
}


/**
 * ボタン押下コールバック
 */
-(void)clickButton:(UIButton*)button
{
    NSLog(@"buttonClicked  tag:%ld", (long)(button.tag));
    
    switch (button.tag) {
        case BUTTON_HEADER_BACK:
            // 前のページに戻る
            [_webView goBack];
            break;
        case BUTTON_FOOTER_SHARE:{
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.yahoo.co.jp"]];
            [_webView loadRequest:request];
            break;
        }
        case BUTTON_FOOTER_LINK:{
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.moukotanmen-nakamoto.com/"]];
            [_webView loadRequest:request];
            break;
        }
        case BUTTON_FOOTER_EQUALIZER:{
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://developer.android.com/index.html"]];
            [_webView loadRequest:request];
            break;
        }
        case BUTTON_FOOTER_SONGS:{
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.nhk.or.jp/songs/"]];
            [_webView loadRequest:request];
            break;
        }
        default:
            break;
    }
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
