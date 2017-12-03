//
//  UIView+MyUIView.m
//  Filmer
//
//  Created by Tauqeer Ahmed on 4/7/16.
//  Copyright © 2016 Plego. All rights reserved.
//

#import "UIView+MyUIView.h"

@implementation UIView (MyUIView)

-(UIView *)addSubViewWithContainerView:(UIView *)containerView
                       andEnteringView:(UIView *)enteringView
                           withNibName:(NSString *)nibName
{
    
    enteringView = [self getViewFromNibName:nibName withWidth:containerView.frame.size.width withHeight:containerView.frame.size.height];
    
    [containerView addSubview:enteringView];
    
    return enteringView;
    
    
}

-(UIView *)getViewFromNibName:(NSString *)nibName withWidth:(double)width withHeight:(double)height
{
    
    NSArray *nibObjects;
    nibObjects = [[NSBundle mainBundle] loadNibNamed:nibName
                                               owner:self options:nil];
    
    UIView *tmp = [nibObjects objectAtIndex:0];
    [tmp setFrame:CGRectMake(0,0,width,height)];
    return tmp;
}

-(void)addShadow{
    
  
    
    self.layer.masksToBounds = NO;
    self.layer.shadowOffset = CGSizeMake(-1, 5);
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = .5;
    
   
 
    
}

-(UIView *)getViewFromNibName:(NSString *)nibName
{
    
    NSArray *nibObjects;
    nibObjects = [[NSBundle mainBundle] loadNibNamed:nibName
                                               owner:self options:nil];
    return [nibObjects objectAtIndex:0];
}

-(void)roundTheView{
    CALayer *layer  =   self.layer;
    
    layer.cornerRadius  =   self.frame.size.width / 2;
    self.clipsToBounds = YES;
    
}

-(void)RemoveAllStuffFromView
{
    
    for (UIView *currentView in self.subviews) {
        
        [currentView removeFromSuperview];
    }
}

-(void)makeCornerRadius:(float)radius borderColor:(UIColor *)bColor borderWidth:(float)bWidth{
    self.layer.borderWidth = bWidth;
    
    if (bColor != nil) {
        self.layer.borderColor = bColor.CGColor;
    }
    
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

@end
