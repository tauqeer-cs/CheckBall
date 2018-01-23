//
//  SelectMapLocationViewController.m
//  CheckBall
//
//  Created by Shehzad Bilal on 18/01/2018.
//  Copyright © 2018 plego. All rights reserved.
//

#import "SelectMapLocationViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>



@interface SelectMapLocationViewController ()<CLLocationManagerDelegate,GMSMapViewDelegate>{
    CLLocation *currentLocation;
}

@property (nonatomic, strong) CLLocationManager *locationManager;



@end

@implementation SelectMapLocationViewController
GMSCameraPosition *camera;
GMSMapView *mapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    

    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

    self.title = @"Drop Pin";
    
}

-(void)doneButtonTapped{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)mapView:(GMSMapView *)mapView
didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate{
    
    NSLog(@"");   [mapView clear];
    
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude);
    GMSMarker *marker = [GMSMarker markerWithPosition:position];
    marker.map = mapView;
    
    [self showLoader];
    
    GMSReverseGeocodeCallback handler = ^(GMSReverseGeocodeResponse *response, NSError *error) {
        GMSAddress *address = response.firstResult;
        
        [self hideLoader];
        
        if (address) {
            NSLog(@"Geocoder result: %@", address);
            
            
            NSString * addresToSend  = [address.lines componentsJoinedByString:@","];
            
;
            
           
            [self.delegate locationSelectedWithLat:[NSString stringWithFormat:@"%.8f", coordinate.latitude] withLong:[NSString stringWithFormat:@"%.8f", coordinate.longitude]
                                       withAddress:addresToSend];
            
            
            [self hideLoader];
            
                self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneButtonTapped)];
            
      
        } else {
            NSLog(@"Could not reverse geocode point (%f,%f): %@",
                  coordinate.latitude, coordinate.longitude, error);
            
            [self hideLoader];
            
        }
    };
    
      GMSGeocoder *geocoder_;
    geocoder_ = [[GMSGeocoder alloc] init];

    [geocoder_ reverseGeocodeCoordinate:coordinate completionHandler:handler];
    
    
    
    //[geocoder_ reverseGeocodeCoordinate:coordinate completionHandler:nil];
    
    
    return;
    
    
}

- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    NSLog(@"You tapped at %f,%f", coordinate.latitude, coordinate.longitude);
}
- (void)loadView {
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    camera = [GMSCameraPosition cameraWithLatitude:self.sharedDelegate.currentLat
                                                            longitude:self.sharedDelegate.currentLong
                                                                 zoom:9];
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.myLocationEnabled = YES;
    mapView.delegate = self;
    
    
    self.view = mapView;
    
    // Creates a marker in the center of the map.
   // GMSMarker *marker = [[GMSMarker alloc] init];
  //  marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
  //  marker.title = @"Sydney";
  //  marker.snippet = @"Australia";
  //  marker.map = mapView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    currentLocation = [locations lastObject];
    
    if (currentLocation != nil){
        NSLog(@"The latitude value is - %@",[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude]);
        NSLog(@"The logitude value is - %@",[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude]);
    }
    else {
        
        //self.mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
        

    }
    
    
    [self.locationManager stopUpdatingLocation];
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
