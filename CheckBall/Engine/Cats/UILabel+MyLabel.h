//
//  UILabel+MyLabel.h
//  Filmer
//
//  Created by Tauqeer Ahmed on 4/7/16.
//  Copyright © 2016 Plego. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (MyLabel)

-(void)setLabelFontWithSize:(double)size;
-(void)setLabelFontBoldWithSize:(double)size;
-(void)setLabelLightFontWithSize:(double)size;
-(void)setAttributedTextOfLabelWithTitle:(NSString *)title
                           withImageName:(NSString *)imageName;

@end
