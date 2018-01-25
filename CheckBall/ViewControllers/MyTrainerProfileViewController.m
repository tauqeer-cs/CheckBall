//
//  MyTrainerProfileViewController.m
//  CheckBall
//
//  Created by Shehzad Bilal on 15/01/2018.
//  Copyright © 2018 plego. All rights reserved.
//

#import "MyTrainerProfileViewController.h"
#import "User.h"
#import "MyTrainerProfileViewController.h"
#import "Specialities.h"
#import "DYAlertPickView.h"


@interface MyTrainerProfileViewController ()<SelectMapLocationViewCellDelegate,GMSMapViewDelegate,DYAlertPickViewDataSource, DYAlertPickViewDelegate>



@property (nonatomic) int indexAddingOfLocation;

@property (nonatomic,strong) NSString * firstLocationLat;
@property (nonatomic,strong) NSString * firstLocationLong;
@property (nonatomic,strong) NSString * firstLocationAddres;

@property (nonatomic,strong) NSString * secondLocationLat;
@property (nonatomic,strong) NSString * secondLocationLong;
@property (nonatomic,strong) NSString * secondLocationAddres;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress1;

@property (weak, nonatomic) IBOutlet UILabel *lblAddress2;

@property (nonatomic,strong) NSArray * mySpeciality;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *allItemsToRemove;
@property (weak, nonatomic) IBOutlet UIView *trainingLocationContainer;

@property (nonatomic) BOOL viewDidAppearHAsAlreadyBeenCAlledMan;
@property (weak, nonatomic) IBOutlet GMSMapView *mapViewTraines;
@property (weak, nonatomic) IBOutlet UILabel *lblTrainerSpeciality;

@property (nonatomic,strong) NSMutableArray * specalitesList;
@property (nonatomic,strong) NSMutableArray * selectedSpecialites;


@property (weak, nonatomic) IBOutlet UIView *viewNoMapAvailableContainer;
@end

@implementation MyTrainerProfileViewController
GMSCameraPosition *camera2;
GMSMapView *mapView2;

-(NSMutableArray *)selectedSpecialites{
    
    if (!_selectedSpecialites) {
        
        _selectedSpecialites = [NSMutableArray new];
        
    }
    return _selectedSpecialites;
    
}
-(NSMutableArray *)specalitesList{
    
    
    if (!_specalitesList) {
        
        _specalitesList = [Specialities savedSpecialities];
        
        if ([_specalitesList count] == 0) {
            
            [Specialities callGetSpecialitesWithComplitionHandler:^(id result) {
            
                _specalitesList = [Specialities savedSpecialities];
                
                //reload the tableView
            } withFailueHandler:^{
                
            }];
            
        }
    }
    return _specalitesList;
}
- (void)viewDidLoad {
    // Do any additional setup after loading the view.
    if (self.comingFromListing) {
        
        self.title = @"Profile";
    }

    self.specalitesList;
    
    [self.scrollViewUsing setHidden:YES];
    [self.youTubePrayer setHidden:YES];

    
    [self.btnUserProfileButton setImage:[UIImage imageNamed:@"gander-icon"] forState:UIControlStateNormal];
    
   
    if (self.comingFromListing) {
    [FileManager loadProfileImageToButton:self.btnUserProfileButton :[baseImageLink stringByAppendingString:[NSString stringWithFormat:@"%d.jpg",self.idCalling ]] loader:nil];
     
        self.hasImage = YES;
        
    }
    else
    [FileManager loadProfileImageToButton:self.btnUserProfileButton :[baseImageLink stringByAppendingString:[NSString stringWithFormat:@"%d.jpg",[self.myJid intValue]]] loader:nil];
    
    
    self.trainingLocationContainer = mapView2;
    
    
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
    
    self.heightInches = @[@"0\"",@"1\"",@"2\"",@"3\"",@"4\"",@"5\"",@"6\"",@"7\"",@"8\"",@"9\"",@"10\"",@"11\""];
    self.weightsArray = [NSMutableArray new];
    
    for (int i = 50;i<1451;i++)
    {
        [self.weightsArray addObject:[NSString stringWithFormat:@"%d lb",i]];
    }
    
    if (self.comingFromListing) {
        for (UIView * currentView in self.allItemsToRemove)
        {
            
            [currentView removeFromSuperview];
            
        }
        
    }

    self.btnCOnnect.layer.cornerRadius = 5;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)setLocationTextForEditor:(User *)result {
    id locationObject = result.locations;
    int i = 0;
    if (locationObject) {
        for (Location * currentItem in locationObject) {
            
            if (i == 0) {
                self.lblAddress1.text = currentItem.locationDescription;
            }
            else if (i == 1){
                self.lblAddress2.text = currentItem.locationDescription;
            }
            i++;
        }
    }
}

- (void)setLocationMapForUser:(User *)result {
    BOOL cameriaHasBeenSet = NO;
    
    if ([result.locations count] == 0) {
        
        
///        [self.mapViewTraines setHidden:YES];
        
        [self.viewNoMapAvailableContainer setHidden:NO];
        
    }
    for (Location * currentItemDoing in result.locations)
    {
        float latShowing =  currentItemDoing.userLatitude;
        float longShowing = currentItemDoing.userLongitude;
        if (!cameriaHasBeenSet) {
            GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latShowing
                                                                    longitude:longShowing
                                                                         zoom:11];
            [self.mapViewTraines setCamera:camera];
        }
        CLLocationCoordinate2D position = CLLocationCoordinate2DMake(latShowing, longShowing);
        GMSMarker *marker = [GMSMarker markerWithPosition:position];
        marker.map = self.mapViewTraines;
        cameriaHasBeenSet = YES;
    }
}



-(void)viewDidAppear:(BOOL)animated{
    
    if (self.viewDidAppearHAsAlreadyBeenCAlledMan) {
        
        return;
        
    }

    if (self.comingFromListing) {
        
        
        

        
        [User
         callGetUserProfileById:[NSString stringWithFormat:@"%d",self.idCalling] WithComplitionHandler:^(User * result) {
             
            
             
             self.currentUserShowing = result;
             
             [self enterBasicInfoToLabler:result];
             
             self.lblTrainerSpeciality.text =  [Specialities mySpecialitesStringFromArray:result.specialites];
             self.mySpeciality = result.specialites;
             
             [self setLocationMapForUser:result];
             
             
             [self hideLoader];
             
             
             self.hasImage = result.hasImage;
                 
             [self setYoutubePlaerForUer:result];
             
         
             
             [self.scrollViewUsing setHidden:NO];
             
             
         } withFailueHandler:^{
             
             [self hideLoader];
             [self showAlert:@"" message:@"Error while laoding data"];
         }];
        
        
    }
    else {
        
    
    [User
     callGetUserProfileById:self.myJid WithComplitionHandler:^(User * result) {
         
         self.currentUserShowing = result;
         [self hideLoader];
         [self enterBasicInfoToLabler:result];
         self.lblTrainerSpeciality.text =  [Specialities mySpecialitesStringFromArray:result.specialites];
         self.mySpeciality = result.specialites;
         self.hasImage = result.hasImage;
         [self setLocationTextForEditor:result];
        [self setVideLabelsForEditor:result];
         [self.scrollViewUsing setHidden:NO];
         
     } withFailueHandler:^{
         
         [self hideLoader];
         [self showAlert:@"" message:@"Error while laoding data"];
     }];
    
    }
    
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
    
    if(self.comingFromListing){
        
        [self.scrollViewUsing setContentSize:CGSizeMake(self.view.frame.size.width, 1100)];
        
    }
    else {
        [self.scrollViewUsing setContentSize:CGSizeMake(self.view.frame.size.width, 893)];
        
    }
    
    
        self.viewDidAppearHAsAlreadyBeenCAlledMan = YES;
    
}


- (IBAction)btnAddLocationOneTaped:(id)sender {
    
    SelectMapLocationViewController * destination = (SelectMapLocationViewController *)[self viewControllerFromStoryBoard:@"MainTrainer" withViewControllerName:@"SelectMapLocationViewController"];
    destination.delegate = self;
    
    self.indexAddingOfLocation = 0;
    [self.navigationController showViewController:destination sender:self];
    
}

- (IBAction)btnAddLocation2Tapped:(id)sender {
    
    
    SelectMapLocationViewController * destination = (SelectMapLocationViewController *)[self viewControllerFromStoryBoard:@"MainTrainer" withViewControllerName:@"SelectMapLocationViewController"];
    destination.delegate = self;
    
    self.indexAddingOfLocation = 1;
    [self.navigationController showViewController:destination sender:self];
    
}

-(void)locationSelectedWithLat:(NSString *)lat withLong:(NSString *)longit withAddress:(NSString *)addres{
    
 
    if (self.indexAddingOfLocation == 1) {
        Location * newLocation = [Location new];
        newLocation.locationDescription = addres;
        newLocation.userLatitude = [lat floatValue];
        newLocation.userLongitude = [longit floatValue];
        
        
        
        self.lblAddress2.text = addres;
        
        self.hasEditingAnyField = YES;
        
        if ([self.currentUserShowing.locations count] == 0) {
            
            [self.currentUserShowing.locations addObject:newLocation];
            
        }
        else if ([self.currentUserShowing.locations count] == 1) {
            
            [self.currentUserShowing.locations addObject:newLocation];
            
        }
        else
        {
            [self.currentUserShowing.locations replaceObjectAtIndex:1 withObject:newLocation];
            
        }
        
    }
    else {
        
        Location * newLocation = [Location new];
        newLocation.locationDescription = addres;
        newLocation.userLatitude = [lat floatValue];
        newLocation.userLongitude = [longit floatValue];
        
        
        if ([self.currentUserShowing.locations count] == 0) {
            
            [self.currentUserShowing.locations addObject:newLocation];
            
        }
        else
        {

            [self.currentUserShowing.locations replaceObjectAtIndex:0 withObject:newLocation];
            
            
        }
        
        self.lblAddress1.text = addres;
        
        self.hasEditingAnyField = YES;
    }
}

- (IBAction)btnUpdateProfileTapped:(id)sender {
    
    if (!self.hasEditingAnyField) {
        
        return;
    }
    
    
    
    NSMutableDictionary * paramDictionary = [self.currentUserShowing makeParam];;
    
  
    
    [self showLoader];
    
    [User callUpdateProfileWithParams:paramDictionary
                withComplitionHandler:^(id result) {
                    
                    [self hideLoader];
                    
                    
                } withFailueHandler:^{
                    
                } withAlreadyExistsHandler:^(id result) {
                    
                }];
    
    
    
    
    
}


- (IBAction)btnShowTrainingSpecialitesTapped:(UIButton *)sender {
    
    
    
    self.selectedSpecialites =  [NSMutableArray new];;
    
    
    DYAlertPickView *picker = [[DYAlertPickView alloc] initWithHeaderTitle:@"Select Training Specialites" cancelButtonTitle:@"Cancel" confirmButtonTitle:@"Confirm" switchButtonTitle:@""];
    picker.delegate = self;
    picker.dataSource = self;
    picker.allowMultipleSelection = YES;
    [picker showAndSelectedIndex:0];
    
    
    
    [self.selectedSpecialites addObject:[self.specalitesList objectAtIndex:0]];
    

    
}
-(void)didEndSelected{
    
    self.currentUserShowing.specialites = self.selectedSpecialites;
    
 
    NSString  * stringToShow = [Specialities mySpecialitesStringFromArray:self.currentUserShowing.specialites];
    
    self.lblTrainerSpeciality.text = stringToShow;
    
    
            self.hasEditingAnyField = YES;
    
    NSLog(@"");
    
}
- (void)pickerview:(DYAlertPickView *)pickerView
didConfirmWithItemAtRow:(NSInteger)row withIsSelected:(BOOL)isSelected{
    
    NSLog(@"");
    
    

        if (isSelected) {
        
            [self.selectedSpecialites addObject:[self.specalitesList objectAtIndex:row]];
            
            
            
        
        }
        else {
            
            [self.selectedSpecialites removeObject:[self.specalitesList objectAtIndex:row]];
            
            
        }
        
    NSLog(@"");
    
    
    
    
    
    
    
}

- (NSAttributedString *)pickerview:(DYAlertPickView *)pickerView
                       titleForRow:(NSInteger)row{
    
    Specialities * currentItem = [self.specalitesList objectAtIndex:row];
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:currentItem.name];
    return str;
}


- (NSInteger)numberOfRowsInPickerview:(DYAlertPickView *)pickerView {
    return [self.specalitesList count];
    
}

- (void)pickerviewDidClickCancelButton:(DYAlertPickView *)pickerView {
    NSLog(@"Canceled");
}



@end
