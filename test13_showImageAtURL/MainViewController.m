//
//  MainViewController.m
//  test13_showImageAtURL
//
//  Created by 舛田 明寛 on 2014/04/08.
//  Copyright (c) 2014年 AkihiroMasuda. All rights reserved.
//

#import "MainViewController.h"
#import "SimpleImageFetcher.h"

@interface MainViewController ()
@property UIImageView *imgView;
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
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn setTitle:@"button" forState:UIControlStateNormal];
        btn.frame = CGRectMake(10, 80, 300, 40);
        btn.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:btn];
    }
    
    
    {
        UIImage *img = [UIImage imageNamed:@"img00.jpg"];
        UIImageView *imgview = [[UIImageView alloc]init];
        imgview.frame = CGRectMake(10, 200, 200, 200);
//        [imgview setImage:img];
        [self.view addSubview:imgview];
        _imgView = imgview;
        _imgView.backgroundColor = [UIColor blackColor];
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadImage];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadImage
{
    NSURL *url = [NSURL URLWithString:@"http://xxharuhi0405xx.btblog.jp/ig/b/kulSc481i52ADCBFE.jpg"];
    
    //Loading thumbnail async
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage* image = [UIImage
                          imageWithData:[SimpleImageFetcher getDataFromImageURL:url useCache:false]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Loaded thumbnail image");
            [self.imgView setImage:image];
            self.imgView.contentMode = UIViewContentModeScaleAspectFit;
        });
    });
}


@end
