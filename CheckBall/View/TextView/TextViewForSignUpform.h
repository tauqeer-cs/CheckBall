//
//  TextViewForSignUpform.h
//  Filmer
//
//  Created by Tauqeer Ahmed on 3/16/16.
//  Copyright © 2016 Plego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldValidator.h"


@interface TextViewForSignUpform : UIView

-(void)setUpViewWithText:(NSString *)placeHolderText;
@property (weak, nonatomic) IBOutlet TextFieldValidator *txtView;

@end
