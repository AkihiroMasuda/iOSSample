//
//  MyViewController.h
//  test06_1_camera
//
//  Created by 舛田 明寛 on 2013/09/15.
//  Copyright (c) 2013年 AkihiroMasuda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
- (IBAction)openPhotoLibrary:(id)sender;
@property IBOutlet UIImageView *iv;
@end
