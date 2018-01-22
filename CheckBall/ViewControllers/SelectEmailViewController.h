//
//  SelectEmailViewController.h
//  CheckBall
//
//  Created by Tauqeer Ahmed on 11/29/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import "BaseViewController.h"

@interface SelectEmailViewController : BaseViewController

@property (nonatomic) BOOL comingAsTrainer;
@property (nonatomic) BOOL signingWithFB;

@property (nonatomic,strong) NSString * fbAccount;
@property (nonatomic,strong) NSString * fbName;
@property (nonatomic,strong) NSString * fbEmail;


@end
