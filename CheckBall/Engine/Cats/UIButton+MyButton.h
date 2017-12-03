//
//  UIButton+MyButton.h
//  Filmer
//
//  Created by Tauqeer Ahmed on 4/7/16.
//  Copyright © 2016 Plego. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (MyButton)

-(void)setSelecedWithColor:(UIColor *)color;

-(void)setHoverColorForButton:(UIButton *)button withColor:(UIColor *)color;

-(void)NotunderLineButton;

-(void)underLineButton;

-(void)setAttributedTextOfButtonOnBackWithTitle:(NSString *)title withImageName:(NSString *)imageName;

-(void)setAttributedTextOfButtonWithTitle:(NSString *)title withImageName:(NSString *)imageName;

@end
