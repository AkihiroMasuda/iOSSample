//
//  MyViewController.m
//  test05_2_R9HTTPRequest
//
//  Created by 舛田 明寛 on 2013/09/15.
//  Copyright (c) 2013年 AkihiroMasuda. All rights reserved.
//

#import "MyViewController.h"
#import "R9HTTPRequest.h"

@interface MyViewController ()
{
    UIPopoverController* imagePopController;
    BOOL isUsePopOver;
}

@end

@implementation MyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onButton1Click:(id)sender {
    
//    UIImagePickerControllerSourceType type = UIImagePickerControllerSourceTypeCamera;  //カメラ使用
    UIImagePickerControllerSourceType type = UIImagePickerControllerSourceTypePhotoLibrary; //ライブラリから取得
    
    if([UIImagePickerController isSourceTypeAvailable:type]){
        UIImagePickerController* imagepicker = [UIImagePickerController new];
        imagepicker.sourceType = type;
        imagepicker.delegate = self;
        
        isUsePopOver = false;
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
                imagePopController = [[UIPopoverController alloc] initWithContentViewController:imagepicker];
                
                // Popoverを表示する。
                // senderはBarButtonItem型の変数で、このボタンを起点にPopoverを開く。
                [imagePopController presentPopoverFromBarButtonItem:sender
                                           permittedArrowDirections:UIPopoverArrowDirectionAny
                                                           animated:YES];
                isUsePopOver = true;
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
    UIImage* editedImage = (UIImage*)[info objectForKey:UIImagePickerControllerOriginalImage];
    
    
    UIImage* savedImage;
    if (editedImage){
        savedImage = editedImage;
    }else{
        savedImage = originalImage;
    }
    _vi.image = savedImage;
    
    int w = savedImage.size.width;
    int h =savedImage.size.height;
    NSLog([NSString stringWithFormat:@"w:%d, h:%d", w, h]);
    
    // 画像をPOSTで送る
    // (テスト用のサーバにモザイク画作成サーバを使用）
    NSURL *URL = [NSURL URLWithString:@"http://192.168.1.3:8080/posttest"];
    R9HTTPRequest *request = [[R9HTTPRequest alloc] initWithURL:URL];
    [request setHTTPMethod:@"POST"];
    // パラメータ追加
    [request addBody:@"101" forKey:@"numOfSampleImages"];
    [request addBody:@"192.168.1.3" forKey:@"workers"];
    NSData *pngData = [[NSData alloc] initWithData:UIImagePNGRepresentation(savedImage)];
    // set image data
    [request setData:pngData withFileName:@"sample.png" andContentType:@"image/png" forKey:@"fileUpload"];
    [request setCompletionHandler:^(NSHTTPURLResponse *responseHeader, NSString *responseString){
        NSLog(@"%@", responseString);
    }];
    // Progress
    [request setUploadProgressHandler:^(float newProgress){
        NSLog(@"%g", newProgress);
    }];
    // Response
    [request setCompletionHandler:nil]; // setCompletionHandlerWithData をセットするなら、先にsetCompletionHandler にnilをセットする必要あり。多分、バグ。
    [request setCompletionHandlerWithData:^(NSHTTPURLResponse *responseHeader, NSData *responseData){
        NSLog(@"responseWithData ");
        UIImage* im = [[UIImage alloc]initWithData:responseData];
        _vi.image = im;
    }];
    
    [request startRequest];
    
    
    if (isUsePopOver){
        // ポップオーバーを消す
        [imagePopController dismissPopoverAnimated:YES];
    }else{
        // カメラ撮影ビューコントローラを閉じる
        [self dismissViewControllerAnimated:true completion:^{}];
    }
    
}

@end
