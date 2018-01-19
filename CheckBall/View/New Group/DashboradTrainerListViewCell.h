//
//  DashboradTrainerListViewCell.h
//  CheckBall
//
//  Created by Tauqeer on 05/12/2017.
//  Copyright © 2017 plego. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashboradTrainerListViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *mainContainer;
@property (weak, nonatomic) IBOutlet UIView *profileContainer;

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

-(void)updateWithDate:(id)data;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblType;
@property (weak, nonatomic) IBOutlet UILabel *lblMiles;
@end
