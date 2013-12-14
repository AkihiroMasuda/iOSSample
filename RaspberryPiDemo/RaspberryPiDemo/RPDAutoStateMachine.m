//
//  RPDAutoStateMahcine.m
//  RaspberryPiDemo
//
//  Created by 舛田 明寛 on 2013/10/28.
//  Copyright (c) 2013年 AkihiroMasuda. All rights reserved.
//

#import "RPDAutoStateMachine.h"
#import "MBProgressHUD.h"
#import "R9HTTPRequest.h"

#import "RPDDefine.h"


@interface RPDAutoStateMachine ()
@property RPDViewControllerAuto* vcAuto;
@property int curStatus;
@property int imgIndex;
@property UIImageView* imgv1;
@property UIImageView* imgv2;
@property UIImage* img2;
@property NSTimer* timer;
@property MBProgressHUD* hud;
@property BOOL isCanceledMosaicImageCreation;
@property NSMutableArray *imgSamples;
@property UIButton *btn;
@property R9HTTPRequest *request;
@end


@implementation RPDAutoStateMachine

//// 状態マシン設計指針
// -状態の変化は、必ず各状態のイベント処理部(statusXXXX)で行う
//  それ以外のところで状態遷移させてはならない
// -状態から抜けるときの処理はイベント処理部(statusXXXX)で行う
// -状態に遷移した時の初期処理はstateXXXEntryにて行う

- (id) initWith:(RPDViewControllerAuto*)vcAuto;
{
    self = [super init];
    if (self){
        _vcAuto = vcAuto;
        _curStatus = STATUS_STOP;
        _imgIndex = 0;
        _imgSamples = [NSArray arrayWithObjects:@"02.jpeg", @"03.jpeg", @"04.jpeg", @"01.jpeg", @"05.jpeg", nil];
    }
    return self;
}

// イベントディスパッチャ
- (void) dispatchEvent:(int)event
{
    /// TODO: dispatchEventの呼び出し方について再考を。
    /// statusXXXXEntry内部でdispatchEventを発行すると、dispatchEvent内から同じメソッドを再コールすることになる。
    /// 本来は、新たに発生したイベントの処理は、一旦前のイベントの処理が終わってからなされるべき。
    /// つまり、一旦dispatchEventメソッドを抜けだしてから呼ばれるようにすべき。
    /// タイマーを使うなどして、遅延処理されるような設計を。
    int oldStatus = _curStatus;
    // 今の状態に対する処理
    switch(_curStatus) {
        case STATUS_STOP:
            [self statusUnknown:event];
            break;
        case STATUS_INIT:
            [self statusInit:event];
            break;
        case STATUS_DIST:
            [self statusDistributionCalc:event];
            break;
        case STATUS_FIN:
            [self statusFinished:event];
            break;
    }
    // 状態が変更されたときの処理
    if (oldStatus != _curStatus){
        switch(_curStatus) {
            case STATUS_INIT:
                [self statisInitEntry];
                break;
            case STATUS_DIST:
                [self statusDistributionCalcEntry];
                break;
            case STATUS_FIN:
                [self statusFinishedEntry];
                break;
        }
    }
}

///// 未初期化状態
- (void) statisUnknownEntry
{
}

- (void) statusUnknown:(int)event
{
    switch (event) {
        case EVENT_NEXT:
            break;
        case EVENT_INIT:
            _curStatus = EVENT_INIT;
            break;
        case EVENT_BUTTON:
            [self setButtonCancel];
            _curStatus = EVENT_INIT;
            break;
        case EVENT_END:
            break;
    }
}


///// 初期状態
- (void) statisInitEntry
{
    // 画面を初期化。(1枚目を表示。2枚目をクリア)
    _img2 = nil;
    [self clearImageViews];
    [self addIndex];
    [self loadFirstImageView];

    
    // タイマーを発行。一定時間後にEVENT_NEXTを発行
    [self makeAndStartTimerForEventNext];
}

- (void) statusInit:(int)event
{
    switch (event) {
        case EVENT_NEXT:
            _curStatus = STATUS_DIST;
            break;
        case EVENT_INIT:
            // TODO: 何もしなくて良いと思われるが
            break;
        case EVENT_BUTTON:
        case EVENT_END:
            [self clearTimer];
            [self setButtonStart];
            _curStatus = STATUS_STOP;
            break;
    }
}

///// 分散処理中状態
- (void) statusDistributionCalcEntry
{
    // 分散処理開始
    // グルグルを表示
    [self makeAndShowIndicator];

    if (true){
        // 分散処理が終わったらEVENT_NEXT命令を発行するように仕掛ける
        [self createMosaicImage];
    }else{
        // デバッグ用
        [self makeAndStartTimerForEventNext];
    }

}
- (void) statusDistributionCalc:(int)event
{
    switch (event) {
        case EVENT_NEXT:
            [self clearIndicator];
            _curStatus = STATUS_FIN;
            break;
        case EVENT_INIT:
            // TODO: 状態をINITに変える。分散処理を中断する
            [self clearIndicator];
            [self cancelMosaicImageCreation];
            _curStatus = STATUS_INIT;
            break;
        case EVENT_BUTTON:
        case EVENT_END:
            [self clearIndicator];
            [self cancelMosaicImageCreation];
            [self setButtonStart];
            _curStatus = STATUS_STOP;
            break;
    }
}

///// 完了状態
- (void) statusFinishedEntry
{
    // 分散処理結果を使って画面を更新
    [self loadSecondImageView];
    
    // タイマーを発行。一定時間後にEVENT_NEXTを発行
    [self makeAndStartTimerForEventNext];
}
- (void) statusFinished:(int)event
{
    switch (event) {
        case EVENT_NEXT:
            _curStatus = STATUS_INIT;
            break;
        case EVENT_INIT:
            [self clearTimer];
            _curStatus = STATUS_INIT;
            break;
        case EVENT_BUTTON:
        case EVENT_END:
            [self clearTimer];
            [self setButtonStart];
            _curStatus = STATUS_STOP;
            break;
    }
}



////// 内部メソッド
- (NSTimer*) makeAndStartTimerForEventNext
{
    NSTimer *timer = [NSTimer
                      // タイマーイベントを発生させる感覚。「1.5」は 1.5秒 型は float
                      scheduledTimerWithTimeInterval:TIMER_INTERVAL
                      // 呼び出すメソッドの呼び出し先(selector) self はこのファイル(.m)
                      target:self
                      // 呼び出すメソッド名。「:」で自分自身(タイマーインスタンス)を渡す。
                      // インスタンスを渡さない場合は、「timerInfo」
                      selector:@selector(timerInfoEventNext:)
                      // 呼び出すメソッド内で利用するデータが存在する場合は設定する。ない場合は「nil」
                      userInfo:nil
                      // 上記で設定した秒ごとにメソッドを呼び出す場合は、「YES」呼び出さない場合は「NO」
                      repeats:NO
                      ];
    _timer = timer;
    return timer;
}

-(void) timerInfoEventNext:(NSTimer *)timer
{
    [self dispatchEvent:EVENT_NEXT];
}

-(void) clearTimer
{
    if (_timer){
        [_timer invalidate];
        _timer = nil;
    }
}

- (void) makeAndShowIndicator
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:_imgv1 animated:YES];
    hud.labelText = @"分散処理実施中";
    _hud = hud;
}

- (void) clearIndicator
{
    [_hud hide:true];
    _hud = nil;
}

- (void)addIndex
{
    ++_imgIndex;
    if (_imgIndex >= [_imgSamples count]){
        _imgIndex = 0;
    }
}

- (UIImageView *)createImageViewWithName:(NSString*)name
{
    UIImage *img1 = [UIImage imageNamed:name];
    UIImageView *imgview1 = [[UIImageView alloc] initWithImage:img1];
    imgview1.contentMode = UIViewContentModeScaleAspectFill;
    imgview1.clipsToBounds = YES;
    return imgview1;
}

- (UIImageView *)createImageViewWithImage:(UIImage*)img
{
    UIImageView *imgview1 = [[UIImageView alloc] initWithImage:img];
    imgview1.contentMode = UIViewContentModeScaleAspectFill;
    imgview1.clipsToBounds = YES;
    return imgview1;
}


- (void)clearImageViews
{
    if (_imgv1!=NULL){
        [_imgv1 removeFromSuperview];
    }
    if (_imgv2!=NULL){
        [_imgv2 removeFromSuperview];
    }
}

- (void)loadFirstImageView
{
    // 画面の上半分に配置
    {
        int index = _imgIndex;
        NSString *st =[_imgSamples objectAtIndex:index];
        UIImageView *imgview1 = [self createImageViewWithName:st];
        
        CGSize frameSize = _vcAuto.view.frame.size;
        imgview1.frame = CGRectMake(0, HEADER_HEIGHT, frameSize.width, (frameSize.height-HEADER_HEIGHT-TABBAR_HEIGHT)/2);
        [_vcAuto.view addSubview:imgview1];
        _imgv1 = imgview1;
    }
    // ボタンを追加
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _btn = btn;
    [self setButtonCancel];
//    [btn setTitle:@"キャンセル" forState:UIControlStateNormal];
    btn.frame = CGRectMake(0,HEADER_HEIGHT/4,120,30);
    [btn addTarget:self action:@selector(buttonDidPush) forControlEvents:UIControlEventTouchUpInside];

//    [_imgv1 addSubview:btn];
    [_vcAuto.view addSubview:btn];
}

-(void)buttonDidPush
{
    NSLog(@"Cancel pushed.");
    [self dispatchEvent:EVENT_BUTTON];
}

- (void)setButtonCancel
{
    [_btn setTitle:@"キャンセル" forState:UIControlStateNormal];
}

- (void)setButtonStart
{
    [_btn setTitle:@"開始" forState:UIControlStateNormal];
}


- (void)loadSecondImageView
{
    // 画面の下半分に配置
    {
        UIImageView *imgview2 = [self createImageViewWithImage:_img2];
        CGSize frameSize = _vcAuto.view.frame.size;
        imgview2.frame = CGRectMake(0, (frameSize.height-HEADER_HEIGHT-TABBAR_HEIGHT)/2 + HEADER_HEIGHT, frameSize.width, (frameSize.height-HEADER_HEIGHT-TABBAR_HEIGHT)/2);
        [_vcAuto.view addSubview:imgview2];
        _imgv2 = imgview2;
    }
}


- (void)loadSecondImageView_tmp
{
    // 画面の下半分に配置
    {
        UIImageView *imgview2 = [self createImageViewWithName:@"img1.png"];
        CGSize frameSize = _vcAuto.view.frame.size;
        imgview2.frame = CGRectMake(0, frameSize.height/2, frameSize.width, frameSize.height/2);
        [_vcAuto.view addSubview:imgview2];
        _imgv2 = imgview2;
    }
}

- (void)createMosaicImage
{
    _isCanceledMosaicImageCreation = false;
    
    UIImage* originalImage = _imgv1.image;
    
    int w = originalImage.size.width;
    int h = originalImage.size.height;
    NSLog([NSString stringWithFormat:@"w:%d, h:%d", w, h]);
    
    // 画像をPOSTで送る
    // (テスト用のサーバにモザイク画作成サーバを使用）
//    NSURL *URL = [NSURL URLWithString:@"http://192.168.1.2:8080/posttest"];
    NSURL *URL = [NSURL URLWithString:REQUEST_URL];
//    NSURL *URL = [NSURL URLWithString:@"http://192.168.43.215:8080/posttest"];
    R9HTTPRequest *request = [[R9HTTPRequest alloc] initWithURL:URL];
    [request setHTTPMethod:@"POST"];
    // パラメータ追加
    NSString* txtNumOfSampleImages = NUM_OF_SAMPLE_IMAGES;
    [request addBody:txtNumOfSampleImages forKey:@"numOfSampleImages"];
    NSString* txtSrcLongSize = SRC_LONG_SIZE;
    [request addBody:txtSrcLongSize forKey:@"srcLongSize"];
    [request addBody:WORKERS_IP forKey:@"workers"];
//    [request addBody:@"192.168.1.2" forKey:@"workers"];
//    [request addBody:@"192.168.43.215" forKey:@"workers"];
    NSData *pngData = [[NSData alloc] initWithData:UIImagePNGRepresentation(originalImage)];
    // set image data
    [request setData:pngData withFileName:@"sample.png" andContentType:@"image/png" forKey:@"fileUpload"];
//    [request setCompletionHandler:^(NSHTTPURLResponse *responseHeader, NSString *responseString){
//        NSLog(@"%@", responseString);
//    }];
    // Progress
//    [request setUploadProgressHandler:^(float newProgress){
//        NSLog(@"%g", newProgress);
//    }];
    // Response
    [request setCompletionHandler:nil]; // setCompletionHandlerWithData をセットするなら、先にsetCompletionHandler にnilをセットする必要あり。多分、バグ。
    [request setCompletionHandlerWithData:^(NSHTTPURLResponse *responseHeader, NSData *responseData){
        // 応答が来た時の処理
        if (!_isCanceledMosaicImageCreation){
            NSLog(@"responseWithData ");
            UIImage* im = [[UIImage alloc]initWithData:responseData];
            //        _vi.image = im;
            _img2 = im;
            [self dispatchEvent:EVENT_NEXT];
        }else{
            _img2 = nil;
            NSLog(@"responseWithData but canceled.");
        }
    }];
    [request setFailedHandler:^(NSError* error){
        // 応答が来た時の処理
        //エラー発生
        NSString *message = [error localizedDescription];
        NSLog(@"Request is Faild. message:%@", message);
        if (!_isCanceledMosaicImageCreation){
            _img2 = nil;
            [self dispatchEvent:EVENT_NEXT];
        }else{
            NSLog(@"but canceled.");
        }
    }];
    
    [request startRequest];
    _request = request;
}

- (void)cancelMosaicImageCreation
{
    // 本来はここで通信キャンセルしたいが、方法が不明なので
    // とりあえずフラグを立てておく
    // 通信受取メソッドで、キャンセルフラグ立っていたら以降の処理をしないことでキャンセル処理を実現
    _isCanceledMosaicImageCreation = true;
    [_request cancelRequest];
    _request = nil;
}

@end

