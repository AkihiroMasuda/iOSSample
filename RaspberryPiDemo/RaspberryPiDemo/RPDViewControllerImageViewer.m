//
//  RPDViewControllerImageViewer.m
//  RaspberryPiDemo
//
//  Created by 舛田 明寛 on 2013/10/28.
//  Copyright (c) 2013年 AkihiroMasuda. All rights reserved.
//

#import "RPDViewControllerImageViewer.h"
#import "RPDDefine.h"


@interface RPDViewControllerImageViewer ()
@property UIButton *btnClose;
@property UIImage *img;
@property UIImageView *imgv;
@property UIScrollView *scView;
@end

@implementation RPDViewControllerImageViewer

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (id)initWithImage:(UIImage*)img
{
    _img = img; //下の[super init]内でviewDidLoadが呼ばれるようなので、引数の値は先に保存しておく。
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
//    const int BUTTON_WIDTH = 120;
    {
        UIButton *btn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
        _btnClose = btn;
        [_btnClose setTitle:@"閉じる" forState:UIControlStateNormal];
        _btnClose.frame = CGRectMake(0,HEADER_HEIGHT/4,BUTTON_WIDTH,BUTTON_HEIGHT);
        [btn addTarget:self action:@selector(closeButtonDidPush) forControlEvents:UIControlEventTouchUpInside];
        //    [_imgv1 addSubview:btn];
        [self.view addSubview:btn];
    }
    
    self.view.backgroundColor = [UIColor blackColor];
    
    // スクロールビュー
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    CGSize frameSize = self.view.frame.size;
//    _imgv.frame = CGRectMake(0, HEADER_HEIGHT, frameSize.width, (frameSize.height-HEADER_HEIGHT-TABBAR_HEIGHT));
    scrollView.frame = CGRectMake(0, HEADER_HEIGHT, frameSize.width, (frameSize.height-HEADER_HEIGHT-TABBAR_HEIGHT));
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _imgv = [self createImageViewWithImage:_img];
    [scrollView addSubview:_imgv];
    
    scrollView.contentSize = _imgv.bounds.size;
    
    [self.view addSubview:scrollView];
    
    scrollView.delegate = self;
    scrollView.minimumZoomScale = IMAGE_VIEW_MIN_SCALE;
    scrollView.maximumZoomScale = IMAGE_VIEW_MAX_SCALE;
    _scView = scrollView;
    
    [self updateImageCenter];
    
}

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    for (id subview in scrollView.subviews){
        if ( [subview isKindOfClass:[UIImageView class]]){
            return subview;
        }
    }
    return nil;
}

-(void)closeButtonDidPush
{
    //自身を閉じる
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImageView *)createImageViewWithImage:(UIImage*)img
{
    UIImageView *imgview1 = [[UIImageView alloc] initWithImage:img];
//    imgview1.contentMode = UIViewContentModeScaleAspectFill;
//    imgview1.clipsToBounds = YES;
    return imgview1;
}

- (void)setImageView
{
    _imgv = [self createImageViewWithImage:_img];
    CGSize frameSize = self.view.frame.size;
    _imgv.frame = CGRectMake(0, HEADER_HEIGHT, frameSize.width, (frameSize.height-HEADER_HEIGHT-TABBAR_HEIGHT));
    _imgv.contentMode = UIViewContentModeScaleAspectFit; //アスペクト比を維持したまま 画像のすべてが表示されるようにリサイズ
    _imgv.clipsToBounds = YES;
    [self.view addSubview:_imgv];
    
}

// ScrollViewDelegater
- (void)scrollViewDidZoom:(UIScrollView*)scrollView
{
    // Update appearance
    [self updateImageCenter];
}

- (void)scrollViewDidEndZooming:(UIScrollView*)scrollView
                       withView:(UIView*)view atScale:(float)scale
{
    [self updateImageCenter];
}

- (void)updateImageCenter
{
    // 画像の表示されている大きさを取得
    UIImage*    image;
    CGSize      imageSize;
    image = _imgv.image;
    imageSize = image.size;
    imageSize.width *= _scView.zoomScale;
    imageSize.height *= _scView.zoomScale;
    
    // サブスクロールビューの大きさを取得
    CGRect  bounds;
    bounds = _scView.bounds;
    
    // イメージビューの中央の座標を計算
    CGPoint point;
    point.x = imageSize.width * 0.5f;
    if (imageSize.width < CGRectGetWidth(bounds)) {
        point.x += (CGRectGetWidth(bounds) - imageSize.width) * 0.5f;
    }
    point.y = imageSize.height * 0.5f;
    if (imageSize.height < CGRectGetHeight(bounds)) {
        point.y += (CGRectGetHeight(bounds) - imageSize.height) * 0.5f;
    }
    _imgv.center = point;
}

@end
