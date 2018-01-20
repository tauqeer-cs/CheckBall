//
//  Location.m
//  CheckBall
//
//  Created by Shehzad Bilal on 20/01/2018.
//  Copyright © 2018 plego. All rights reserved.
//

#import "Location.h"

@implementation Location


+(Location *)parseItemFromItem:(id)accountItem{
    
    Location *currentItem = [Location new];
    
    currentItem.locationDescription =  [accountItem objectForKey:@"Description"];
    currentItem.userLatitude =  [[accountItem objectForKey:@"Latitude"] floatValue];
    currentItem.userLongitude =  [[accountItem objectForKey:@"Longitude"] floatValue];
    
    return currentItem;
    
}


@end
