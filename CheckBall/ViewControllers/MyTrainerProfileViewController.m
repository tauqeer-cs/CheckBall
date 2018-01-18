//
//  MyTrainerProfileViewController.m
//  CheckBall
//
//  Created by Shehzad Bilal on 15/01/2018.
//  Copyright © 2018 plego. All rights reserved.
//

#import "MyTrainerProfileViewController.h"
#import "User.h"
#import <GoogleMaps/GoogleMaps.h>


@interface MyTrainerProfileViewController ()<SelectMapLocationViewCellDelegate,GMSMapViewDelegate>

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

@end

@implementation MyTrainerProfileViewController
GMSCameraPosition *camera2;
GMSMapView *mapView2;

- (void)viewDidLoad {
    // Do any additional setup after loading the view.
    
    camera2 = [GMSCameraPosition cameraWithLatitude:self.sharedDelegate.currentLat
                                         longitude:self.sharedDelegate.currentLong
                                              zoom:9];
    mapView2 = [GMSMapView mapWithFrame:CGRectZero camera:camera2];
    mapView2.myLocationEnabled = YES;
    mapView2.delegate = self;
    
    
    self.trainingLocationContainer = mapView2;
    
    [self.scrollViewUsing setHidden:YES];
    
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
    
    if (self.comingFromListing) {
        for (UIView * currentView in self.allItemsToRemove)
        {
            
            [currentView removeFromSuperview];
            
        }
        
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

-(void)viewDidAppear:(BOOL)animated{
    
    
    
    if (self.comingFromListing) {
        
        
        

        
        [User
         callGetUserProfileById:[NSString stringWithFormat:@"%d",self.idCalling] WithComplitionHandler:^(id result) {
             
             [self hideLoader];
             
             self.mySpeciality = [result objectForKey:@"Specialites"];
             
             id videosList = [result objectForKey:@"Videos"];
             
             if ([videosList isKindOfClass:[NSArray class]] && [videosList count] > 0)
             {
                 
                 
                 for (id currentItem in videosList)
                 {
                     [self.allVideos addObject:[currentItem objectForKey:@"Url"]];
                 }
                 
             }
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
             weight = [weight stringByAppendingString:@" lb"];
             self.lblWeight.text = [NSString stringWithFormat:@"Weight ( %@ )",weight];;
             [self.scrollViewUsing setHidden:NO];
             
             
             if ([self.allVideos count] >= 2) {
                 
                 self.lblYouTubeOne.text = self.allVideos[0];
                 self.lblYouTubeTwo.text = self.allVideos[1];
                 
             }
             else if([self.allVideos count] >= 1){
                 
                 
                 self.lblYouTubeOne.text = self.allVideos[0];
                 
                 
             }
             
         } withFailueHandler:^{
             
             [self hideLoader];
             [self showAlert:@"" message:@"Error while laoding data"];
         }];
        
        
    }
    else {
        
    
    [User
     callGetUserProfileById:self.myJid WithComplitionHandler:^(id result) {
         
         [self hideLoader];
         
         self.mySpeciality = [result objectForKey:@"Specialites"];
         
         id videosList = [result objectForKey:@"Videos"];
         
         if ([videosList isKindOfClass:[NSArray class]] && [videosList count] > 0)
         {
             
             
             for (id currentItem in videosList)
             {
                 [self.allVideos addObject:[currentItem objectForKey:@"Url"]];
             }
             
         }
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
         weight = [weight stringByAppendingString:@" lb"];
         self.lblWeight.text = [NSString stringWithFormat:@"Weight ( %@ )",weight];;
         [self.scrollViewUsing setHidden:NO];
         
         
         if ([self.allVideos count] >= 2) {
             
             self.lblYouTubeOne.text = self.allVideos[0];
             self.lblYouTubeTwo.text = self.allVideos[1];
             
         }
         else if([self.allVideos count] >= 1){
             
             
             self.lblYouTubeOne.text = self.allVideos[0];
             
             
         }
         
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
    
    
    
    [self.scrollViewUsing setContentSize:CGSizeMake(self.view.frame.size.width, 893)];
    
    //
}


- (IBAction)btnAddLocationOneTaped:(id)sender {
    
    SelectMapLocationViewController * destination = (SelectMapLocationViewController *)[self viewControllerFromStoryBoard:@"MainTrainer" withViewControllerName:@"SelectMapLocationViewController"];
    destination.delegate = self;
    
    self.indexAddingOfLocation = 1;
    [self.navigationController showViewController:destination sender:self];
    
}

- (IBAction)btnAddLocation2Tapped:(id)sender {
    
    
    SelectMapLocationViewController * destination = (SelectMapLocationViewController *)[self viewControllerFromStoryBoard:@"MainTrainer" withViewControllerName:@"SelectMapLocationViewController"];
    destination.delegate = self;
    
    self.indexAddingOfLocation = 2;
    [self.navigationController showViewController:destination sender:self];
    
}

-(void)locationSelectedWithLat:(NSString *)lat withLong:(NSString *)longit withAddress:(NSString *)addres{
    
;
 
    if (self.indexAddingOfLocation == 1) {
        
        self.firstLocationLat = lat;
        self.firstLocationLong = longit;
        self.firstLocationAddres = addres;
        
        self.lblAddress1.text = addres;
        
        self.hasEditingAnyField = YES;
    }
    else {
        self.secondLocationLat = lat;
        self.secondLocationLong = longit;
        self.secondLocationAddres = addres;
        self.lblAddress2.text = addres;
        
                self.hasEditingAnyField = YES;
    }
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
    
    [paramDictionary setObject:self.mySpeciality forKey:@"Specilities"];
    
    
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
    
    if ([self.firstLocationLat length] == 0 && [self.firstLocationLat length] == 0) {
        [paramDictionary setObject:@[] forKey:@"Locations"];

    }
    else {
        
        NSMutableArray * tmpArray =  [NSMutableArray new];
        
        if ([self.firstLocationLat length] > 0) {
        
           [tmpArray addObject: @{@"Description":self.firstLocationAddres,@"Latitude":self.firstLocationLat,@"Longitude":self.firstLocationLong}];

            
            
        }

        
        if ([self.secondLocationAddres length] > 0) {
            
            [tmpArray addObject: @{@"Description":self.secondLocationAddres,@"Latitude":self.secondLocationLat,@"Longitude":self.secondLocationLong}];

        }

        
        [paramDictionary setObject:tmpArray forKey:@"Locations"];

        
        
    }
    
    
    
    [self showLoader];
    
    [User callUpdateProfileWithParams:paramDictionary
                withComplitionHandler:^(id result) {
                    
                    [self hideLoader];
                    
                    
                } withFailueHandler:^{
                    
                } withAlreadyExistsHandler:^(id result) {
                    
                }];
    
    
    
    
    
}



@end
