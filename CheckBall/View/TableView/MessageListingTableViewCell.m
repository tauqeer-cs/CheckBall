//
//  MessageListingTableViewCell.m
//  CheckBall
//
//  Created by Tauqeer Ahmed on 23/07/2018.
//  Copyright © 2018 plego. All rights reserved.
//

#import "MessageListingTableViewCell.h"

@implementation MessageListingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.userImage roundTheView];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
