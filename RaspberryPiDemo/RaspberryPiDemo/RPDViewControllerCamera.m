//
//  RPDViewController01.m
//  RaspberryPiDemo
//
//  Created by 舛田 明寛 on 2013/10/27.
//  Copyright (c) 2013年 AkihiroMasuda. All rights reserved.
//

#import "RPDViewControllerCamera.h"
#import "R9HTTPRequest.h"
#import "MBProgressHUD.h"
#import "RPDDefine.h"


@interface RPDViewControllerCamera ()
@property UIButton *btnSend;
@property UIButton *btnCamera;
@property BOOL isUsePopOver;
@property UIPopoverController* imagePopController;
@property UIImage *img1;
@property UIImageView *imgv1;
@property UIImage *img2;
@property UIImageView *imgv2;
@property BOOL isCanceledMosaicImageCreation;
@property MBProgressHUD* hud;
@end

@implementation RPDViewControllerCamera

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // ボタンを追加
    const int BUTTON_WIDTH = 120;
    {
        UIButton *btn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
        _btnSend = btn;
        [_btnSend setTitle:@"送信" forState:UIControlStateNormal];
        _btnSend.frame = CGRectMake(0,HEADER_HEIGHT/4,BUTTON_WIDTH,30);
        [btn addTarget:self action:@selector(sendButtonDidPush) forControlEvents:UIControlEventTouchUpInside];
        //    [_imgv1 addSubview:btn];
        [self.view addSubview:btn];
    }
    {
        UIButton *btn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
        _btnCamera = btn;
        [_btnCamera setTitle:@"カメラ" forState:UIControlStateNormal];
        _btnCamera.frame = CGRectMake(BUTTON_WIDTH + 20,HEADER_HEIGHT/4,BUTTON_WIDTH,30);
        [btn addTarget:self action:@selector(cameraButtonDidPush) forControlEvents:UIControlEventTouchUpInside];
        //    [_imgv1 addSubview:btn];
        [self.view addSubview:btn];
    }
    _img1 = nil;
    
}

- (UIImageView *)createImageViewWithName:(NSString*)name
{
    UIImage *img1 = [UIImage imageNamed:name];
    UIImageView *imgview1 = [[UIImageView alloc] initWithImage:img1];
    imgview1.contentMode = UIViewContentModeScaleAspectFill;
    imgview1.clipsToBounds = YES;
    return imgview1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// implement protcol
// タブバーで選択されたとき
- (void)tabBarDidSelect
{
    // カメラ画面起動
    [self callCameraView];
}
// タブバーで選択状態から抜けた時
- (void)tabBarDidReleased
{
    //
}

-(void)sendButtonDidPush
{
    // 送信ボタン押下
    [self makeAndShowIndicator]; //くるくる表示
    [self createMosaicImage]; //モザイク画作成のためSサーバへ送信
}

-(void)cameraButtonDidPush
{
    // カメラボタン押下
    [self callCameraView];
}

- (void) callCameraView
{
    id sender = _btnSend;
    UIImagePickerControllerSourceType type = UIImagePickerControllerSourceTypeCamera;  //カメラ使用
    //    UIImagePickerControllerSourceType type = UIImagePickerControllerSourceTypePhotoLibrary; //ライブラリから取得
    
    if([UIImagePickerController isSourceTypeAvailable:type]){
        UIImagePickerController* imagepicker = [UIImagePickerController new];
        imagepicker.sourceType = type;
        imagepicker.delegate = self;
        
        _isUsePopOver = false;
        if(type == UIImagePickerControllerSourceTypePhotoLibrary){
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
                NSLog(@"iPhoneの処理");
                imagepicker.allowsEditing = true;
                [self presentViewController:imagepicker animated:YES completion:^{
                    //
                    NSLog(@"カメラ開いた");
                }];
            }
            else{
                NSLog(@"iPadの処理");
                // iPad の場合は、画像選択はポップオーバーからやらないとダメ。
                // 表示に使うPopoverのインスタンスを作成する。 imagePopControllerは、UIPopoverController型のフィールド変数。
                // PopoverのコンテンツビューにImagePickerを指定する。
                _imagePopController = [[UIPopoverController alloc] initWithContentViewController:imagepicker];
                
                // Popoverを表示する。
                // senderはBarButtonItem型の変数で、このボタンを起点にPopoverを開く。
                [_imagePopController presentPopoverFromBarButtonItem:sender
                                            permittedArrowDirections:UIPopoverArrowDirectionAny
                                                            animated:YES];
                _isUsePopOver = true;
            }
        }else{
            imagepicker.allowsEditing = true;
            [self presentViewController:imagepicker animated:YES completion:^{
                //
                NSLog(@"カメラ開いた");
            }];
        }
        
    }
    
}


// 撮影終わって画像を確定したあとで呼ばれる
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage* originalImage = (UIImage*)[info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage* editedImage = (UIImage*)[info objectForKey:UIImagePickerControllerEditedImage];
    
//    _img1 = originalImage;
    _img1 = editedImage;
    
    // 上半分に画像を描画
    [self loadFirstImageView];
    
    if (_isUsePopOver){
        // ポップオーバーを消す
        [_imagePopController dismissPopoverAnimated:YES];
    }else{
        // カメラ撮影ビューコントローラを閉じる
        [self dismissViewControllerAnimated:true completion:^{}];
    }
    
}



- (UIImageView *)createImageViewWithImage:(UIImage*)img
{
    UIImageView *imgview1 = [[UIImageView alloc] initWithImage:img];
    imgview1.contentMode = UIViewContentModeScaleAspectFill;
    imgview1.clipsToBounds = YES;
    return imgview1;
}

- (void)loadFirstImageView
{
    // 画面の上半分に配置
    {
        UIImageView *imgview1 = [self createImageViewWithImage:_img1];
        CGSize frameSize = self.view.frame.size;
        imgview1.frame = CGRectMake(0, HEADER_HEIGHT, frameSize.width, (frameSize.height-HEADER_HEIGHT-TABBAR_HEIGHT)/2);
//        imgview1.contentMode = UIViewContentModeScaleAspectFill; //アスペクト比を維持したまま Viewに空きがないように表示
        imgview1.contentMode = UIViewContentModeScaleAspectFit; //アスペクト比を維持したまま 画像のすべてが表示されるようにリサイズ
        imgview1.clipsToBounds = YES;
        [self.view addSubview:imgview1];
        _imgv1 = imgview1;
    }
}
- (void)loadSecondImageView
{
    // 画面の下半分に配置
    {
        UIImageView *imgview2 = [self createImageViewWithImage:_img2];
        CGSize frameSize = self.view.frame.size;
        imgview2.frame = CGRectMake(0, (frameSize.height-HEADER_HEIGHT-TABBAR_HEIGHT)/2 + HEADER_HEIGHT, frameSize.width, (frameSize.height-HEADER_HEIGHT-TABBAR_HEIGHT)/2);
        imgview2.contentMode = UIViewContentModeScaleAspectFit; //アスペクト比を維持したまま 画像のすべてが表示されるようにリサイズ
        imgview2.clipsToBounds = YES;
        [self.view addSubview:imgview2];
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
            [self loadSecondImageView];
            [self clearIndicator];
//            [self dispatchEvent:EVENT_NEXT];
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
        [self clearIndicator];
        if (!_isCanceledMosaicImageCreation){
            _img2 = nil;
//            [self dispatchEvent:EVENT_NEXT];
        }else{
            NSLog(@"but canceled.");
        }
    }];
    
    [request startRequest];
//    _request = request;
}

- (void) makeAndShowIndicator
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:_imgv1 animated:YES];
    hud.labelText = @"分散処理実施中";
    _hud = hud;
}

- (void) clearIndicator
{
    if (_hud!=nil){
        [_hud hide:true];
        _hud = nil;
    }
}


@end
