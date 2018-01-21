//
//  Specialities.h
//  CheckBall
//
//  Created by Shehzad Bilal on 21/01/2018.
//  Copyright © 2018 plego. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Specialities : NSObject

@property (nonatomic) int itemId;
@property (nonatomic,strong) NSString * name;
+(NSMutableArray *)parteArray:(NSArray * )inputArray;
+(NSString *)mySpecialitesStringFromArray:(NSArray *)specialites;
+(void)callGetSpecialitesWithComplitionHandler:(void(^)(id result))completionHandler
                             withFailueHandler:(void(^)(void))failureHandler;

+(NSMutableArray *)savedSpecialities;

@end
