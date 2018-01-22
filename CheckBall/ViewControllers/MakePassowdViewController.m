//
//  MakePassowdViewController.m
//  CheckBall
//
//  Created by Tauqeer on 03/12/2017.
//  Copyright © 2017 plego. All rights reserved.
//

#import "MakePassowdViewController.h"
#import "TextViewForSignUpform.h"
#import "User.h"

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

    
    if (self.signingWithFB) {
        
        self.txtPassword.txtView.text = @"111111";
        self.txtConfirmPassword.txtView.text = @"111111";

        
        [self btnSignUpTapped:nil];
        
    }
    
    
}


- (IBAction)btnSignUpTapped:(id)sender {
    

    
    if ([self.txtPassword.txtView.text isEqualToString:self.txtConfirmPassword.txtView.text]) {
        
        if ([self.txtConfirmPassword.txtView.text length] < 5) {
            
            [self showAlert:@"" message:@"Passwordshoudl be greater that 4 characters"];
            
        }
        else{
            
            
            NSMutableDictionary * tmpDictionary = [NSMutableDictionary new];
            
            if (self.signingWithFB ) {
                
                [tmpDictionary setObject:self.fbAccount forKey:@"FB_ID"];
                [tmpDictionary setObject:@"" forKey:@"Password"];
            }
            else
            {
                [tmpDictionary setObject:@"" forKey:@"FB_ID"];
                        [tmpDictionary setObject:self.txtPassword.txtView.text forKey:@"Password"];
            }
            [tmpDictionary setObject:self.fullName forKey:@"Name"];
            [tmpDictionary setObject:self.accountEmail forKey:@"Email"];
            if ([self.accountType isEqualToString:@"U"]) {
               
                [tmpDictionary setObject:@"P" forKey:@"Account_Type"];
                
            }
            else
            [tmpDictionary setObject:@"T" forKey:@"Account_Type"];
            
            
            
            NSString * finalHeightString =[[self.height stringByReplacingOccurrencesOfString:@"\"" withString:@""] stringByReplacingOccurrencesOfString:@"'" withString:@"."];
            
            NSString * finalWeightString =[self.weight stringByReplacingOccurrencesOfString:@" lb" withString:@""];
            
            
            
            [tmpDictionary setObject:finalHeightString forKey:@"Height"];
            
            
            [tmpDictionary setObject:finalWeightString forKey:@"Weight"];
            [tmpDictionary setObject:self.position forKey:@"Position"];
            [tmpDictionary setObject:self.schoolSelcted forKey:@"School"];
            [tmpDictionary setObject:@"" forKey:@"Bio"];
            [tmpDictionary setObject:self.zipCode forKey:@"ZipCode"];

            NSMutableDictionary * paramsToPass = [NSMutableDictionary new];
            
            [paramsToPass setObject:@[tmpDictionary] forKey:@"Account"];
            
            
            
            NSMutableArray * arraySending  = [NSMutableArray new];
            
            for (NSString * currentItem in self.allSpecialitesSelected)
            {
                NSMutableDictionary * tmpDic = [NSMutableDictionary new];
                
                [tmpDic setObject:currentItem forKey:@"ID"];
                
                [arraySending addObject:tmpDic];
                
            }
            
            [paramsToPass setObject:arraySending forKey:@"Specilities"];
            

            
            [self showLoader];
            
            NSString * accountType =  self.accountType;
            
            if ([accountType isEqualToString:@"U"]) {
                

                
                [User callRegisterUserWithParams:paramsToPass withComplitionHandler:^(id result) {
                
                    [self hideLoader];
                    
                    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    UIViewController *initViewController;
                    initViewController = [storyBoard instantiateViewControllerWithIdentifier:@"RooTView"];
                    
                    AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                    
                    appDelegate.window.rootViewController = initViewController;
                    
                } withFailueHandler:^{
                    
                    [self hideLoader];
                    [self showAlert:@"" message:@"Error while creating user."];
                } withAlreadyExistsHandler:^(id result) {
                    
                    [self hideLoader];
                    [self showAlert:@"" message:@"User Already registerd with this email."];
                    
                }];
                
            }
            else {
                
                [User callRegisterUserWithParams:paramsToPass withComplitionHandler:^(id result) {
                    
                    [self hideLoader];
                    
                    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MainTrainer" bundle:nil];
                    UIViewController *initViewController;
                    initViewController = [storyBoard instantiateViewControllerWithIdentifier:@"RooTView"];
                    
                    AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                    
                    appDelegate.window.rootViewController = initViewController;
                    
                } withFailueHandler:^{
                    [self hideLoader];
                    [self showAlert:@"" message:@"Error while creating user."];
                    
                } withAlreadyExistsHandler:^(id result) {
                    
                    [self hideLoader];
                    [self showAlert:@"" message:@"User Already registerd with this email."];
                }];
                

                
                
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
