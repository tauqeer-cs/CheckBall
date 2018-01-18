//
//  SelectMapLocationViewController.h
//  CheckBall
//
//  Created by Shehzad Bilal on 18/01/2018.
//  Copyright © 2018 plego. All rights reserved.
//

#import "BaseViewController.h"

@protocol  SelectMapLocationViewCellDelegate


@optional

-(void)locationSelectedWithLat:(NSString *)lat withLong:(NSString *)longit withAddress:(NSString *)addres;

@end


@interface SelectMapLocationViewController : BaseViewController


@property (nonatomic,strong) id<SelectMapLocationViewCellDelegate> delegate;



@end
