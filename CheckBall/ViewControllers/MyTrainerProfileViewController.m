//
//  MyTrainerProfileViewController.m
//  CheckBall
//
//  Created by Shehzad Bilal on 15/01/2018.
//  Copyright © 2018 plego. All rights reserved.
//

#import "MyTrainerProfileViewController.h"
#import "User.h"

@interface MyTrainerProfileViewController ()

@end

@implementation MyTrainerProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)viewDidAppear:(BOOL)animated{
    
    
    [User
     callGetUserProfileById:self.myJid WithComplitionHandler:^(id result) {
         
         [self hideLoader];
         
         id videosList = [result objectForKey:@"Videos"];
         
         if ([videosList isKindOfClass:[NSArray class]] && [videosList count] > 0)
         {
             
             
             for (id currentItem in videosList)
             {
                 [self.allVideos addObject:[currentItem objectForKey:@"Url"]];
             }
             
         }
         self.lblMyName.text = [[[result objectForKey:@"Account"] firstObject] objectForKey:@"Name"];
         self.lblMyName2.text = [[[result objectForKey:@"Account"] firstObject] objectForKey:@"Name"];
         
         self.lblPosition.text = [[[result objectForKey:@"Account"] firstObject] objectForKey:@"Position"];
         self.lblPosition2.text = [[[result objectForKey:@"Account"] firstObject] objectForKey:@"Position"];
         
         self.lblSchool.text = [[[result objectForKey:@"Account"] firstObject] objectForKey:@"School"];
         
         self.lblBio.text =  [[[result objectForKey:@"Account"] firstObject] objectForKey:@"Bio"];
         
         NSString * heightShowing = [[[result objectForKey:@"Account"] firstObject] objectForKey:@"Height"];
         if (![heightShowing isKindOfClass:[NSString class]]) {
             
             //  5' 7" )
             heightShowing = [NSString stringWithFormat:@"%.02f",[heightShowing doubleValue]];
             
             self.heightSelected = heightShowing;
             
         }
         heightShowing = [heightShowing stringByReplacingOccurrencesOfString:@"." withString:@"\""];
         heightShowing = [heightShowing stringByAppendingString:@"'"];
         
         heightShowing = [NSString stringWithFormat:@"Height ( %@ )",heightShowing];
         
         self.lblHeight.text = heightShowing;
         
         NSString * weight = [[[result objectForKey:@"Account"] firstObject] objectForKey:@"Weight"];
         
         if (![weight isKindOfClass:[NSString class]]) {
             
             weight = [NSString stringWithFormat:@"%d",[weight intValue]];
             
             self.weightSelected = weight;
             
         }
         weight = [weight stringByAppendingString:@" lb"];
         self.lblWeight.text = [NSString stringWithFormat:@"Weight ( %@ )",weight];;
         [self.scrollViewUsing setHidden:NO];
         
         
         if ([self.allVideos count] >= 2) {
             
             self.lblYouTubeOne.text = self.allVideos[0];
             self.lblYouTubeTwo.text = self.allVideos[1];
             
         }
         else if([self.allVideos count] >= 1){
             
             
             self.lblYouTubeOne.text = self.allVideos[0];
             
             
         }
         
     } withFailueHandler:^{
         
         [self hideLoader];
         [self showAlert:@"" message:@"Error while laoding data"];
     }];
    
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
    
    
    
    [self.scrollViewUsing setContentSize:CGSizeMake(self.view.frame.size.width, 893)];
    
    //
}




@end
