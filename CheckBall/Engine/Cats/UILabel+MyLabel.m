//
//  UILabel+MyLabel.m
//  Filmer
//
//  Created by Tauqeer Ahmed on 4/7/16.
//  Copyright © 2016 Plego. All rights reserved.
//

#import "UILabel+MyLabel.h"

@implementation UILabel (MyLabel)

-(void)setLabelFontBoldWithSize:(double)size
{
    
    [self setFont:[UIFont fontWithName:@"HelveticaNeue-Bold"
                                          size:size]];
    
}

-(void)setLabelFontWithSize:(double)size
{
    
    [self setFont:[UIFont fontWithName:@"HelveticaNeue" size:size]];
}

-(void)setLabelLightFontWithSize:(double)size
{
    [self setFont:[UIFont fontWithName:@"HelveticaNeue-Light"
                                          size:size]];
}


-(void)setAttributedTextOfLabelWithTitle:(NSString *)title
                           withImageName:(NSString *)imageName{
    
    
    title = [title stringByAppendingString:@"    "];
    
    
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:title];
    
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = [UIImage imageNamed:imageName];
    
    NSAttributedString *attrStringWithImage = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [attributedString replaceCharactersInRange:NSMakeRange(title.length - 2, 1) withAttributedString:attrStringWithImage];
    [self setAttributedText:attributedString];
    
}


@end
