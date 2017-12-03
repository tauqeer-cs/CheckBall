//
//  UIImage+MyImage.h
//  Filmer
//
//  Created by Tauqeer Ahmed on 4/7/16.
//  Copyright © 2016 Plego. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MyImage)
+ (UIImage *)imageFromColor:(UIColor *)color;
-(UIImage*) scaleImageToSize:(CGSize)newSize;
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
- (UIImage *)imageByApplyingAlpha:(CGFloat) alpha;

@end
