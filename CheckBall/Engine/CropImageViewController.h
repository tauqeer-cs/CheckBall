//
//  CropImageViewController.h
//  ImageTailor
//
//  Created by yinyu on 15/10/10.
//  Copyright © 2015年 yinyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CropImageViewControllerDelegate <NSObject>

- (void) imageCropedInCircle : (UIImage *) Croppedimage;

@end


@interface CropImageViewController : UIViewController
@property (strong, nonatomic) UIImage *image;

@property (nonatomic, retain) id <CropImageViewControllerDelegate> delegate;

@end
