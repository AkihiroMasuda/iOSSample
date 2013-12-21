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
    //テーブル作成
    UITableView *table = [[UITableView alloc]init];
    table.backgroundColor = [UIColor blackColor];
    //追加
    [self.view addSubview:table];
    //TableViewとしての設定
    table.delegate = self;
    table.dataSource = self; //大事
    table.rowHeight = ROW_HEIGHT;

    // AutoLayoutつかわず普通に作っとく
//    table.frame = CGRectMake(20, 300, 500, 500);

    // もちろん、AutoLayout使っても良い
    //おまじない
    [table setTranslatesAutoresizingMaskIntoConstraints:NO]; // 必須
    //AutoLayout設定
    {
        NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(table); //ここで指定した変数名が、下の設定で使われる
        NSArray *constraints;
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(8)-[table]-(8)-|"
                                                              options:0
                                                              metrics:nil
                                                                views:viewsDictionary];
        [self.view addConstraints:constraints];
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(30)-[table]-(8)-|"
                                                              options:0
                                                              metrics:nil
                                                                views:viewsDictionary];
        [self.view addConstraints:constraints];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell){
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    // Configure the cell...
    cell.accessoryType = UITableViewCellAccessoryNone;
    
//    NSLog(@"row:%d", indexPath.row);

    // セルの中にカスタムビューを作成
    switch(indexPath.row){
        case 0:
            [self buildViewInCell00:cell.contentView];
            break;
        case 1:
            [self buildViewInCell01:cell.contentView];
            break;
        case 2:
            [self buildViewInCell02:cell.contentView];
            break;
        default:
            [self buildViewInCell:cell.contentView];
            break;
    }
    
    return cell;
}

/*
 * AutoLayoutの設定(基礎ビューについて)
 * 縦・横とも親ビューにいっぱいに広げる
 */
- (void)setAutoLayoutOfBaseView:(UIView*)viewBase parentView:(UIView*)parent
{
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(viewBase); //ここで指定した変数名が、下の設定で使われる
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[viewBase]|" //親ビューいっぱいに広げる
                                                                   options:0
                                                                   metrics:nil
                                                                     views:viewsDictionary];
    [parent addConstraints:constraints];
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[viewBase]|" //親ビューいっぱいに広げる
                                                          options:0
                                                          metrics:nil
                                                            views:viewsDictionary];
    [parent addConstraints:constraints];
}

/**
 * セルの中にカスタムビューを作成
 * 複数のビューを均等な間隔で配置する
 */
- (void)buildViewInCell00:(UIView*)contentView
{
    // 基礎ビュー作成
    UIView *viewBase = [[UIView alloc]init];
    viewBase.backgroundColor = [UIColor blueColor];
    // AutoLayout有効にするためのおまじない
    [viewBase setTranslatesAutoresizingMaskIntoConstraints:NO]; // 必須
    // 基礎ビューをセルに追加
    [contentView addSubview:viewBase];
    
    // ボタン生成
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn1 setTitle:@"ボタン1" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor greenColor];
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn2 setTitle:@"ボタン2" forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor greenColor];
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn3 setTitle:@"ボタン3" forState:UIControlStateNormal];
    btn3.backgroundColor = [UIColor greenColor];
    // 基礎ビューに追加
    [viewBase addSubview:btn1]; //制約設定前にこれ追加してないとダメっぽい
    [viewBase addSubview:btn2]; //制約設定前にこれ追加してないとダメっぽい
    [viewBase addSubview:btn3]; //制約設定前にこれ追加してないとダメっぽい
    // AutoLayout有効にするためのおまじない
    [btn1 setTranslatesAutoresizingMaskIntoConstraints:NO]; // 必須
    [btn2 setTranslatesAutoresizingMaskIntoConstraints:NO]; // 必須
    [btn3 setTranslatesAutoresizingMaskIntoConstraints:NO]; // 必須
    
    // AutoLayoutの設定(基礎ビュー上のボタンについて)
    {
        UIView *parent = viewBase;
        NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(btn1,btn2,btn3); //ここで指定した変数名が、下の設定で使われる
        NSArray *constraints;
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(8)-[btn1]-[btn2(==btn1)]-[btn3(==btn1)]-(8)-|" // 3つのボタンを横方向に均等に配置
                                                              options:0
                                                              metrics:nil
                                                              views:viewsDictionary];
        [parent addConstraints:constraints];
        // 垂直方向はすべて同じに
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(8)-[btn1]-(8)-|"
                                                              options:0
                                                              metrics:nil
                                                              views:viewsDictionary];
        [parent addConstraints:constraints];
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(8)-[btn2]-(8)-|"
                                                              options:0
                                                              metrics:nil
                                                              views:viewsDictionary];
        [parent addConstraints:constraints];
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(8)-[btn3]-(8)-|"
                                                              options:0
                                                              metrics:nil
                                                              views:viewsDictionary];
        [parent addConstraints:constraints];
    }
    
    // AutoLayoutの設定(基礎ビューについて)
    [self setAutoLayoutOfBaseView:viewBase parentView:contentView];
}


/**
 * セルの中にカスタムビューを作成
 * 左のボタン幅は固定、真ん中と右のボタンは均等に。
 */
- (void)buildViewInCell01:(UIView*)contentView
{
    // 基礎ビュー作成
    UIView *viewBase = [[UIView alloc]init];
    viewBase.backgroundColor = [UIColor blueColor];
    // AutoLayout有効にするためのおまじない
    [viewBase setTranslatesAutoresizingMaskIntoConstraints:NO]; // 必須
    // 基礎ビューをセルに追加
    [contentView addSubview:viewBase];
    
    // ボタン生成
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn1 setTitle:@"ボタン1" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor greenColor];
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn2 setTitle:@"ボタン2" forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor greenColor];
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn3 setTitle:@"ボタン3" forState:UIControlStateNormal];
    btn3.backgroundColor = [UIColor greenColor];
    // 基礎ビューに追加
    [viewBase addSubview:btn1]; //制約設定前にこれ追加してないとダメっぽい
    [viewBase addSubview:btn2]; //制約設定前にこれ追加してないとダメっぽい
    [viewBase addSubview:btn3]; //制約設定前にこれ追加してないとダメっぽい
    // AutoLayout有効にするためのおまじない
    [btn1 setTranslatesAutoresizingMaskIntoConstraints:NO]; // 必須
    [btn2 setTranslatesAutoresizingMaskIntoConstraints:NO]; // 必須
    [btn3 setTranslatesAutoresizingMaskIntoConstraints:NO]; // 必須
    
    // AutoLayoutの設定(基礎ビュー上のボタンについて)
    {
        UIView *parent = viewBase;
        NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(btn1,btn2,btn3); //ここで指定した変数名が、下の設定で使われる
        NSArray *constraints;
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(8)-[btn1(30)]-[btn2]-[btn3(==btn2)]-(8)-|" // 3つのボタンを横方向に均等に配置
                                                              options:0
                                                              metrics:nil
                                                                views:viewsDictionary];
        [parent addConstraints:constraints];
        // 垂直方向はすべて同じに
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(8)-[btn1]-(8)-|"
                                                              options:0
                                                              metrics:nil
                                                                views:viewsDictionary];
        [parent addConstraints:constraints];
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(8)-[btn2]-(8)-|"
                                                              options:0
                                                              metrics:nil
                                                                views:viewsDictionary];
        [parent addConstraints:constraints];
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(8)-[btn3]-(8)-|"
                                                              options:0
                                                              metrics:nil
                                                                views:viewsDictionary];
        [parent addConstraints:constraints];
    }
    
    // AutoLayoutの設定(基礎ビューについて)
    [self setAutoLayoutOfBaseView:viewBase parentView:contentView];
}


/**
 * セルの中にカスタムビューを作成
 * ボタン幅を文字幅にあわせて可変にする
 */
- (void)buildViewInCell02:(UIView*)contentView
{
    // 基礎ビュー作成
    UIView *viewBase = [[UIView alloc]init];
    viewBase.backgroundColor = [UIColor blueColor];
    // AutoLayout有効にするためのおまじない
    [viewBase setTranslatesAutoresizingMaskIntoConstraints:NO]; // 必須
    // 基礎ビューをセルに追加
    [contentView addSubview:viewBase];
    
    // ボタン生成
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn1 setTitle:@"ボタン1" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor greenColor];
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn2 setTitle:@"ボタン2ああ" forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor yellowColor];
    // 基礎ビューに追加
    [viewBase addSubview:btn1]; //制約設定前にこれ追加してないとダメっぽい
    [viewBase addSubview:btn2]; //制約設定前にこれ追加してないとダメっぽい
    // AutoLayout有効にするためのおまじない
    [btn1 setTranslatesAutoresizingMaskIntoConstraints:NO]; // 必須
    [btn2 setTranslatesAutoresizingMaskIntoConstraints:NO]; // 必須
    
    // AutoLayoutの設定(基礎ビュー上のボタンについて)
    {
        UIView *parent = viewBase;
        NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(btn1,btn2); //ここで指定した変数名が、下の設定で使われる
        NSArray *constraints;
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(8)-[btn1(>=0)]" // 文字幅に合わせて可変
                                                              options:0
                                                              metrics:nil
                                                                views:viewsDictionary];
        [parent addConstraints:constraints];
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(8)-[btn2(>=0)]" // 文字幅に合わせて可変
                                                              options:0
                                                              metrics:nil
                                                                views:viewsDictionary];
        [parent addConstraints:constraints];
        // 垂直方向はすべて同じに
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[btn1][btn2(==btn1)]|"
                                                              options:0
                                                              metrics:nil
                                                                views:viewsDictionary];
        [parent addConstraints:constraints];
    }
    
    // AutoLayoutの設定(基礎ビューについて)
    [self setAutoLayoutOfBaseView:viewBase parentView:contentView];
}




/**
 * セルの中にカスタムビューを作成
 */
- (void)buildViewInCell:(UIView*)contentView
{
    // 基礎ビュー作成
    UIView *viewBase = [[UIView alloc]init];
    viewBase.backgroundColor = [UIColor blueColor];
    // AutoLayout有効にするためのおまじない
    [viewBase setTranslatesAutoresizingMaskIntoConstraints:NO]; // 必須
    // 基礎ビューをセルに追加
    [contentView addSubview:viewBase];
    
    // ボタン生成
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn1 setTitle:@"ボタン1" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor greenColor];
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn2 setTitle:@"ボタン2" forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor greenColor];
    // 基礎ビューに追加
    [viewBase addSubview:btn1]; //制約設定前にこれ追加してないとダメっぽい
    [viewBase addSubview:btn2]; //制約設定前にこれ追加してないとダメっぽい
    // AutoLayout有効にするためのおまじない
    [btn1 setTranslatesAutoresizingMaskIntoConstraints:NO]; // 必須
    [btn2 setTranslatesAutoresizingMaskIntoConstraints:NO]; // 必須
    
    // AutoLayoutの設定(基礎ビュー上のボタンについて)
    {
        UIView *parent = viewBase;
        NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(btn1,btn2); //ここで指定した変数名が、下の設定で使われる
        NSArray *constraints;
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(8)-[btn1(>=50)]" //ボタン幅は最低50以上。文字数によって可変
                                                              options:0
                                                              metrics:nil
                                                                views:viewsDictionary];
        [parent addConstraints:constraints];
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[btn2(100)]-(8)-|"
                                                              options:0
                                                              metrics:nil
                                                                views:viewsDictionary];
        [parent addConstraints:constraints];
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(8)-[btn1]-(8)-|"
                                                              options:0
                                                              metrics:nil
                                                                views:viewsDictionary];
        [parent addConstraints:constraints];
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(8)-[btn2]-(8)-|"
                                                              options:0
                                                              metrics:nil
                                                                views:viewsDictionary];
        [parent addConstraints:constraints];
    }
    
    // AutoLayoutの設定(基礎ビューについて)
    [self setAutoLayoutOfBaseView:viewBase parentView:contentView];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
