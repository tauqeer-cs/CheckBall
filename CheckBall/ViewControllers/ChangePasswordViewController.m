//
//  ChangePasswordViewController.m
//  CheckBall
//
//  Created by Shehzad Bilal on 20/01/2018.
//  Copyright © 2018 plego. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnUpdate;

@property (weak, nonatomic) IBOutlet UIView *viewOldPasswordContainer;
@property (nonatomic,strong) TextViewForSignUpform *txtOldPassword;


@property (weak, nonatomic) IBOutlet UIView *viewPasswordContainer;
@property (nonatomic,strong) TextViewForSignUpform *txtPassword;

@property (weak, nonatomic) IBOutlet UIView *viewConfirmPassword;
@property (nonatomic,strong) TextViewForSignUpform *txtConfirmPassword;


@end



@implementation ChangePasswordViewController


-(TextViewForSignUpform *)txtOldPassword{
    
    
    if (!_txtOldPassword) {
        
        _txtOldPassword = (TextViewForSignUpform *)
        [self.view addSubViewWithContainerView:self.viewOldPasswordContainer
                               andEnteringView:_txtOldPassword
                                   withNibName:@"TextViewForSignUpform"];
        
        _txtOldPassword.txtView.isMandatory = YES;
        _txtOldPassword.txtView.delegate = self;
        [_txtOldPassword setUpViewWithText:@"Old Password"];
        
        [_txtOldPassword.txtView setSecureTextEntry:YES];
        
        self.viewOldPasswordContainer.backgroundColor = [UIColor clearColor];
        
        
    }
    return _txtOldPassword;
    
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


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Choose Password";
    [self.txtPassword setHidden:NO];
    [self.txtConfirmPassword setHidden:NO];
    [self.txtOldPassword setHidden:NO];

    //
    self.btnUpdate.layer.cornerRadius = 5;
    
    
}
- (IBAction)btnUpdateTapped:(UIButton *)sender {
    
    
    
    if ([self.txtOldPassword.txtView.text length] == 0 || [self.txtPassword.txtView.text length] == 0  || [self.txtConfirmPassword.txtView.text length] == 0 ) {
    
        [self showAlert:@"" message:@"Please fill all fields"];
    
        return;
        
    }
    
    if ([self.txtPassword.txtView.text isEqualToString:self.txtConfirmPassword.txtView.text]) {
        
    }
    else {
        
        [self showAlert:@"" message:@"Password and confirm password does not match"];
        return;
        
    }
    
    [self showLoader];
    
    
    [User callChangePasswordWithOldPassword:self.txtOldPassword.txtView.text withNewPassword:self.txtOldPassword.txtView.text withMyId:[self.myJid intValue] withComplitionHandler:^(id result) {
        
        [self showAlert:@"" message:@"Password updated successfully"];
        
        [self hideLoader];
        
    } withFailueHandler:^{
    
        [self hideLoader];
        [self showAlert:@"" message:@"Error while updating password"];
        
    }];
    
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

@end
