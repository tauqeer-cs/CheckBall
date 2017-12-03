//
//  TextViewForSignUpform.m
//  Filmer
//
//  Created by Tauqeer Ahmed on 3/16/16.
//  Copyright © 2016 Plego. All rights reserved.
//

#import "TextViewForSignUpform.h"


@interface TextViewForSignUpform()

@end

@implementation TextViewForSignUpform


- (void)awakeFromNib
{
    
 
    self.layer.cornerRadius = 5;
    
}

-(void)setUpViewWithText:(NSString *)placeHolderText{
    
    
    self.txtView.placeholder = placeHolderText;
    
}


@end
