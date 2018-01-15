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

@property (weak, nonatomic) IBOutlet UILabel *lblBio;

@property (weak, nonatomic) IBOutlet UIView *viewBioContainer;
@property (weak, nonatomic) IBOutlet UIView *viewVideoContainer;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewUsing;

@end

@implementation MyUserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   //https://www.youtube.com/watch?v=9XmD-DLfiGE

    [self.viewProfileImageButtonContainer roundTheView];
    
    [self.btnUserProfileButton roundTheView];
    //226 184
    
    self.viewBasicInfoContainer.layer.cornerRadius = 10;
    
    self.viewBioContainer.layer.cornerRadius = 10;
    
    self.viewVideoContainer.layer.cornerRadius = 10;
    
    //
    self.lblBio.text = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incidid";
    
    
    
    //733
}

-(void)viewDidAppear:(BOOL)animated{
    
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect: self.viewSchoolContainer.bounds byRoundingCorners: UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii: (CGSize){10.0, 10.}].CGPath;
    
    self.viewSchoolContainer.layer.mask = maskLayer;
    
    
    maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect: self.viewBioContainer.bounds byRoundingCorners: UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii: (CGSize){10.0, 10.}].CGPath;
    
    self.viewBioContainer.layer.mask = maskLayer;
    
    //226 120
    
    maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect: self.viewVideoContainer.bounds byRoundingCorners: UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii: (CGSize){10.0, 10.}].CGPath;
    
    self.viewVideoContainer.layer.mask = maskLayer;
    
    
    
    [self.scrollViewUsing setContentSize:CGSizeMake(self.view.frame.size.width, 773)];
    
    //
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
