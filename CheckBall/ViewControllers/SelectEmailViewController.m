//
//  SelectEmailViewController.m
//  CheckBall
//
//  Created by Tauqeer Ahmed on 11/29/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import "SelectEmailViewController.h"
#import "TextViewForSignUpform.h"
#import "User.h"
#import "Validator.h"
#import "TrainerFormViewController.h"
#import "PlayerFormViewController.h"

@interface SelectEmailViewController ()
@property (weak, nonatomic) IBOutlet UIView *viewEmailContainer;
@property (weak, nonatomic) IBOutlet UIButton *btnEmail;

@property (nonatomic,strong) TextViewForSignUpform *textViewEmail;


@end

@implementation SelectEmailViewController

-(TextViewForSignUpform *)textViewEmail{
    
    
    if (!_textViewEmail) {
        
        _textViewEmail = (TextViewForSignUpform *)
        [self.view addSubViewWithContainerView:self.viewEmailContainer
                               andEnteringView:_textViewEmail
                                   withNibName:@"TextViewForSignUpform"];
        
        _textViewEmail.txtView.isMandatory = YES;
        _textViewEmail.txtView.keyboardType = UIKeyboardTypeEmailAddress;
        _textViewEmail.txtView.delegate = self;
        
        [_textViewEmail setUpViewWithText:@"Enter your email here"];
        
        self.viewEmailContainer.backgroundColor = [UIColor clearColor];
        
    }
    return _textViewEmail;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.comingAsTrainer) {
        
        self.title = @"Create Trainer Account";
        
        
    }
    else {
        self.title = @"Create Player Account";
        
        
    }
    
    [self.btnEmail setTitle:@"Continue Registeration" forState:UIControlStateNormal];
    
    // Do any additional setup after loading the view.
    [self.textViewEmail.txtView addRegx:REGEX_EMAIL
                                withMsg:@"Enter Valid Email"];
    
    self.btnEmail.layer.cornerRadius = 5;
#ifndef NDEBUG
    self.textViewEmail.txtView.text = @"fff@gmail.com";
#endif
    

    if (self.signingWithFB) {
        if ([self.fbEmail length] > 0) {
            self.textViewEmail.txtView.text = self.fbEmail;
        }
    
        [self btnEmailTapped:nil];
        
    }
    
}




- (IBAction)btnEmailTapped:(UIButton *)sender {
   
    
    
    
    
    if(![Validator validateEmailAddress:self.textViewEmail.txtView.text]){
        
        
        [self showAlert:@"" message:@"Please enter valid email address"];
        
        return;
        
        
        
    }
    [self showLoader];
    
    
    [User callCheckUserExistsWithEmail:self.textViewEmail.txtView.text complitionHandler:^(id result) {
    
        //
        //
        
                [self hideLoader];
        
        if ([result isEqualToString:@"Email Found"])
        {
            [self showAlert:@"" message:@"Account already exists with this email."];
            
         
        
        }
        else {
            
            //Email Not Found
            
            if (self.comingAsTrainer) {
                
                [self performSegueWithIdentifier:@"segueTrainer" sender:self];
                
            }
            else {
                
                [self performSegueWithIdentifier:@"seguePlayer" sender:self];
                
            }
            
            
        }

        
    } withFailueHandler:^{
        
        [self hideLoader];
        [self showAlert:@"" message:@"Error while checking email.Please check your internet."];
        
    }];
    
    
    return;
    

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    
    if ([segue.destinationViewController isKindOfClass:[TrainerFormViewController class]]) {
        TrainerFormViewController * destination = segue.destinationViewController;
        
        destination.emailSending = self.textViewEmail.txtView.text;
        
        if (self.signingWithFB) {
            
            destination.fbName = self.fbName;
            destination.fbAccount = self.fbAccount;
            destination.signingWithFB = self.signingWithFB;
        }

        
    }
    else if([segue.destinationViewController isKindOfClass:[PlayerFormViewController class]])
    {
        
        PlayerFormViewController * destination = segue.destinationViewController;
        
        destination.emailSending = self.textViewEmail.txtView.text;
        
        
        if (self.signingWithFB) {

            destination.fbName = self.fbName;
            destination.fbAccount = self.fbAccount;
            destination.signingWithFB = self.signingWithFB;
        
        }
        
    }
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UIView * txt in self.view.subviews){
        if ([txt isKindOfClass:[UITextField class]] && [txt isFirstResponder]) {
            [txt resignFirstResponder];
        }
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
