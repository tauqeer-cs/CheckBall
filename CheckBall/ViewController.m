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
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "SelectedAccountTypeViewController.h"

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
    
    if ([FBSDKAccessToken currentAccessToken]) {
        
        NSLog(@"%@",[FBSDKAccessToken currentAccessToken]);
        
        FBSDKAccessToken * currentToken = [FBSDKAccessToken currentAccessToken];
        
        [self showLoader];
        
        FBSDKLoginManager *loginL = [[FBSDKLoginManager alloc] init];
        
        [loginL logOut];
        
        //[self getFacebookProfileInfos];
        
        
        
        
    }
    
    
    
    
}

- (IBAction)btnForgotPasswordTapped:(UIButton *)sender {
    
    
    [self performSegueWithIdentifier:@"segueForgotPassword" sender:self];
    
}
- (IBAction)btnCreateAccount:(UIButton *)sender {
    
    [self performSegueWithIdentifier:@"segueSelectAccountType" sender:self];
    
}
- (void)extracted:(id)result {
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
    

    //self.textViewEmail.txtView.text = @"faheem@plego.com";
   // self.textViewPassword.txtView.text = @"plego100";
    
    [User callLoginUserWithEmail:self.textViewEmail.txtView.text
                    withPassword:self.textViewPassword.txtView.text
           withComplitionHandler:^(id result) {
        
               [self extracted:result];
               
               //

               
               
    } withFailueHandler:^{
        
        
        
        [self hideLoader];
        [self showAlert:@"" message:@"Invalid login credtials entered"];
    } withNoAccountExistsHandler:^(id result) {
        
    }];
    

    return;
    
    

}
- (IBAction)btnLoginWithFbTapped:(UIButton *)sender {
    
    [self showLoader];
    
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    login.loginBehavior = FBSDKLoginBehaviorNative;
    [login logInWithReadPermissions:@[@"public_profile", @"email", @"user_friends",@"user_birthday"]
                 fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                     if (error)
                     {
                         // Process error
                         NSLog(@"Error");
                         [self hideLoader];
                         
                         [self showAlert:@"" message:@"Error while loggin in to Facebook"];
                         
                     }
                     else if (result.isCancelled)
                     {
                         // Handle cancellations
                         
                     }
                     else
                     {
                         
                         
                         [self getFacebookProfileInfos];
                         
                     }
                 }];
    
    
}

-(void)getFacebookProfileInfos {
    
    FBSDKGraphRequest *requestMe = [[FBSDKGraphRequest alloc]initWithGraphPath:@"me" parameters: @{@"fields": @"id,name,link,first_name, last_name, picture.type(large), email, birthday, location ,friends ,hometown , friendlists"}];
    
    FBSDKGraphRequestConnection *connection = [[FBSDKGraphRequestConnection alloc] init];
    [connection addRequest:requestMe completionHandler:^(FBSDKGraphRequestConnection *connection,
                                                         id result,
                                                         NSError *error) {
        //ok wjat
        
        if (error)
        {
            
            
            NSLog(@"Error");
            
        }
        if(result)
        {
           
            
            //10155710069191273
            
           __block NSString * fbID = [result objectForKey:@"id"];
            
            
            [User callLoginUserWithFaceBool:fbID
                      withComplitionHandler:^(id result) {
                
                          
                          NSLog(@"");
                          [self hideLoader];
                          [self extracted:result];
                          

                          FBSDKLoginManager *loginL = [[FBSDKLoginManager alloc] init];
                          [loginL logOut];
                          
            } withFailueHandler:^{
                

                [self hideLoader];

                SelectedAccountTypeViewController * destination = (SelectedAccountTypeViewController *)[self viewControllerFromStoryBoard:@"SignUpStoryboard" withViewControllerName:@"SelectedAccountTypeViewController"];
                destination.signingWithFB = YES;
                destination.fbAccount = fbID;
                NSString * emailOfMine = [result objectForKey:@"email"];
                
                NSString * myName =  [result objectForKey:@"name"];
                destination.fbEmail = emailOfMine;
                destination.fbName = myName;
                [self.navigationController showViewController:destination sender:self];
                
                
                
                FBSDKLoginManager *loginL = [[FBSDKLoginManager alloc] init];
                
                [loginL logOut];
                
                
            } withNoAccountExistsHandler:^(id result) {
                
                [self hideLoader];
                
                
                NSLog(@"");
                
            }];
            
            
      

            NSLog(@"%@",result);
            
            
            //url
            __block UIImage *tmp = nil;
            
            
            
        }
        
    }];
    
    [connection start];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//
@end
