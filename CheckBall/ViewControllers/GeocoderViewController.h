
#import "BaseScrollViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface GeocoderViewController : BaseScrollViewController <GMSMapViewDelegate,GMSAutocompleteViewControllerDelegate>
@property (nonatomic,weak) id<UpdateGeoLocationDelegate> parent;
@property CLLocationCoordinate2D initialCoordinates;
@property bool addpin;
@end
