//
//  MyUserProfileViewController.m
//  CheckBall
//
//  Created by Shehzad Bilal on 15/01/2018.
//  Copyright © 2018 plego. All rights reserved.
//

#import "MyUserProfileViewController.h"
#import "User.h"
#import "AddingTextViewControl.h"
@interface MyUserProfileViewController ()
@property (weak, nonatomic) IBOutlet UIView *viewProfileImageButtonContainer;
@property (weak, nonatomic) IBOutlet UIButton *btnUserProfileButton;

@property (weak, nonatomic) IBOutlet UIView *viewBasicInfoContainer;
@property (weak, nonatomic) IBOutlet UIView *viewSchoolContainer;

@property (weak, nonatomic) IBOutlet UILabel *lblBio;

@property (weak, nonatomic) IBOutlet UIView *viewBioContainer;
@property (weak, nonatomic) IBOutlet UIView *viewVideoContainer;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewUsing;

@property (weak, nonatomic) IBOutlet UIButton *btnUpdate;

@property (weak, nonatomic) IBOutlet UILabel *lblMyName;
@property (weak, nonatomic) IBOutlet UILabel *lblPosition;
@property (weak, nonatomic) IBOutlet UILabel *lblMyName2;

@property (weak, nonatomic) IBOutlet UILabel *lblHeight;
@property (weak, nonatomic) IBOutlet UILabel *lblWeight;
@property (weak, nonatomic) IBOutlet UILabel *lblPosition2;
@property (weak, nonatomic) IBOutlet UILabel *lblSchool;

@property (nonatomic,strong) AddingTextViewControl * addingTextView;

@property (nonatomic) BOOL changingTheName;
@property (nonatomic) BOOL changingThePosition;
@property (nonatomic) BOOL changingTheSchool;
@property (nonatomic) BOOL changingTheBioDetails;

@property (nonatomic) BOOL changingYouTubeOne;
@property (nonatomic) BOOL changingYouTubeTwo;

@property (nonatomic) BOOL hasEditingAnyField;


@property (weak, nonatomic) IBOutlet UIPickerView *heightPickerView;

@property (weak, nonatomic) IBOutlet UIView *viewPickerContainer;
@property (weak, nonatomic) IBOutlet UILabel *lblSelectHeight;
@property (nonatomic,strong) NSArray * heightFeets;
@property (nonatomic,strong) NSArray * heightInches;

@property (nonatomic,strong) NSMutableArray * weightsArray;

@property (nonatomic) BOOL isSelectingHeight;

@property (nonatomic,strong) NSString * heightSelected;
@property (nonatomic,strong) NSString * weightSelected;


@property (weak, nonatomic) IBOutlet UILabel *lblYouTubeOne;

@property (weak, nonatomic) IBOutlet UILabel *lblYouTubeTwo;
@end

@implementation MyUserProfileViewController

-(void)hidePickerViewITems{
    
    [self.viewPickerContainer setHidden:YES];
    [self.scrollViewUsing setHidden:NO];
    
    
}
- (IBAction)btnHEightPickerCancelTapped:(id)sender
{
    
    [self hidePickerViewITems];
    
    
}


- (IBAction)btnHeightSelectedDoneTapped:(id)sender {
    
    [self hidePickerViewITems];
    
    self.hasEditingAnyField = YES;
    
    
    if (self.isSelectingHeight){
        int feetIndex = [self.heightPickerView selectedRowInComponent:0];
        int inchesIndex = [self.heightPickerView selectedRowInComponent:1];
        
        
        NSString * finalSelectedHeight = [NSString stringWithFormat:@"%@%@",[self.heightFeets objectAtIndex:feetIndex],[self.heightInches objectAtIndex:inchesIndex]];
        
        //self.txtHeight.txtView.text = finalSelectedHeight;

        self.heightSelected = [finalSelectedHeight stringByReplacingOccurrencesOfString:@"'" withString:@"."];
        
        self.heightSelected = [self.heightSelected stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        

        finalSelectedHeight = [NSString stringWithFormat:@"Height ( %@ )",finalSelectedHeight];
        
        self.lblHeight.text = finalSelectedHeight;
        
        

    }
    else {
        
        NSString * finalSelectedHeight = [NSString stringWithFormat:@"%@",[self.weightsArray objectAtIndex:[self.heightPickerView selectedRowInComponent:0]]];
        
        //self.txtWeight.txtView.text = finalSelectedHeight;

        self.weightSelected = [finalSelectedHeight stringByReplacingOccurrencesOfString:@" lb" withString:@""];
        NSLog(@"%@",self.weightSelected);
        self.lblWeight.text = [NSString stringWithFormat:@"Weight ( %@ )",finalSelectedHeight];;
        
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

- (IBAction)btnHeightTapped:(id)sender {
    
    self.isSelectingHeight = YES;
    
    [self.scrollViewUsing setHidden:YES];
    [self.viewPickerContainer setHidden:NO];
    
    [self.view endEditing:YES];
    self.lblSelectHeight.text = @"Select Height";
    
    [self.heightPickerView reloadAllComponents];
    
   // self.txtHeight.txtView.text = finalSelectedHeight;
    
    
    
    
}

- (IBAction)btnWeightTapped:(id)sender {
    
    self.isSelectingHeight = NO;
    
    [self.scrollViewUsing setHidden:YES];
    [self.viewPickerContainer setHidden:NO];
    
    [self.view endEditing:YES];
    self.lblSelectHeight.text = @"Select Weight";
    
    [self.heightPickerView reloadAllComponents];
    
    // self.txtHeight.txtView.text = finalSelectedHeight;
    
    
    
    
}


-(void)addingTextFieldCancelButtonTapped{
    [self.addingTextView setHidden:YES];
    [self.view sendSubviewToBack:self.addingTextView];
    
    [self.view endEditing:YES];
    
    self.changingTheName = NO;
    self.changingThePosition = NO;
    self.changingTheSchool = NO;
    self.changingTheBioDetails = NO;
    self.changingYouTubeOne = NO;
    self.changingYouTubeTwo = NO;
    
}

-(void)addingTextFieldOkButtonTapped{
    
    [self.view endEditing:YES];
    
    self.hasEditingAnyField = YES;
    
    if (self.changingTheName) {
        
        self.lblMyName.text = self.addingTextView.txtBoxEntering.text;
        self.lblMyName2.text = self.addingTextView.txtBoxEntering.text;
    
        self.changingTheName = NO;
        
    }
    else if(self.changingThePosition){
        
        self.lblPosition.text = self.addingTextView.txtBoxEntering.text;
        self.lblPosition2.text = self.addingTextView.txtBoxEntering.text;
        self.changingThePosition = NO;
        
        
    }
    else if(self.changingTheSchool){
        
        self.lblSchool.text = self.addingTextView.txtBoxEntering.text;
        self.lblSchool.text = self.addingTextView.txtBoxEntering.text;
        self.changingTheSchool = NO;
        
        
    }
    else if(self.changingTheBioDetails){
        
        self.lblBio.text = self.addingTextView.txtBoxEntering.text;
        self.lblBio.text = self.addingTextView.txtBoxEntering.text;
        self.changingTheBioDetails = NO;
        
        
    }
    else if(self.changingYouTubeOne){
        
        self.lblYouTubeOne.text = self.addingTextView.txtBoxEntering.text;
        self.lblYouTubeOne.text = self.addingTextView.txtBoxEntering.text;
        self.changingYouTubeOne = NO;
        
        
    }
    else if(self.changingYouTubeTwo){
        
        self.lblYouTubeTwo.text = self.addingTextView.txtBoxEntering.text;
        self.lblYouTubeTwo.text = self.addingTextView.txtBoxEntering.text;
        self.changingYouTubeTwo  = NO;
        
        
    }
    
    
    [self.addingTextView setHidden:YES];
    [self.view sendSubviewToBack:self.addingTextView];
    

}


-(AddingTextViewControl *)addingTextView{
    
    if (!_addingTextView) {
        
        _addingTextView = (AddingTextViewControl *)
        [self.view addSubViewWithContainerView:self.view
                               andEnteringView:_addingTextView
                                   withNibName:@"AddingTextViewControl"];
        
        [_addingTextView.btnOk addTarget:self action:@selector(addingTextFieldOkButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        
        [_addingTextView.btnCancel addTarget:self action:@selector(addingTextFieldCancelButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        
        
    }

    return _addingTextView;
    
}
- (IBAction)btnNameOptionToOpenTap:(UIButton *)sender {
    _addingTextView.txtBoxEntering.text = @"";
    
    
    [self.addingTextView setHidden:NO];
    [self.view bringSubviewToFront:self.addingTextView];
    
    
    self.changingTheName = YES;
    
    
}
- (IBAction)btnSelectPositionTapped:(id)sender {
    
    _addingTextView.txtBoxEntering.text = @"";
    
    
    [self.addingTextView setHidden:NO];
    [self.view bringSubviewToFront:self.addingTextView];
    
    
    self.changingThePosition = YES;
    
    
}


- (IBAction)btnSchoolNameTapped:(id)sender {
    _addingTextView.txtBoxEntering.text = @"";
    
    [self.addingTextView setHidden:NO];
    [self.view bringSubviewToFront:self.addingTextView];
    
    
    self.changingTheSchool = YES;
    
    
    
}

- (IBAction)btnBioTapped:(id)sender {
    _addingTextView.txtBoxEntering.text = @"";
    
    
    [self.addingTextView setHidden:NO];
    [self.view bringSubviewToFront:self.addingTextView];
    
    
    self.changingTheBioDetails = YES;
    
}

- (IBAction)btnYouTubeOneTapped:(id)sender {
    _addingTextView.txtBoxEntering.text = @"";
    
    
    [self.addingTextView setHidden:NO];
    [self.view bringSubviewToFront:self.addingTextView];
    
    
    self.changingYouTubeOne = YES;
    
}
- (IBAction)btnYouTubeTwoTapped:(id)sender {
    _addingTextView.txtBoxEntering.text = @"";
    
    
    [self.addingTextView setHidden:NO];
    [self.view bringSubviewToFront:self.addingTextView];
    
    
    self.changingYouTubeTwo = YES;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showLoader];
    
    [self.viewProfileImageButtonContainer roundTheView];
    
    [self.btnUserProfileButton roundTheView];
    //226 184
    
    self.viewBasicInfoContainer.layer.cornerRadius = 10;
    
    self.viewBioContainer.layer.cornerRadius = 10;
    
    self.viewVideoContainer.layer.cornerRadius = 10;
    
    //
    self.lblBio.text = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incidid";
    
    
    self.btnUpdate.layer.cornerRadius = 5;
    
    
    
    self.heightFeets = @[@"1'",@"2'",@"3'",@"4'",@"5'",@"6'",@"7'",@"8'"];
    
    self.heightInches = @[@"1\"",@"2\"",@"3\"",@"4\"",@"5\"",@"6\"",@"7\"",@"8\"",@"9\"",@"10\"",@"11\""];
    self.weightsArray = [NSMutableArray new];
    
    for (int i = 50;i<1451;i++)
    {
        [self.weightsArray addObject:[NSString stringWithFormat:@"%d lb",i]];
    }
    
    
    
    //733
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    [User
     callGetUserProfileById:self.myJid WithComplitionHandler:^(id result) {
    
         [self hideLoader];
         
         self.lblMyName.text = [[[result objectForKey:@"Account"] firstObject] objectForKey:@"Name"];
         self.lblMyName2.text = [[[result objectForKey:@"Account"] firstObject] objectForKey:@"Name"];
         
         self.lblPosition.text = [[[result objectForKey:@"Account"] firstObject] objectForKey:@"Position"];
         self.lblPosition2.text = [[[result objectForKey:@"Account"] firstObject] objectForKey:@"Position"];
         
         self.lblSchool.text = [[[result objectForKey:@"Account"] firstObject] objectForKey:@"School"];
         
         self.lblBio.text =  [[[result objectForKey:@"Account"] firstObject] objectForKey:@"Bio"];
         
         NSString * heightShowing = [[[result objectForKey:@"Account"] firstObject] objectForKey:@"Height"];
         if (![heightShowing isKindOfClass:[NSString class]]) {
             
             //  5' 7" )
             heightShowing = [NSString stringWithFormat:@"%.02f",[heightShowing doubleValue]];
             
             self.heightSelected = heightShowing;
             
         }
         heightShowing = [heightShowing stringByReplacingOccurrencesOfString:@"." withString:@"\""];
         heightShowing = [heightShowing stringByAppendingString:@"'"];
         
         heightShowing = [NSString stringWithFormat:@"Height ( %@ )",heightShowing];
         
         self.lblHeight.text = heightShowing;
         
         NSString * weight = [[[result objectForKey:@"Account"] firstObject] objectForKey:@"Weight"];
         
         if (![weight isKindOfClass:[NSString class]]) {
             
             weight = [NSString stringWithFormat:@"%d",[weight intValue]];
             
             self.weightSelected = weight;
             
         }
         //   ( 150 lb )

         
         weight = [weight stringByAppendingString:@" lb"];
        

         
         
         self.lblWeight.text = [NSString stringWithFormat:@"Weight ( %@ )",weight];;
         

         
         NSLog(@"");
         
        
    } withFailueHandler:^{
       
        [self hideLoader];
        [self showAlert:@"" message:@"Error while laoding data"];
    }];
    
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect: self.viewSchoolContainer.bounds byRoundingCorners: UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii: (CGSize){10.0, 10.}].CGPath;
    
    self.viewSchoolContainer.layer.mask = maskLayer;
    
    
    maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect: self.viewBioContainer.bounds byRoundingCorners: UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii: (CGSize){10.0, 10.}].CGPath;
    
    self.viewBioContainer.layer.mask = maskLayer;
    
    //226 120
    
    maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect: self.viewVideoContainer.bounds byRoundingCorners: UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii: (CGSize){10.0, 10.}].CGPath;
    
    self.viewVideoContainer.layer.mask = maskLayer;
    
    
    
    [self.scrollViewUsing setContentSize:CGSizeMake(self.view.frame.size.width, 773)];
    
    //
}


- (IBAction)btnUpdateProfileTapped:(id)sender {
    
    if (!self.hasEditingAnyField) {
    
        return;
    }
    NSMutableDictionary * paramDictionary = [NSMutableDictionary new] ;
    
    NSMutableDictionary * tmpDictionary = [NSMutableDictionary new];
    
    [tmpDictionary setObject:self.myJid forKey:@"ID"];
    [tmpDictionary setObject:self.lblMyName.text forKey:@"Name"];
    [tmpDictionary setObject:self.myEmail forKey:@"Email"];
    [tmpDictionary setObject:self.myAccountType forKey:@"Account_Type"];
    [tmpDictionary setObject:self.heightSelected forKey:@"Height"];
    [tmpDictionary setObject:self.weightSelected forKey:@"Weight"];
    
    [tmpDictionary setObject:self.lblPosition.text forKey:@"Position"];
    
    [tmpDictionary setObject:self.lblSchool.text forKey:@"School"];
    [tmpDictionary setObject:self.lblBio.text forKey:@"Bio"];
    [tmpDictionary setObject:self.myZipCode forKey:@"ZipCode"];
    
    [paramDictionary setObject:@[tmpDictionary] forKey:@"Account"];
    
    [paramDictionary setObject:@[] forKey:@"Specilities"];
  
    
    NSMutableArray * videosArray = [NSMutableArray new];
    
    if ([self.lblYouTubeOne.text length] > 0) {
        [videosArray addObject:
         @{@"Url":self.lblYouTubeOne.text}];
        
    }
    
    if ([self.lblYouTubeTwo.text length] > 0) {
     
        [videosArray addObject:
         @{@"Url":self.lblYouTubeTwo.text}];
        
        
    }

    [paramDictionary setObject:videosArray forKey:@"Videos"];
    [paramDictionary setObject:@[] forKey:@"Locations"];
    
    
    
    [self showLoader];
    
    [User callUpdateProfileWithParams:paramDictionary
                withComplitionHandler:^(id result) {
        
                    [self hideLoader];
                    
                    
    } withFailueHandler:^{
        
    } withAlreadyExistsHandler:^(id result) {
        
    }];
    
    
    
    
    
}

@end
