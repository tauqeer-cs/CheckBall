//
//  UITextField+MyTextField.m
//  Filmer
//
//  Created by Tauqeer Ahmed on 4/7/16.
//  Copyright © 2016 Plego. All rights reserved.
//

#import "UITextField+MyTextField.h"

@implementation UITextField (MyTextField)

-(void)makeTextBoxBorder
{
    
    [self.layer setBorderWidth:0.3];
    
}

-(void)makeFirstLetterCapital
{
    self.autocapitalizationType = UITextAutocapitalizationTypeWords;
}

-(void)setButtonBorder {
    
    [[self layer] setBorderWidth:0.5f];
    [[self layer] setBorderColor:[UIColor blackColor].CGColor];
    
}


-(void)removeHelperViewFromTextBox{
    
    self.autocorrectionType = UITextAutocorrectionTypeNo;
}

-(void)setTextFieldPlaceHolderColorWithColor:(UIColor *)currentColor
{
    
    [self setValue:currentColor forKeyPath:@"_placeholderLabel.textColor"];
}


@end
