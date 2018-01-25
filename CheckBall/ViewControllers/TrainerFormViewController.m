//
//  TrainerFormViewController.m
//  CheckBall
//
//  Created by Tauqeer Ahmed on 11/29/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import "TrainerFormViewController.h"
#import "TextViewForSignUpform.h"
#import "TrainingSpecialityCollectionViewCell.h"
#import "User.h"
#import "MakePassowdViewController.h"
#import "Specialities.h"
@interface TrainerFormViewController ()<UICollectionViewDelegate,UICollectionViewDataSource
>
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

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray * selectedArray;



@property (nonatomic,strong) NSMutableArray * trainingList;

@property (nonatomic,strong) id specialitesServiceResponse;

@property (nonatomic,strong) NSMutableDictionary * trainingDictionary;

@property (nonatomic,strong) NSMutableArray * finalSelectedItems;
@property (weak, nonatomic) IBOutlet UIPickerView *heightPickerView;

@property (weak, nonatomic) IBOutlet UIView *viewFormContainer;

@property (weak, nonatomic) IBOutlet UIToolbar *pickerToolbar;
@property (weak, nonatomic) IBOutlet UIView *viewPickerContainer;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *centerLine;

@property (weak, nonatomic) IBOutlet UILabel *lblSelectHeight;
@property (nonatomic,strong) NSArray * heightFeets;
@property (nonatomic,strong) NSArray * heightInches;

@property (nonatomic,strong) NSMutableArray * weightsArray;

@property (nonatomic) BOOL isSelectingHeight;


@property (nonatomic) BOOL showingHeightFistTime;
@property (nonatomic) BOOL showingWeightFirstTime;


@end


@implementation TrainerFormViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.destinationViewController isKindOfClass:[MakePassowdViewController class]])
    {
        MakePassowdViewController * destinationViewController = segue.destinationViewController;
        destinationViewController.accountType = @"P";
        
        destinationViewController.fullName = self.textViewName.txtView.text;
        destinationViewController.height = self.txtHeight.txtView.text;
        destinationViewController.weight = self.txtWeight.txtView.text;
        destinationViewController.position = self.txtPosition.txtView.text;
        destinationViewController.zipCode = self.txtZipCode.txtView.text;
        destinationViewController.allSpecialitesSelected = self.finalSelectedItems;
        destinationViewController.schoolSelcted = self.txtSchool.txtView.text;
        destinationViewController.accountEmail = self.emailSending;
        
        if (self.signingWithFB) {
            
            destinationViewController.signingWithFB = self.signingWithFB;
            
            destinationViewController.fbAccount = self.fbAccount;
            
            
        }
        

        
       // ;
       // fbAccount;
       // fbName;

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
        [_txtWeight.txtView setTag:22];
        
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
        
        [_txtSchool setUpViewWithText:@"School"];
        
        self.viewContainerSchool.backgroundColor = [UIColor clearColor];
        
    }
    return _txtSchool;
    
}



//,

- (void)viewDidLoad {
    self.dontAutoHideKeyboard = YES;
    
    [super viewDidLoad];
    

    self.trainingList =  [NSMutableArray new];

    self.isSelectingHeight = YES;
    
    self.selectedArray = [NSMutableArray new];
    
    
    self.heightFeets = @[@"1'",@"2'",@"3'",@"4'",@"5'",@"6'",@"7'",@"8'"];
    
    self.heightInches = @[@"0\"",@"1\"",@"2\"",@"3\"",@"4\"",@"5\"",@"6\"",@"7\"",@"8\"",@"9\"",@"10\"",@"11\""];
    

    self.weightsArray = [NSMutableArray new];
    
    for (int i = 50;i<1451;i++)
    {
        [self.weightsArray addObject:[NSString stringWithFormat:@"%d lb",i]];
    }
    
    self.finalSelectedItems =[NSMutableArray new];
   
    self.title = @"Create Trainer Account";
    
    [self.textViewName setHidden:NO];
    [self.txtHeight setHidden:NO];
    [self.txtWeight setHidden:NO];
    [self.txtPosition setHidden:NO];
    [self.txtSchool setHidden:NO];
    [self.txtZipCode setHidden:NO];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"TrainingSpecialityCollectionViewCell" bundle:nil]
          forCellWithReuseIdentifier:@"cellSpeciality"];

    
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    
    
    self.btnContinue.layer.cornerRadius = 5;
    
    
    [self.view bringSubviewToFront:self.viewFormContainer];
    
    [Specialities callGetSpecialitesWithComplitionHandler:^(id result) {
        
        
        self.specialitesServiceResponse = result;
        [self hideLoader];
        
        NSMutableDictionary * tmpDic = [NSMutableDictionary new];
        
    
        for (id currentItem in result) {
            
            
        [self.trainingList addObject:[currentItem objectForKey:@"Name"]];
        [self.selectedArray addObject:@"0"];
            
            NSLog(@"%@",currentItem);
            
            
            [tmpDic setValue:[currentItem objectForKey:@"ID"] forKey:[currentItem objectForKey:@"Name"]];
            
        }
        
        self.trainingDictionary = tmpDic;
        
        NSLog(@"");
        
        
        [self.collectionView reloadData];
        
    } withFailueHandler:^{
        
        [self hideLoader];
        
    }];
    
    
    
    if (self.signingWithFB)
    {
        self.textViewName.txtView.text = self.fbName;
        
    }
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    
    [self.collectionView reloadData];

    
}




- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section{
    
    return [self.trainingList count];
    
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TrainingSpecialityCollectionViewCell *currentCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellSpeciality" forIndexPath:indexPath];
    
    
    currentCell.lblItemName.text = [self.trainingList objectAtIndex:indexPath.row];
    
    return currentCell;
}


- (IBAction)btnContinueTapped:(UIButton *)sender {
    


    if ([self.textViewName.txtView.text length] == 0 || [self.txtHeight.txtView.text length] == 0 || [self.txtWeight.txtView.text length] == 0 || [self.txtPosition.txtView.text length] == 0 || [self.txtZipCode.txtView.text length] == 0 || [self.finalSelectedItems count] == 0)
    {
    
        [self showAlert:@"" message:@"Please fill all the fields"];
        return;
        
    }
    
    [self performSegueWithIdentifier:@"segueSetPassword" sender:self];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.collectionView.frame.size.width/2, 42);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
 
    TrainingSpecialityCollectionViewCell * cellItem = (TrainingSpecialityCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    
    NSLog(@"");
    id currentItemToAdd = [self.trainingList objectAtIndex:indexPath.row];
    
    
    if ([[self.selectedArray objectAtIndex:indexPath.row] intValue] == 0) {
    
        [cellItem.checkImage setImage:[UIImage imageNamed:@"checkedButton"]];
        
        
        [self.selectedArray replaceObjectAtIndex:indexPath.row withObject:@"1"];
    
       
        

        [self.finalSelectedItems addObject: [self.trainingDictionary objectForKey:currentItemToAdd]];
        
        
        NSLog(@"%@",self.finalSelectedItems);
        
    }
    else {
        [cellItem.checkImage setImage:[UIImage imageNamed:@"unCheckedButton"]];
        [self.selectedArray replaceObjectAtIndex:indexPath.row withObject:@"0"];
        
        [self.finalSelectedItems removeObject:currentItemToAdd];
        NSLog(@"%@",self.finalSelectedItems);
        
        
        
        
    }

 
    [self.view endEditing:YES];
    
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    

    if (textField.tag == 11) {
        
        [self.viewFormContainer setHidden:YES];
        [self.viewPickerContainer setHidden:NO];
        
        self.isSelectingHeight = YES;
        [self.view endEditing:YES];
        self.lblSelectHeight.text = @"Select Height";
        
        
        if (!self.showingHeightFistTime) {
            [ self.heightPickerView selectRow:4 inComponent:0 animated:NO];
            self.showingHeightFistTime = YES;
        }
        
        return NO;
        
    }
    else if (textField.tag == 22) {
        
        [self.viewFormContainer setHidden:YES];
        [self.viewPickerContainer setHidden:NO];
        
        self.isSelectingHeight = NO;
        
        [self.heightPickerView reloadAllComponents];
        
        [self.view endEditing:YES];

        self.lblSelectHeight.text = @"Select Weight";
        
        
        if (!self.showingWeightFirstTime) {
            [ self.heightPickerView selectRow:100 inComponent:0 animated:NO];
            self.showingWeightFirstTime = YES;
            
        }
        
        return NO;
        
        
        
    }
    
    
    
    [self.viewFormContainer setHidden:NO];
    [self.viewPickerContainer setHidden:YES];
    
    return YES;
    
}

@end
