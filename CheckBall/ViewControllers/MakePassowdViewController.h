//
//  MakePassowdViewController.h
//  CheckBall
//
//  Created by Tauqeer on 03/12/2017.
//  Copyright © 2017 plego. All rights reserved.
//

#import "BaseViewController.h"

@interface MakePassowdViewController : BaseViewController

@property (nonatomic,strong) NSString * accountType;

@property (nonatomic,strong) NSString * fullName;

@property (nonatomic,strong) NSString * height;

@property (nonatomic,strong) NSString * weight;

@property (nonatomic,strong) NSString * position;

@property (nonatomic,strong) NSString * zipCode;

@property (nonatomic,strong) NSArray * allSpecialitesSelected;

@property (nonatomic,strong) NSString * schoolSelcted;

@property (nonatomic,strong) NSString * accountEmail;

@property (nonatomic,strong) NSString * fbAccount;
@property (nonatomic) BOOL signingWithFB;



@end
