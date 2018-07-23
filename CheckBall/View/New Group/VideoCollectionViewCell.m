//
//  VideoCollectionViewCell.m
//  CheckBall
//
//  Created by Tauqeer Ahmed on 23/07/2018.
//  Copyright © 2018 plego. All rights reserved.
//

#import "VideoCollectionViewCell.h"

@implementation VideoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    

    [self.userImage roundTheView];
    
    
    self.lblDetail.text = @"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s";
    
    
}

@end
