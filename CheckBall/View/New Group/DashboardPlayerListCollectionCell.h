//
//  DashboardPlayerListCollectionCell.h
//  CheckBall
//
//  Created by Tauqeer on 04/12/2017.
//  Copyright © 2017 plego. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashboardPlayerListCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *mainContainer;
@property (weak, nonatomic) IBOutlet UIView *profileContainer;

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@end
