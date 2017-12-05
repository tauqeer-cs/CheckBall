//
//  DashboardPlayerListCollectionCell.m
//  CheckBall
//
//  Created by Tauqeer on 04/12/2017.
//  Copyright © 2017 plego. All rights reserved.
//

#import "DashboardPlayerListCollectionCell.h"


@implementation DashboardPlayerListCollectionCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.mainContainer.layer.cornerRadius = 8;
    
    [self.profileContainer roundTheView];
    [self.profileImageView roundTheView];
    
}

@end
