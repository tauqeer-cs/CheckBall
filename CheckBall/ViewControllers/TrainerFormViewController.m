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

@end

@implementation TrainerFormViewController
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



//,

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.trainingList =  [NSMutableArray new];

    
    self.selectedArray = [NSMutableArray new];
    
    

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
    
    
    [User callGetSpecialitesWithComplitionHandler:^(id result) {
        
        
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
    

        [self.finalSelectedItems addObject:currentItemToAdd];
        
        
        NSLog(@"%@",self.finalSelectedItems);
        
    }
    else {
        [cellItem.checkImage setImage:[UIImage imageNamed:@"unCheckedButton"]];
        [self.selectedArray replaceObjectAtIndex:indexPath.row withObject:@"0"];
        
        [self.finalSelectedItems removeObject:currentItemToAdd];
        NSLog(@"%@",self.finalSelectedItems);
        
        
        
        
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
