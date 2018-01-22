//
//  SelectedAccountTypeViewController.h
//  CheckBall
//
//  Created by Tauqeer Ahmed on 11/28/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import "BaseViewController.h"

@interface SelectedAccountTypeViewController : BaseViewController


@property (nonatomic) BOOL signingWithFB;
@property (nonatomic,strong) NSString * fbAccount;
@property (nonatomic,strong) NSString * fbName;
@property (nonatomic,strong) NSString * fbEmail;

@end
