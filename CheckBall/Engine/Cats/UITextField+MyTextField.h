//
//  UITextField+MyTextField.h
//  Filmer
//
//  Created by Tauqeer Ahmed on 4/7/16.
//  Copyright © 2016 Plego. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (MyTextField)
-(void)makeTextBoxBorder;

-(void)setButtonBorder;

-(void)removeHelperViewFromTextBox;

-(void)setTextFieldPlaceHolderColorWithColor:(UIColor *)currentColor;

@end
