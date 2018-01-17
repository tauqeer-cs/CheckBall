//
//  TrainerDashboardViewController.m
//  CheckBall
//
//  Created by Tauqeer on 04/12/2017.
//  Copyright © 2017 plego. All rights reserved.
//

#import "TrainerDashboardViewController.h"
#import "DashboardPlayerListCollectionCell.h"
#import "OptionsView.h"
#import "User.h"
#import <CoreLocation/CoreLocation.h>

@interface TrainerDashboardViewController ()<CLLocationManagerDelegate>{
    CLLocation *currentLocation;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray * dataSource;

@property (nonatomic,strong) OptionsView * optionView;

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@property (nonatomic) BOOL isProfileSmallSettingViewOpened;
@property (weak, nonatomic) IBOutlet UILabel *lblName;

@property (nonatomic, strong) CLLocationManager *locationManager;



@end

@implementation TrainerDashboardViewController

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

    //DashboardPlayerListCollectionCell.h
    [self.collectionView registerNib:[UINib nibWithNibName:@"DashboardPlayerListCollectionCell" bundle:nil]
          forCellWithReuseIdentifier:@"cellPlayer"];

    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    
    self.dataSource = [NSMutableArray new];

    //segueMyProfile
    
    
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(profilePictureTapped)];
    [self.profileImageView addGestureRecognizer:singleFingerTap];
    
    
    self.lblName.text  = self.myName;
    
    
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = 10;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if([CLLocationManager locationServicesEnabled] == NO){
        NSLog(@"Your location service is not enabled, So go to Settings > Location Services");
    }
    else{
        NSLog(@"Your location service is enabled");
    }
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    

    
}



- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    currentLocation = [locations lastObject];
    if (currentLocation != nil){
        NSLog(@"The latitude value is - %@",[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude]);
        NSLog(@"The logitude value is - %@",[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude]);
    }
  
 
[self.locationManager stopUpdatingLocation];
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
    
    [self showLoader];
    
    
    
    [User callGetTrainersWithZipCode:self.myZipCode
               WithComplitionHandler:^(id result) {
                   
                   [self hideLoader];
                   
                   self.dataSource = result;
                   [self.collectionView reloadData];
                   
                   
                   
                   
               } withFailueHandler:^{
                   
                   [self hideLoader];
                   [self showAlert:@"" message:@"Error while loading data."];
                   
               }];
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section{
    
    return [self.dataSource count];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DashboardPlayerListCollectionCell *currentCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellPlayer" forIndexPath:indexPath];
    
    
    [currentCell updateWithDate:[self.dataSource objectAtIndex:indexPath.row]];
    
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



@end
