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
#import "User.h"
#import "MyTrainerProfileViewController.h"
#import "ChangePasswordViewController.h"

@interface PlayerDashboardViewController ()<UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray * dataSource;

@property (nonatomic,strong) OptionsView * optionView;

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@property (nonatomic) BOOL isProfileSmallSettingViewOpened;

@property (weak, nonatomic) IBOutlet UILabel *lblName;

@property (nonatomic,strong) id tmpObjectSelected;

@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@end

@implementation PlayerDashboardViewController

-(void)editProfileTapped{
    [self profilePictureTapped];
    
    
    [self performSegueWithIdentifier:@"segueMyProfile" sender:self];
    
    
    
    NSLog(@"Edit Profile Button Tapped");
}

-(void)changePAsswordTapped{
    
    [self profilePictureTapped];
 
    
    ChangePasswordViewController * destination = (ChangePasswordViewController *)[self viewControllerFromStoryBoard:@"SignUpStoryboard" withViewControllerName:@"ChangePasswordViewController"];
    
    [self showViewController:destination sender:self];
    

}


-(void)logoutTapped{
    [self profilePictureTapped];
    
    
    NSLog(@"LogOut Tapped");
    
    
    NSUserDefaults *currentUserDefault = [NSUserDefaults standardUserDefaults];
    [currentUserDefault setObject:nil forKey:@"isFirstTimeSignUp"];
    
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"SignUpStoryboard" bundle:nil];
    UIViewController *initViewController;
    initViewController = [storyBoard instantiateViewControllerWithIdentifier:@"ViewController"];
    self.sharedDelegate.window.rootViewController = initViewController;
    
    
    
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
    
    self.dontAutoHideKeyboard = NO;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //
    
    
    

    
    self.title = @"Dashboard";
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"DashboradTrainerListViewCell" bundle:nil]
          forCellWithReuseIdentifier:@"cellTrainer"];
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
        self.dataSource = [NSMutableArray new];
    

    [self.profileImageView setUserInteractionEnabled:YES];
    
    
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(profilePictureTapped)];
    [self.profileImageView addGestureRecognizer:singleFingerTap];
    
    self.lblName.text = self.myName;
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
    

    [FileManager loadProfileImage:self.profileImageView url:[baseImageLink stringByAppendingString:[NSString stringWithFormat:@"tmb%d.jpg",[self.myJid intValue]]]];
    
    
    
    
    
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    currentLocation = [locations lastObject];
    if (currentLocation != nil){
       
        self.sharedDelegate.currentLat = [[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude] floatValue];
        
        self.sharedDelegate.currentLong = [[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude] floatValue];
        
        
        
        
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:currentLocation.coordinate.latitude
                                             longitude:currentLocation.coordinate.longitude
                                                  zoom:11];
        
        [self.mapView setCamera:camera];
        
        [self.locationManager stopUpdatingLocation];
        
    }
    else {
        
        
    }
    
    

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
 
    if (!self.firstTimeDataHasBeenLoaded) {
        
        [self showLoader];
        
        self.firstTimeDataHasBeenLoaded = YES;
    }
    
    [User callGetPlayersWithZipCode:self.myZipCode
              WithComplitionHandler:^(id result) {
                  
                  NSLog(@"");
                  
                  
                  [self hideLoader];
                  self.dataSource = result;
                  
                  
                  [self.collectionView reloadData];
                  [self.mapView clear];
                  
                  for (id currentItem in result) {
                      
                      id currentLocaton  = [currentItem objectForKey:@"Locations"];
                      
                      if ([currentLocaton count]  > 0) {
                          
                          
                          for (id innerItem in currentLocaton) {
                              
                              float latShowing = [[innerItem objectForKey:@"latitude"] floatValue];
                              float longShowing = [[innerItem objectForKey:@"longitude"] floatValue];

                            CLLocationCoordinate2D position = CLLocationCoordinate2DMake(latShowing, longShowing);
                              
                              GMSMarker *marker = [GMSMarker markerWithPosition:position];
                              marker.map = self.mapView;
                              
                              
                              
                              
                          }
                      }
                  }
                  
              } withFailueHandler:^{
                  
                  [self hideLoader];
                  [self showAlert:@"" message:@"Error while loading data."];
                  
                  
                  
              }];
    
   // [self.optionView setHidden:NO];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section{
    
    return [self.dataSource count];
    
}

-(void)selectedItem:(UITapGestureRecognizer *)indexSelected{
    
    int tag = (int)indexSelected.view.tag;
    
    id currentItem = [self.dataSource objectAtIndex:tag];
    
    self.tmpObjectSelected = currentItem;
    
    
    [self performSegueWithIdentifier:@"segueShowProfileDetail" sender:self];
    
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DashboradTrainerListViewCell *currentCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellTrainer" forIndexPath:indexPath];
    
    
    [currentCell updateWithDate:[self.dataSource objectAtIndex:indexPath.row]];
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(selectedItem:)];
    currentCell.contentView.tag = indexPath.row;
    [currentCell.contentView addGestureRecognizer:singleFingerTap];
    return currentCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.collectionView.frame.size.width, 55);
}
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    
    
    
    
    NSLog(@"");
    
    
    
}

-(void)viewDidDisappear:(BOOL)animated{
    if (self.isProfileSmallSettingViewOpened) {
        
        [self.optionView setHidden:YES];
        
    }
    
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.destinationViewController isKindOfClass:[MyTrainerProfileViewController class]]) {
        
        MyTrainerProfileViewController * destination = segue.destinationViewController;
        destination.comingFromListing  = YES;
        destination.idCalling = [[self.tmpObjectSelected objectForKey:@"id"] intValue];
       
        
    }
}


@end
