//
//  AddingTextViewControl.m
//  CheckBall
//
//  Created by Shehzad Bilal on 17/01/2018.
//  Copyright © 2018 plego. All rights reserved.
//

#import "AddingTextViewControl.h"

@implementation AddingTextViewControl

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.textBoxContainer.layer.cornerRadius = 8;
    
    
}
@end
