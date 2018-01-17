//
//  AddingTextViewControl.h
//  CheckBall
//
//  Created by Shehzad Bilal on 17/01/2018.
//  Copyright © 2018 plego. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddingTextViewControl : UIView
@property (weak, nonatomic) IBOutlet UIView *textBoxContainer;

@property (weak, nonatomic) IBOutlet UITextField *txtBoxEntering;
@property (weak, nonatomic) IBOutlet UIButton *btnOk;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@end
