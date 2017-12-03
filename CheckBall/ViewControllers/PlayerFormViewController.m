//
//  PlayerFormViewController.m
//  CheckBall
//
//  Created by Tauqeer Ahmed on 11/29/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import "PlayerFormViewController.h"
#import "TextViewForSignUpform.h"

@interface PlayerFormViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnContinue;

@property (weak, nonatomic) IBOutlet UIView *viewNameContainer;
@property (nonatomic,strong) TextViewForSignUpform *textViewName;

@property (weak, nonatomic) IBOutlet UIView *viewHeightContainer;
@property (nonatomic,strong) TextViewForSignUpform *txtHeight;

@property (weak, nonatomic) IBOutlet UIView *viewWeightContainer;
@property (nonatomic,strong) TextViewForSignUpform *txtWeight;

@property (weak, nonatomic) IBOutlet UIView *viewContainerPosition;
@property (nonatomic,strong) TextViewForSignUpform *txtPosition;

@property (weak, nonatomic) IBOutlet UIView *viewContainerSchool;
@property (nonatomic,strong) TextViewForSignUpform *txtSchool;
@property (weak, nonatomic) IBOutlet UIView *viewContainerZipCode;
@property (nonatomic,strong) TextViewForSignUpform *txtZipCode;


@end

@implementation PlayerFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Create Player Account";

    [self.textViewName setHidden:NO];
    [self.txtHeight setHidden:NO];
    [self.txtWeight setHidden:NO];
    [self.txtPosition setHidden:NO];
    [self.txtSchool setHidden:NO];
    [self.txtZipCode setHidden:NO];
    
    self.btnContinue.layer.cornerRadius = 5;
    
    
    
}

- (IBAction)btnContinueTapped:(UIButton *)sender {
    
    
    [self performSegueWithIdentifier:@"segueSetPassword" sender:self];
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

-(TextViewForSignUpform *)txtZipCode{
    
    
    if (!_txtZipCode) {
        
        _txtZipCode = (TextViewForSignUpform *)
        [self.view addSubViewWithContainerView:self.viewContainerZipCode
                               andEnteringView:_txtZipCode
                                   withNibName:@"TextViewForSignUpform"];
        
        _txtZipCode.txtView.isMandatory = YES;
        _txtZipCode.txtView.delegate = self;
        [_txtZipCode setUpViewWithText:@"Zip Code"];
        self.viewContainerZipCode.backgroundColor = [UIColor clearColor];
        
    }
    return _txtZipCode;
    
}

-(TextViewForSignUpform *)txtWeight{
    
    
    if (!_txtWeight) {
        
        _txtWeight = (TextViewForSignUpform *)
        [self.view addSubViewWithContainerView:self.viewWeightContainer
                               andEnteringView:_txtWeight
                                   withNibName:@"TextViewForSignUpform"];
        
        _txtWeight.txtView.isMandatory = YES;
        _txtWeight.txtView.delegate = self;
        
        [_txtWeight setUpViewWithText:@"Weight"];
        
        self.viewWeightContainer.backgroundColor = [UIColor clearColor];
        
    }
    return _txtWeight;
    
}

-(TextViewForSignUpform *)txtHeight{
    
    
    if (!_txtHeight) {
        
        _txtHeight = (TextViewForSignUpform *)
        [self.view addSubViewWithContainerView:self.viewHeightContainer
                               andEnteringView:_txtHeight
                                   withNibName:@"TextViewForSignUpform"];
        
        _txtHeight.txtView.isMandatory = YES;
        _txtHeight.txtView.delegate = self;
        
        [_txtHeight setUpViewWithText:@"Height"];
        
        self.viewHeightContainer.backgroundColor = [UIColor clearColor];
        
    }
    return _txtHeight;
    
}

-(TextViewForSignUpform *)textViewName{
    
    
    if (!_textViewName) {
        
        _textViewName = (TextViewForSignUpform *)
        [self.view addSubViewWithContainerView:self.viewNameContainer
                               andEnteringView:_textViewName
                                   withNibName:@"TextViewForSignUpform"];
        
        _textViewName.txtView.isMandatory = YES;
        _textViewName.txtView.delegate = self;
        
        [_textViewName setUpViewWithText:@"Name"];
        
        self.viewNameContainer.backgroundColor = [UIColor clearColor];
        
    }
    return _textViewName;
    
}

-(TextViewForSignUpform *)txtPosition{
    
    
    if (!_txtPosition) {
        
        _txtPosition = (TextViewForSignUpform *)
        [self.view addSubViewWithContainerView:self.viewContainerPosition
                               andEnteringView:_txtPosition
                                   withNibName:@"TextViewForSignUpform"];
        
        _txtPosition.txtView.isMandatory = YES;
        _txtPosition.txtView.delegate = self;
        
        [_txtPosition setUpViewWithText:@"Position"];
        
        self.viewContainerPosition.backgroundColor = [UIColor clearColor];
        
    }
    return _txtPosition;
    
}

-(TextViewForSignUpform *)txtSchool{
    
    
    if (!_txtSchool) {
        
        _txtSchool = (TextViewForSignUpform *)
        [self.view addSubViewWithContainerView:self.viewContainerSchool
                               andEnteringView:_txtSchool
                                   withNibName:@"TextViewForSignUpform"];
        
        _txtSchool.txtView.isMandatory = YES;
        _txtSchool.txtView.delegate = self;
        
        [_txtSchool setUpViewWithText:@"Position"];
        
        self.viewContainerSchool.backgroundColor = [UIColor clearColor];
        
    }
    return _txtSchool;
    
}



@end
