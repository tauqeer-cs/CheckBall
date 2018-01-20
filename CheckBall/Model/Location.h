//
//  Location.h
//  CheckBall
//
//  Created by Shehzad Bilal on 20/01/2018.
//  Copyright © 2018 plego. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject

@property (nonatomic,strong) NSString * locationDescription;
@property (nonatomic) float  userLatitude;
@property (nonatomic) float  userLongitude;

+(Location *)parseItemFromItem:(id)accountItem;



@end
