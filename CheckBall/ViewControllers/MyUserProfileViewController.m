//
//  MyUserProfileViewController.m
//  CheckBall
//
//  Created by Shehzad Bilal on 15/01/2018.
//  Copyright © 2018 plego. All rights reserved.
//

#import "MyUserProfileViewController.h"

@interface MyUserProfileViewController ()
@property (weak, nonatomic) IBOutlet UIView *viewProfileImageButtonContainer;
@property (weak, nonatomic) IBOutlet UIButton *btnUserProfileButton;

@property (weak, nonatomic) IBOutlet UIView *viewBasicInfoContainer;
@property (weak, nonatomic) IBOutlet UIView *viewSchoolContainer;
@end

@implementation MyUserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.viewProfileImageButtonContainer roundTheView];
    
    [self.btnUserProfileButton roundTheView];
    //226 184
    
    self.viewBasicInfoContainer.layer.cornerRadius = 10;
    

}

-(void)viewDidAppear:(BOOL)animated{
    
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect: self.viewSchoolContainer.bounds byRoundingCorners: UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii: (CGSize){10.0, 10.}].CGPath;
    
    self.viewSchoolContainer.layer.mask = maskLayer;
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
