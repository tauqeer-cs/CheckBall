//
//  UIView+MyUIView.h
//  Filmer
//
//  Created by Tauqeer Ahmed on 4/7/16.
//  Copyright © 2016 Plego. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MyUIView)
-(UIView *)getViewFromNibName:(NSString *)nibName withWidth:(double)width withHeight:(double)height;
-(UIView *)addSubViewWithContainerView:(UIView *)containerView
                       andEnteringView:(UIView *)enteringView
                           withNibName:(NSString *)nibName;
-(UIView *)getViewFromNibName:(NSString *)nibName;
-(void)roundTheView;
-(void)RemoveAllStuffFromView;
-(void)makeCornerRadius:(float)radius borderColor:(UIColor *)bColor borderWidth:(float)bWidth;
-(void)addShadow;

@end
