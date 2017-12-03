//
//  SelectEmailViewController.m
//  CheckBall
//
//  Created by Tauqeer Ahmed on 11/29/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import "SelectEmailViewController.h"
#import "TextViewForSignUpform.h"

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
    
    
}
- (IBAction)btnEmailTapped:(UIButton *)sender {
    
    if (self.comingAsTrainer) {
        
        [self performSegueWithIdentifier:@"segueTrainer" sender:self];
        
    }
    else {
        
        [self performSegueWithIdentifier:@"seguePlayer" sender:self];

    }
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