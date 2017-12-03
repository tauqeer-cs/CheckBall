//
//  MenuViewController.m
//  SlideMenu
//
//  Created by Aryan Gh on 4/24/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "SlideNavigationContorllerAnimatorFade.h"
#import "SlideNavigationContorllerAnimatorSlide.h"
#import "SlideNavigationContorllerAnimatorScale.h"
#import "SlideNavigationContorllerAnimatorScaleAndFade.h"
#import "SlideNavigationContorllerAnimatorSlideAndFade.h"
#import "AppDelegate.h"
#import "Config.h"
#import "FileManager.h"
#import "AppDelegate.h"



@interface LeftMenuViewController()


@property (nonatomic,strong) AppDelegate *currentApp;
@property (nonatomic,strong) SlideNavigationController* sideMenuRefrence;

@property (weak, nonatomic) IBOutlet UIButton *btnFacebook;

@property (weak, nonatomic) IBOutlet UITextField *txtInvitationCode;

@end
@implementation LeftMenuViewController

#pragma mark - UIViewController Methods -
NSString *lastStatus;
NSUserDefaults *defaults;

AppDelegate *appDelegate;


- (IBAction)btnCloseTapped:(UIButton *)sender {

    [self.sideMenuRefrence toggleLeftMenu];
        [self.view endEditing:YES];
    
    
}
- (IBAction)accountPrefrencesButtonTapped {
    
    [self.view endEditing:YES];
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"CreateVideo"
                                                             bundle: nil];
    
    UIViewController *vc ;
    
    
    vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"SettingsViewController"];
    
    
    [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
                                                             withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                     andCompletion:nil];
    
}

-(UIViewController *)viewControllerFromStoryBoard:(NSString *)storyboardName withViewControllerName:(NSString *)viewId{
    
    
    [self.view endEditing:YES];
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:storyboardName
                                                             bundle: nil];
    return (UIViewController *)[mainStoryboard
                                instantiateViewControllerWithIdentifier: viewId];
    
}


- (IBAction)btnCreateNewVideoTapped:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"CreateVideo"
                                                             bundle: nil];
    
    UIViewController *vc ;
    

    vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"SelectetChainTitleViewController"];
   
    
    [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
                                                             withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                     andCompletion:nil];
    
    
}


- (void)viewDidLoad
{
	[super viewDidLoad];
    

    
   appDelegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    //self.sideMenuRefrence = appDelegate.sideMenuRefrence;
    
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    self.txtInvitationCode.leftView = paddingView;
    self.txtInvitationCode.leftViewMode = UITextFieldViewModeAlways;
    
}


-(void)viewDidAppear:(BOOL)animated{
 
    /*
    self.loginButton  = [[FBSDKLoginButton alloc] init];
    
    [self.loginButton setFrame:self.btnFacebook.frame];
    
    self.loginButton.readPermissions =
    @[@"public_profile", @"email", @"user_friends",@"user_birthday"];
    [self.view addSubview:self.loginButton];
    [self.btnFacebook setHidden:YES];*/
    
  
    
    
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    
    [textField resignFirstResponder];
    
    if (textField.tag == 22) {
     

        
        
        
        
        
        
    }
    else if (textField.tag == 33)
    {
    

/*        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:destination
                                                                 withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                         andCompletion:nil];
        
        
  */
        
        
    }
    return YES;
}
- (IBAction)btnFriendTapped {

    [self.view endEditing:YES];
    

}


- (IBAction)btnYourTapped {

    [self.view endEditing:YES];
    
    
}



- (IBAction)btnSignOutTapped:(UIButton *)sender {
    
    
    [self.view endEditing:YES];
    

    
    
}



@end
