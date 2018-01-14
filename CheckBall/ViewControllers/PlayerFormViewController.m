//
//  PlayerFormViewController.m
//  CheckBall
//
//  Created by Tauqeer Ahmed on 11/29/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import "PlayerFormViewController.h"
#import "TextViewForSignUpform.h"
#import "MakePassowdViewController.h"
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

@property (weak, nonatomic) IBOutlet UIPickerView *heightPickerView;

@property (weak, nonatomic) IBOutlet UIView *viewFormContainer;

@property (weak, nonatomic) IBOutlet UIView *viewPickerContainer;


@property (weak, nonatomic) IBOutlet UILabel *lblSelectHeight;
@property (nonatomic,strong) NSArray * heightFeets;
@property (nonatomic,strong) NSArray * heightInches;

@property (nonatomic,strong) NSMutableArray * weightsArray;

@property (nonatomic) BOOL isSelectingHeight;


@end

@implementation PlayerFormViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.destinationViewController isKindOfClass:[MakePassowdViewController class]])
    {
        MakePassowdViewController * destinationViewController = segue.destinationViewController;
        destinationViewController.accountType = @"U";
        destinationViewController.fullName = self.textViewName.txtView.text;
        destinationViewController.height = self.txtHeight.txtView.text;
        destinationViewController.weight = self.txtWeight.txtView.text;
        destinationViewController.position = self.txtPosition.txtView.text;
        destinationViewController.zipCode = self.txtZipCode.txtView.text;
        
        
        
    }
}
-(void)hidePickerViewITems{
    
    [self.viewPickerContainer setHidden:YES];
    [self.viewFormContainer setHidden:NO];
    
    
}
- (IBAction)btnHEightPickerCancelTapped:(id)sender
{
    
    [self hidePickerViewITems];
    
    
}
- (IBAction)btnHeightSelectedDoneTapped:(id)sender {
    
    [self hidePickerViewITems];
    
    
    if (self.isSelectingHeight){
        int feetIndex = [self.heightPickerView selectedRowInComponent:0];
        int inchesIndex = [self.heightPickerView selectedRowInComponent:1];
        
        
        NSString * finalSelectedHeight = [NSString stringWithFormat:@"%@%@",[self.heightFeets objectAtIndex:feetIndex],[self.heightInches objectAtIndex:inchesIndex]];
        
        self.txtHeight.txtView.text = finalSelectedHeight;
        
        
    }
    else {
        
        NSString * finalSelectedHeight = [NSString stringWithFormat:@"%@",[self.weightsArray objectAtIndex:[self.heightPickerView selectedRowInComponent:0]]];
        
        self.txtWeight.txtView.text = finalSelectedHeight;
        
        
        
        
    }
    
    NSLog(@"");
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    // return the number of components required
    
    if (self.isSelectingHeight) {
        
        return 2;
        
    }
    return 1;
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (self.isSelectingHeight) {
        
        if (component == 0) {
            return [self.heightFeets count];
        }
        else {
            
            return [self.heightInches count];
            
        }
    }
    
    return [self.weightsArray count];
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    // Component 0 should load the array1 values, Component 1 will have the array2 values
    if (self.isSelectingHeight){
        
        
        if (component == 0) {
            return  [self.heightFeets objectAtIndex:row];
        }
        else if (component == 1) {
            return  [self.heightInches objectAtIndex:row];
        }
    }
    
    return [self.weightsArray objectAtIndex:row];;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Create Player Account";
    
    self.isSelectingHeight = YES;
    
    
    [self.textViewName setHidden:NO];
    [self.txtHeight setHidden:NO];
    [self.txtWeight setHidden:NO];
    [self.txtPosition setHidden:NO];
    [self.txtSchool setHidden:NO];
    [self.txtZipCode setHidden:NO];
    
    self.btnContinue.layer.cornerRadius = 5;
    
    self.heightFeets = @[@"1'",@"2'",@"3'",@"4'",@"5'",@"6'",@"7'",@"8'"];
    
    self.heightInches = @[@"1\"",@"2\"",@"3\"",@"4\"",@"5\"",@"6\"",@"7\"",@"8\"",@"9\"",@"10\"",@"11\""];
    
    
    self.weightsArray = [NSMutableArray new];
    
    for (int i = 50;i<1451;i++)
    {
        [self.weightsArray addObject:[NSString stringWithFormat:@"%d lb",i]];
    }
    
    
    
    
}

- (IBAction)btnContinueTapped:(UIButton *)sender {
    
    if ([self.textViewName.txtView.text length] == 0 || [self.txtHeight.txtView.text length] == 0 || [self.txtWeight.txtView.text length] == 0 || [self.txtPosition.txtView.text length] == 0 || [self.txtZipCode.txtView.text length] == 0)
    {
        
        [self showAlert:@"" message:@"Please fill all the fields"];
        return;
    }
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
        
        [_txtWeight.txtView setTag:22];
        
        
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
        _txtHeight.txtView.tag = 11;
        
        
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

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    
    if (textField.tag == 11) {
        
        self.isSelectingHeight = YES;
        
        [self.viewFormContainer setHidden:YES];
        [self.viewPickerContainer setHidden:NO];
        
        self.isSelectingHeight = YES;
        [self.view endEditing:YES];
        self.lblSelectHeight.text = @"Select Height";
        
        [self.heightPickerView reloadAllComponents];
        
        
        return NO;
        
    }
    else if (textField.tag == 22) {
        
        [self.viewFormContainer setHidden:YES];
        [self.viewPickerContainer setHidden:NO];
        
        self.isSelectingHeight = NO;
        
        [self.heightPickerView reloadAllComponents];
        
        [self.view endEditing:YES];

        self.lblSelectHeight.text = @"Select Weight";
        return NO;
        
        
        
    }
    
    
    
    [self.viewFormContainer setHidden:NO];
    [self.viewPickerContainer setHidden:YES];
    
    return YES;
    
}



@end
