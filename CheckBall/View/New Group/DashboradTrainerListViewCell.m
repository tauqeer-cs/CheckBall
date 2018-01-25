//
//  DashboradTrainerListViewCell.m
//  CheckBall
//
//  Created by Tauqeer on 05/12/2017.
//  Copyright © 2017 plego. All rights reserved.
//

#import "DashboradTrainerListViewCell.h"
#import "AppDelegate.h"

@implementation DashboradTrainerListViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.mainContainer.layer.cornerRadius = 8;
    
    [self.profileContainer roundTheView];
    [self.profileImageView roundTheView];
    
}
-(void)updateWithDate:(id)data{
    
    

    AppDelegate * sharedDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
  
    if (sharedDelegate.currentLat == 0) {
     
        
        self.lblMiles.text = @"";
        
    }
    else {
        
        
        
        CLLocation *startLocation = [[CLLocation alloc] initWithLatitude:sharedDelegate.currentLat longitude:sharedDelegate.currentLong];

        id locationITem = [data objectForKey:@"Locations"];
        
        
        if ([locationITem count] > 0 ) {
            float lastOne = 0;
            for (id currentItem in locationITem)
            {float latShowing = [[currentItem objectForKey:@"latitude"] floatValue];
                float longShowing = [[currentItem objectForKey:@"longitude"] floatValue];
                CLLocation *endLocation = [[CLLocation alloc] initWithLatitude:latShowing longitude:longShowing];
CLLocationDistance distance = [startLocation distanceFromLocation:endLocation]; // aka double
if (distance > lastOne) {
                    lastOne = distance;
                    self.lblMiles.text = [NSString stringWithFormat:@"%.1fmi",(distance/1609.344)];
                }
            }

            NSLog(@"");
            
        }
        else {
            self.lblMiles.text = @"";
            
        }
        NSLog(@"");
        
        
        
    }
    
//    CLLocation *startLocation = [[CLLocation alloc] initWithLatitude:startLatitude longitude:startLongitude];

    if ([[data objectForKey:@"photo"] length] == 0) {
        
        [self.profileImageView setImage:[UIImage imageNamed:@"gander-icon"]];
        
    }
    else
    [FileManager loadProfileImage:self.profileImageView url:[baseImageLink stringByAppendingString:[NSString stringWithFormat:@"tmb%d.jpg",[[data objectForKey:@"id"] intValue]]] loader:nil];
    
    
  self.lblName.text =   [data objectForKey:@"name"];
    self.lblType.text =   [data objectForKey:@"specialities"];
    
    //http://check-ball.plego.net/Images/DP/tmb2.png
    
    return;
    

}
@end
