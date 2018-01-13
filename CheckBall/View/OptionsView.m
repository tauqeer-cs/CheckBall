//
//  OptionsView.m
//  CheckBall
//
//  Created by Tauqeer on 05/12/2017.
//  Copyright © 2017 plego. All rights reserved.
//

#import "OptionsView.h"

@implementation OptionsView

-(void)awakeFromNib{

    
    
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect: self.bounds byRoundingCorners: UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii: (CGSize){10.0, 10.}].CGPath;
    
    self.firstContainer.layer.mask = maskLayer;
    
    
    
   // [self roundCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight) radius:8];
    
    
    

    
}

-(void)roundCorners:(UIRectCorner)corners radius:(CGFloat)radius
{
    CGRect bounds = self.thirdContainer.frame;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds
                                                   byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(radius, radius)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = bounds;
    maskLayer.path = maskPath.CGPath;
    
    self.layer.mask = maskLayer;
    
    return;
    
    CAShapeLayer*   frameLayer = [CAShapeLayer layer];
    frameLayer.frame = bounds;
    frameLayer.path = maskPath.CGPath;
    frameLayer.strokeColor = [UIColor clearColor].CGColor;
    
    [self.layer addSublayer:frameLayer];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
