//
//  Specialities.m
//  CheckBall
//
//  Created by Shehzad Bilal on 21/01/2018.
//  Copyright © 2018 plego. All rights reserved.
//

#import "Specialities.h"

@implementation Specialities


+(Specialities *)parseItemFromItem:(id)accountItem
{
    
    Specialities *currentItem = [Specialities new];
    currentItem.name =  [accountItem objectForKey:@"Name"];
    currentItem.itemId =  [[accountItem objectForKey:@"ID"] intValue];
    return currentItem;
    
}

+(NSString *)mySpecialitesStringFromArray:(NSArray *)specialites{
    
 
    NSString * answer = @"";
    
    for (Specialities * cuurrentOne in specialites) {
        
        answer = [[answer stringByAppendingString:cuurrentOne.name] stringByAppendingString:@"/"];
        
        
    }
    
    if ([answer length] > 0) {
        
       answer =  [answer substringToIndex:[answer length] - 1 ];
        
    }
    return answer;
    
}
+(NSMutableArray *)parteArray:(NSArray * )inputArray{
   NSMutableArray * result =  [NSMutableArray new];
    
    
    for (id tmpItem in inputArray) {
        
        if ([[tmpItem objectForKey:@"selected"] intValue] == 1) {
            [result addObject: [self parseItemFromItem:tmpItem]];
            
        }
        
    }
    
    return result;
    
    
}

+(NSMutableArray *)savedSpecialities{
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    id sharerOnes = [defaults objectForKey:@"Specialities"];
   
    
    NSMutableArray * tmpItemToSend = [NSMutableArray new];
    
    for (id currentItem in sharerOnes) {
        
        Specialities *tmpParsed = [self parseItemFromItem:currentItem];
        
        [tmpItemToSend addObject:tmpParsed];
    
    }
    
    return tmpItemToSend;
}


+(void)callGetSpecialitesWithComplitionHandler:(void(^)(id result))completionHandler withFailueHandler:(void(^)(void))failureHandler
{
    
    
    [RestCall callWebServiceWithTheseParams:nil
                      withSignatureSequence:nil
                                 urlCalling:
     [baseServiceUrl stringByAppendingString:@"specility"]
                              isPostService:NO
                      withComplitionHandler:^(id result) {
                          
                          id message = [result objectForKey:@"status"];
                          
                          
                          NSString * status = message;
                          
                          
                          if ([status isEqualToString:@"success"]) {
                              
                              id list = [result objectForKey:@"data"];
                              NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
                              
                              [defaults setObject:list forKey:@"Specialities"];
                              
                              
                              
                              completionHandler(list);
                          }
                          else {
                              
                              failureHandler();
                              
                          }
                          
                          
                          
                          
                          
                          NSLog(@"");
                          
                          
                          
                      } failureComlitionHandler:^{
                          failureHandler();
                          
                          
                          
                      }];
    
    
}




@end
