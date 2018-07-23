//
//  AcceptRejectTableViewCell.m
//  CheckBall
//
//  Created by Tauqeer Ahmed on 23/07/2018.
//  Copyright © 2018 plego. All rights reserved.
//

#import "AcceptRejectTableViewCell.h"

@implementation AcceptRejectTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    [self.userImage roundTheView];
    
    
    self.btnDelete.layer.cornerRadius = 5;
    self.btnDelete.layer.borderColor = [UIColor grayColor].CGColor;
    self.btnDelete.layer.borderWidth = 1.0;
    
    
    self.btnConfirm.layer.cornerRadius = 5;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
