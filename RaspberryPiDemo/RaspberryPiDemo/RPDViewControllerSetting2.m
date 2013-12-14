//
//  RPDViewControllerSetting2.m
//  RaspberryPiDemo
//
//  Created by 舛田 明寛 on 2013/10/29.
//  Copyright (c) 2013年 AkihiroMasuda. All rights reserved.
//

#import "RPDViewControllerSetting2.h"
#import "RPDDefine.h"
#import "RPDSettings.h"

@interface RPDViewControllerSetting2 ()

@end

@implementation RPDViewControllerSetting2

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
    [self resetViewFromSavedSettings];
    
    // 背景をキリックしたら、キーボードを隠す
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeSoftKeyboard)];
    [self.view addGestureRecognizer:gestureRecognizer];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// キーボードを隠す処理
- (void)closeSoftKeyboard {
    [self.view endEditing: YES];
}

- (IBAction)pushSaveButton:(UIButton *)sender {
    //保存ボタン押下
    [self saveViewToSettings];
}

- (IBAction)pushCancelButton:(UIButton *)sender {
    //キャンセルボタン押下
    [self resetViewFromSavedSettings];
}

- (void)resetViewFromSavedSettings
{
    RPDSettings *st = [RPDSettings sharedManager];
    [_NumOfSampleImages setText:st.numOfSampleImages];
    [_srcLongSize setText:st.srcLongSize];
    [_requestURL setText:st.requestURL];
    [_workersIP setText:st.workersIP];
    [_ledEnable setOn:[st.ledEnable isEqualToString:@"True"]];
    [_timerInterval1 setText:[NSString stringWithFormat:@"%lf", st.timerIntarval1]];
    [_timerInterval2 setText:[NSString stringWithFormat:@"%lf", st.timerIntarval2]];
}

-(void)saveViewToSettings
{
    RPDSettings *st = [RPDSettings sharedManager];
    st.numOfSampleImages = _NumOfSampleImages.text;
    st.srcLongSize = _srcLongSize.text;
    st.requestURL = _requestURL.text;
    st.workersIP = _workersIP.text;
    st.ledEnable = _ledEnable.isOn ? @"True" : @"False";
    st.timerIntarval1 = [_timerInterval1.text doubleValue];
    st.timerIntarval2 = [_timerInterval2.text doubleValue];
}

- (void)tabBarDidSelect
{
    // タブ選択された時の処理
}
- (void)tabBarDidReleased
{
    //タブで選択が離れた時
    // 入力した値があっても、無視して一旦リセット
    [self resetViewFromSavedSettings];
}


@end
