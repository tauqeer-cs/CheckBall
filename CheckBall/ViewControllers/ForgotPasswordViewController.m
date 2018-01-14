//
//  ForgotPasswordViewController.m
//  CheckBall
//
//  Created by Tauqeer Ahmed on 11/28/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "TextViewForSignUpform.h"
#import "User.h"


@interface ForgotPasswordViewController ()

@property (weak, nonatomic) IBOutlet UIView *viewTextContainer;

@property (nonatomic,strong) TextViewForSignUpform *textViewEmail;

@property (weak, nonatomic) IBOutlet UIButton *btnReset;


@end

@implementation ForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self.textViewEmail.txtView addRegx:REGEX_EMAIL
                                withMsg:@"Enter Valid Email"];
    
    self.btnReset.layer.cornerRadius = 5;
    //
    
}

-(TextViewForSignUpform *)textViewEmail{
    
    
    if (!_textViewEmail) {
        
        _textViewEmail = (TextViewForSignUpform *)
        [self.view addSubViewWithContainerView:self.viewTextContainer
                               andEnteringView:_textViewEmail
                                   withNibName:@"TextViewForSignUpform"];
        
        _textViewEmail.txtView.isMandatory = YES;
        _textViewEmail.txtView.keyboardType = UIKeyboardTypeEmailAddress;
        _textViewEmail.txtView.delegate = self;
        
        [_textViewEmail setUpViewWithText:@"Email"];
        
        self.viewTextContainer.backgroundColor = [UIColor clearColor];
        
    }
    return _textViewEmail;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnResetPassword:(id)sender {
    
    [self showLoader];
    
    [User callForgetPasswordWithEmail:self.textViewEmail.txtView.text complitionHandler:^(id result) {
        
        [self hideLoader];
        
        [self callAlertViewControllerWithTitle:@"" withMessage:result
                             withOkButtonTitle:@"OK"
                               withCancleTitle:nil withOKHandler:^{
            
                                   
                                   [self.navigationController popViewControllerAnimated:YES];
                                   
                                   
                                   
        } withCancelHandler:^{
            
            [self hideLoader];
            
            
            NSLog(@"Cancle");
            
        }];
        
        
    } withFailueHandler:^{
        
        [self hideLoader];
        [self showAlert:@"" message:@"Error while resetting password"];
        
    }];
    
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
