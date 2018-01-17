//
//  ViewController.m
//  CheckBall
//
//  Created by Tauqeer Ahmed on 11/22/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import "ViewController.h"
#import "TextViewForSignUpform.h"
#import "AppDelegate.h"
#import "User.h"
#import "Validator.h"
@interface ViewController ()<UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UIView *viewContainEmail;

@property (nonatomic,strong) TextViewForSignUpform *textViewEmail;

@property (weak, nonatomic) IBOutlet UIView *viewPasswordContainer;
@property (nonatomic,strong) TextViewForSignUpform *textViewPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;

@property (weak, nonatomic) IBOutlet UIButton *btnForgetButton;
@property (weak, nonatomic) IBOutlet UIButton *btnFacebook;
@property (weak, nonatomic) IBOutlet UIButton *btnCreateAccount;

@end

@implementation ViewController

-(TextViewForSignUpform *)textViewEmail{
    
    
    if (!_textViewEmail) {
        
        _textViewEmail = (TextViewForSignUpform *)
        [self.view addSubViewWithContainerView:self.viewContainEmail
                               andEnteringView:_textViewEmail
                                   withNibName:@"TextViewForSignUpform"];
        
        _textViewEmail.txtView.isMandatory = YES;
        _textViewEmail.txtView.keyboardType = UIKeyboardTypeEmailAddress;
        _textViewEmail.txtView.delegate = self;
        
        [_textViewEmail setUpViewWithText:@"Email"];
        
        self.viewContainEmail.backgroundColor = [UIColor clearColor];
        
    }
    return _textViewEmail;
    
}


-(TextViewForSignUpform *)textViewPassword{
    
    
    if (!_textViewPassword) {
        
        _textViewPassword = (TextViewForSignUpform *)
        [self.view addSubViewWithContainerView:self.viewPasswordContainer
                               andEnteringView:_textViewPassword
                                   withNibName:@"TextViewForSignUpform"];
        
        _textViewPassword.txtView.isMandatory = YES;

        _textViewPassword.txtView.delegate = self;
        [_textViewPassword.txtView setSecureTextEntry:YES];
        
        [_textViewPassword setUpViewWithText:@"Password"];
        
        self.viewPasswordContainer.backgroundColor = [UIColor clearColor];
        
    }
    return _textViewPassword;
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.textViewEmail.txtView addRegx:REGEX_EMAIL
                                withMsg:@"Enter Valid Email"];
    
    
    
    [self.textViewPassword setHidden:NO];
    

    self.btnLogin.layer.cornerRadius = 5;
    self.btnForgetButton.layer.cornerRadius = 5;
    self.btnFacebook.layer.cornerRadius = 5;
    self.btnCreateAccount.layer.cornerRadius = 5;
    
    
    
    
}

- (IBAction)btnForgotPasswordTapped:(UIButton *)sender {
    
    
    [self performSegueWithIdentifier:@"segueForgotPassword" sender:self];
    
}
- (IBAction)btnCreateAccount:(UIButton *)sender {
    
    [self performSegueWithIdentifier:@"segueSelectAccountType" sender:self];
    
}
- (IBAction)loginButtonTapped:(UIButton *)sender {


    if (![Validator validateEmptyString:self.textViewPassword.txtView.text]
        || ![Validator validateEmptyString:self.textViewPassword.txtView.text])
    {
    
        [self showAlert:@"" message:@"Please enter both email and password"];
    
        return;
        
    }
    
    
    if (![Validator validateEmailAddress:self.textViewEmail.txtView.text]) {
        
        [self showAlert:@"" message:@"Please enter valid email address"];
        
        return;
        
    }
    
    [self showLoader];
    

    self.textViewEmail.txtView.text = @"faheem@plego.com";
    self.textViewPassword.txtView.text = @"plego100";
    
    [User callLoginUserWithEmail:self.textViewEmail.txtView.text
                    withPassword:self.textViewPassword.txtView.text
           withComplitionHandler:^(id result) {
        
              NSString * accountType =  [result objectForKey:@"Account_Type"];
               
               if ([accountType isEqualToString:@"P"]) {
                
                   UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                   UIViewController *initViewController;
                   initViewController = [storyBoard instantiateViewControllerWithIdentifier:@"RooTView"];
                   
                   AppDelegate * appDelegate = [[UIApplication sharedApplication] delegate];
                   
                   appDelegate.window.rootViewController = initViewController;
                   
               }
               else {
                   
                   UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MainTrainer" bundle:nil];
                   UIViewController *initViewController;
                   initViewController = [storyBoard instantiateViewControllerWithIdentifier:@"RooTView"];
                   
                   AppDelegate * appDelegate = [[UIApplication sharedApplication] delegate];
                   
                   appDelegate.window.rootViewController = initViewController;
                   
                   
               }
               NSLog(@"");
               
               //

               
               
    } withFailueHandler:^{
        
        
        
        [self hideLoader];
        [self showAlert:@"" message:@"Invalid login credtials entered"];
    } withNoAccountExistsHandler:^(id result) {
        
    }];
    

    return;
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
