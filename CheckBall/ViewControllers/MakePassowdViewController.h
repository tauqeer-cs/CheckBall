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

/*
[self.txtPosition.txtView.text length] == 0 || [self.txtZipCode.txtView.text length] == 0 || [self.finalSelectedItems count] == 0)

*/

@end
