//
//  ViewController.m
//  CheckBall
//
//  Created by Tauqeer Ahmed on 11/22/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import "ViewController.h"
#import "TextViewForSignUpform.h"

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
