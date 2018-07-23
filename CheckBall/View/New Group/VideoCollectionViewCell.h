//
//  VideoCollectionViewCell.h
//  CheckBall
//
//  Created by Tauqeer Ahmed on 23/07/2018.
//  Copyright © 2018 plego. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;

@property (weak, nonatomic) IBOutlet UILabel *lblDetail;
@end
