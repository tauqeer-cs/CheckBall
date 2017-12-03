//
//  UIButton+MyButton.m
//  Filmer
//
//  Created by Tauqeer Ahmed on 4/7/16.
//  Copyright © 2016 Plego. All rights reserved.
//

#import "UIButton+MyButton.h"
#import "UIImage+MyImage.h"

@implementation UIButton (MyButton)

-(void)setSelecedWithColor:(UIColor *)color{
    UIImage *brownColor;
    if (!color) {
        brownColor  =   [UIImage imageFromColor:[UIColor brownColor]];
    }
    else
    {
        brownColor  =   [UIImage imageFromColor:color];
    }
    [self setBackgroundImage:brownColor forState:UIControlStateSelected];
}

-(void)setHoverColorForButton:(UIButton *)button withColor:(UIColor *)color{
    
    UIImage *brownColor;
    if (!color) {
        brownColor  =   [UIImage imageFromColor:[UIColor brownColor]];
    }
    else
    {
        brownColor  =   [UIImage imageFromColor:color];
    }
    
    if (!color) {
        [button setBackgroundImage:brownColor forState:UIControlStateHighlighted];
    }
    
    else
        [button setBackgroundImage:brownColor
                          forState:UIControlStateHighlighted];
    
    
}

-(void)NotunderLineButton{
    
    NSString *text = self.titleLabel.text;
    self.titleLabel.attributedText = [[NSAttributedString alloc] initWithString:text];;
    
}

-(void)underLineButton{
    
    if (!self) {
        return;
        
    }
    
    NSDictionary *underlineAttribute = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
    self.titleLabel.attributedText = [[NSAttributedString alloc] initWithString:self.titleLabel.text
                                                                            attributes:underlineAttribute];
    
}


-(void)setAttributedTextOfButtonOnBackWithTitle:(NSString *)title withImageName:(NSString *)imageName{
    
    title = [@"   " stringByAppendingString:title];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:title];
    
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = [UIImage imageNamed:imageName];
    
    NSAttributedString *attrStringWithImage = [NSAttributedString attributedStringWithAttachment:textAttachment];
    
    
    [attributedString replaceCharactersInRange:NSMakeRange(title.length - 2, 1) withAttributedString:attrStringWithImage];
    
    [self setAttributedTitle:attributedString forState:UIControlStateNormal];
    [self setAttributedTitle:attributedString forState:UIControlStateHighlighted];
    [self setAttributedTitle:attributedString forState:UIControlStateSelected];
    
}

-(void)setAttributedTextOfButtonWithTitle:(NSString *)title withImageName:(NSString *)imageName{
    
    title = [@"   " stringByAppendingString:title];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:title];
    
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = [UIImage imageNamed:imageName];
    
    NSAttributedString *attrStringWithImage = [NSAttributedString attributedStringWithAttachment:textAttachment];
    
    
    [attributedString replaceCharactersInRange:NSMakeRange(0, 1) withAttributedString:attrStringWithImage];
    
    [self setAttributedTitle:attributedString forState:UIControlStateNormal];
    [self setAttributedTitle:attributedString forState:UIControlStateHighlighted];
    [self setAttributedTitle:attributedString forState:UIControlStateSelected];
    
}







@end
