//
//  ViewController.h
//  Counter
//
//  Created by 舛田 明寛 on 2013/04/07.
//  Copyright (c) 2013年 Akihiro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    int counter;
    __weak IBOutlet UILabel *label;
}
- (IBAction)plusButton:(id)sender;

@end
