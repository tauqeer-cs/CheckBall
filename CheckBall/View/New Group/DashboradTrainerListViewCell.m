//
//  DashboradTrainerListViewCell.m
//  CheckBall
//
//  Created by Tauqeer on 05/12/2017.
//  Copyright © 2017 plego. All rights reserved.
//

#import "DashboradTrainerListViewCell.h"

@implementation DashboradTrainerListViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.mainContainer.layer.cornerRadius = 8;
    
    [self.profileContainer roundTheView];
    [self.profileImageView roundTheView];
    
}

@end