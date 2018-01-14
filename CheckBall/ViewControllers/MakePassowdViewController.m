//
//  MakePassowdViewController.m
//  CheckBall
//
//  Created by Tauqeer on 03/12/2017.
//  Copyright © 2017 plego. All rights reserved.
//

#import "MakePassowdViewController.h"
#import "TextViewForSignUpform.h"


@interface MakePassowdViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnSignUp;

@property (weak, nonatomic) IBOutlet UIView *viewPasswordContainer;
@property (nonatomic,strong) TextViewForSignUpform *txtPassword;


@property (weak, nonatomic) IBOutlet UIView *viewConfirmPassword;
@property (nonatomic,strong) TextViewForSignUpform *txtConfirmPassword;



@end

@implementation MakePassowdViewController


-(TextViewForSignUpform *)txtConfirmPassword{
    
    
    if (!_txtConfirmPassword) {
        
        _txtConfirmPassword = (TextViewForSignUpform *)
        [self.view addSubViewWithContainerView:self.viewConfirmPassword
                               andEnteringView:_txtConfirmPassword
                                   withNibName:@"TextViewForSignUpform"];
        
        _txtConfirmPassword.txtView.isMandatory = YES;
        _txtConfirmPassword.txtView.delegate = self;
        [_txtConfirmPassword.txtView setSecureTextEntry:YES];
        
        
        [_txtConfirmPassword setUpViewWithText:@"Confirm Password"];
        self.viewConfirmPassword.backgroundColor = [UIColor clearColor];
        
        
    }
    return _txtConfirmPassword;
    
}

-(TextViewForSignUpform *)txtPassword{
    
    
    if (!_txtPassword) {
        
        _txtPassword = (TextViewForSignUpform *)
        [self.view addSubViewWithContainerView:self.viewPasswordContainer
                               andEnteringView:_txtPassword
                                   withNibName:@"TextViewForSignUpform"];
        
        _txtPassword.txtView.isMandatory = YES;
        _txtPassword.txtView.delegate = self;
        [_txtPassword setUpViewWithText:@"Password"];
       
        [_txtPassword.txtView setSecureTextEntry:YES];
        
        self.viewPasswordContainer.backgroundColor = [UIColor clearColor];
     
        
        
        
    }
    return _txtPassword;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"Choose Password";
    [self.txtPassword setHidden:NO];
    [self.txtConfirmPassword setHidden:NO];
    
    self.btnSignUp.layer.cornerRadius = 5;
    
    
#ifndef NDEBUG

    self.txtPassword.txtView.text = @"111111";
    self.txtConfirmPassword.txtView.text = @"111111";

#endif

    
    
}


- (IBAction)btnSignUpTapped:(id)sender {
    
    if ([self.txtPassword.txtView.text isEqualToString:self.txtConfirmPassword.txtView.text]) {
        
        if ([self.txtConfirmPassword.txtView.text length] < 5) {
            
            [self showAlert:@"" message:@"Passwordshoudl be greater that 4 characters"];
            
        }
        else{
            
            NSString * accountType =  self.accountType;
            
            if ([accountType isEqualToString:@"U"]) {
                
                UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                UIViewController *initViewController;
                initViewController = [storyBoard instantiateViewControllerWithIdentifier:@"RooTView"];
                
                AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                
                appDelegate.window.rootViewController = initViewController;
                
            }
            else {
                
                UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MainTrainer" bundle:nil];
                UIViewController *initViewController;
                initViewController = [storyBoard instantiateViewControllerWithIdentifier:@"RooTView"];
                
                AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                
                appDelegate.window.rootViewController = initViewController;
                
                
            }
            
        }
    }else {
        
        
        [self showAlert:@"" message:@"Password and confirm password does not match."];
        
    }
    
    
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
