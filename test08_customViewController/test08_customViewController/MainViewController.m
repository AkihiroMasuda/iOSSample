//
//  MainViewController.m
//  test08_customViewController
//
//  Created by 舛田 明寛 on 2013/12/14.
//  Copyright (c) 2013年 AkihiroMasuda. All rights reserved.
//

#import "MainViewController.h"
#import "PopupViewController.h"

@interface MainViewController ()
@property PopupViewController* popup;
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

- (id)init{
    self = [super init];
    if (self){
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // CGRectMakeなしで設定すると表示されないので注意（勝手に原点に設定されるわけではない）
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0,100,100,30)];
    lb.text = @"aaaaa";
    [self.view addSubview:lb];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(0, 200, 100, 30);
    [btn setTitle:@"ボタン" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:btn];
    
    _popup = [[PopupViewController alloc]init];

    
}

// ボタン押下時
-(void)btnClicked:(UIButton*)button{
    // 透明なViewControllerをモーダル表示するために必要
    self.modalPresentationStyle = UIModalPresentationCurrentContext; //これ大事
    [self presentViewController:_popup animated:YES completion:nil]; //モーダル表示

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
