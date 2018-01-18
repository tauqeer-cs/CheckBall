#import "GeocoderViewController.h"

#import <GoogleMaps/GoogleMaps.h>

@implementation GeocoderViewController {
  GMSMapView *mapView_;
  GMSGeocoder *geocoder_;
  BOOL firstLocationUpdate_;
  GMSMarker *marker;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showNavigationBarWithTitle:@"DROP PIN" LeftButton:BACK_BUTTON RightButton:SEARCH_BUTTON];
    
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.868
                                             longitude:151.2086
                                                  zoom:12];
    
 
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.delegate = self;
    mapView_.settings.myLocationButton = YES;

    geocoder_ = [[GMSGeocoder alloc] init];

    self.view = mapView_;
    
    if(self.initialCoordinates.latitude) {
        camera = [GMSCameraPosition cameraWithLatitude:self.initialCoordinates.latitude
                                             longitude:self.initialCoordinates.longitude
                                                  zoom:12];
        mapView_.camera = camera;
        if(self.addpin) {
            [self mapView:mapView_ didLongPressAtCoordinate:self.initialCoordinates];
        }
    }
    
    // Ask for My Location data after the map has already been added to the UI.
    dispatch_async(dispatch_get_main_queue(), ^{
        mapView_.myLocationEnabled = YES;
    });
}

#pragma mark - KVO updates

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if (!firstLocationUpdate_) {
        // If the first location update has not yet been recieved, then jump to that
        // location.
        firstLocationUpdate_ = YES;
        CLLocation *location = [change objectForKey:NSKeyValueChangeNewKey];
        mapView_.camera = [GMSCameraPosition cameraWithTarget:location.coordinate
                                                         zoom:14];
    }
}

- (void)mapView:(GMSMapView *)mapView
    didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate {
  // On a long press, reverse geocode this location.
    [mapView_ clear];
  GMSReverseGeocodeCallback handler = ^(GMSReverseGeocodeResponse *response, NSError *error) {
    GMSAddress *address = response.firstResult;
    if (address) {
      NSLog(@"Geocoder result: %@", address);

      marker = [GMSMarker markerWithPosition:address.coordinate];

      marker.title = [[address lines] firstObject];
      if ([[address lines] count] > 1) {
        marker.snippet = [[address lines] objectAtIndex:1];
      }

      marker.appearAnimation = kGMSMarkerAnimationPop;
      marker.map = mapView_;
        if([self.parent respondsToSelector:@selector(updatelocation:Address:)]) {
            [self.parent updatelocation:address.coordinate Address:[NSString stringWithFormat:@"%@ %@",marker.title,marker.snippet]];
        }
    } else {
      NSLog(@"Could not reverse geocode point (%f,%f): %@",
            coordinate.latitude, coordinate.longitude, error);
    }
  };
  [geocoder_ reverseGeocodeCoordinate:coordinate completionHandler:handler];
    
}

-(void)rightButtonClicked:(UIBarButtonItem *)rightButton {
    GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
    acController.delegate = self;
    [self presentViewController:acController animated:YES completion:nil];
}

// Handle the user's selection.
- (void)viewController:(GMSAutocompleteViewController *)viewController
didAutocompleteWithPlace:(GMSPlace *)place {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //place.coordinate
    mapView_.camera = [GMSCameraPosition cameraWithLatitude:place.coordinate.latitude
                                                  longitude:place.coordinate.longitude
                                                       zoom:12];
    [self mapView:mapView_ didLongPressAtCoordinate:place.coordinate];
}

- (void)viewController:(GMSAutocompleteViewController *)viewController
didFailAutocompleteWithError:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    // TODO: handle the error.
    NSLog(@"Error: %@", [error description]);
}

// User canceled the operation.
- (void)wasCancelled:(GMSAutocompleteViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Turn the network activity indicator on and off again.
- (void)didRequestAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didUpdateAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}



@end
