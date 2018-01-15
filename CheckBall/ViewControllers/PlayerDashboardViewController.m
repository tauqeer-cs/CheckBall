//
//  PlayerDashboardViewController.m
//  CheckBall
//
//  Created by Tauqeer on 04/12/2017.
//  Copyright © 2017 plego. All rights reserved.
//

#import "PlayerDashboardViewController.h"
#import "DashboradTrainerListViewCell.h"
#import "OptionsView.h"


@interface PlayerDashboardViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray * dataSource;

@property (nonatomic,strong) OptionsView * optionView;

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@property (nonatomic) BOOL isProfileSmallSettingViewOpened;


@end

@implementation PlayerDashboardViewController

-(void)editProfileTapped{
    [self profilePictureTapped];
    
    
    [self performSegueWithIdentifier:@"segueMyProfile" sender:self];
    
    
    
    NSLog(@"Edit Profile Button Tapped");
}

-(void)changePAsswordTapped{
    
    [self profilePictureTapped];
    
    NSLog(@"Change Password Tapped");
}


-(void)logoutTapped{
    [self profilePictureTapped];
    
    
    NSLog(@"LogOut Tapped");
    
}
-(OptionsView *)optionView{
    
    
    if (!_optionView) {
    
        _optionView = (OptionsView *)[self.view getViewFromNibName:@"OptionsView" withWidth:190 withHeight:120];
        
        
        [_optionView setFrame:CGRectMake(self.profileImageView.frame.origin.x-165, self.profileImageView.frame.origin.y+self.profileImageView.frame.size.height+65, _optionView.frame.size.width, _optionView.frame.size.height)];
        
        [self.view addSubview:_optionView];
        
        
        
        CAShapeLayer * maskLayer = [CAShapeLayer layer];
        maskLayer.path = [UIBezierPath bezierPathWithRoundedRect: _optionView.bounds
                                               byRoundingCorners: UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii: (CGSize){10.0, 10.}].CGPath;
        
        //self.firstContainer.layer.mask = maskLayer;
        
        
        _optionView.layer.mask = maskLayer;
        
        
        _optionView.firstContainer.userInteractionEnabled = YES;
        
        
        UITapGestureRecognizer *singleFingerTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(editProfileTapped)];
        [_optionView.firstContainer addGestureRecognizer:singleFingerTap];
        
        
        
        singleFingerTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(changePAsswordTapped)];
        [_optionView.secondContainer addGestureRecognizer:singleFingerTap];
        
        _optionView.secondContainer.userInteractionEnabled = YES;
        
        singleFingerTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(changePAsswordTapped)];
        [_optionView.secondContainer addGestureRecognizer:singleFingerTap];
        
        
        _optionView.thirdContainer.userInteractionEnabled = YES;
        
        singleFingerTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(logoutTapped)];
        [_optionView.thirdContainer addGestureRecognizer:singleFingerTap];
        
        
        
        
    
    }
    return _optionView;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //
    
    self.title = @"Dashboard";
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"DashboradTrainerListViewCell" bundle:nil]
          forCellWithReuseIdentifier:@"cellTrainer"];
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
        self.dataSource = [NSMutableArray new];
    
    [self.dataSource addObject:@"Test"];
    [self.dataSource addObject:@"Test"];
    
    
    [self.profileImageView setUserInteractionEnabled:YES];
    
    
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(profilePictureTapped)];
    [self.profileImageView addGestureRecognizer:singleFingerTap];
    
    
}

-(void)profilePictureTapped{

    if (self.isProfileSmallSettingViewOpened) {
        
        self.isProfileSmallSettingViewOpened = NO;
        [self.optionView setHidden:YES];
        
        
    }
    else {
        self.isProfileSmallSettingViewOpened = YES;
    [self.optionView setHidden:NO];
        
    }
    

    
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    [self.collectionView reloadData];
    
   // [self.optionView setHidden:NO];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section{
    
    return [self.dataSource count];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DashboradTrainerListViewCell *currentCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellTrainer" forIndexPath:indexPath];
    
    return currentCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.collectionView.frame.size.width, 55);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if (self.isProfileSmallSettingViewOpened) {
    
        [self.optionView setHidden:YES];
        
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
