 

//
//  RestCall.m
//  GChat
//
//  Created by Tauqeer on 2014-09-26.
//  Copyright (c) 2014 Carlin. All rights reserved.
//

#import "RestCall.h"
#import "Config.h"
#import "JSONKit.h"
#import "NSDictionary+NullReplacement.h"
#import "NSArray+NullReplacement.h"
#import "DateFormatter.h"
#import "XMLDictionary.h"



@implementation RestCall


+(NSDictionary *)makeObjectFromJSON:(NSString *)extra{
    
    NSDictionary *JSON;
    JSON = [NSJSONSerialization JSONObjectWithData: [extra dataUsingEncoding:NSUTF8StringEncoding]
                                           options: NSJSONReadingMutableContainers
                                             error: nil];
    
    
    
    return JSON;
}
+(NSString *)encodeToJSONStringFromArray:(NSArray *)array{
    
    NSError *error;
    NSData *httpBody = [NSJSONSerialization dataWithJSONObject:array options:0 error:&error];
    return [[NSString alloc] initWithData:httpBody encoding:NSUTF8StringEncoding];
}

+(NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding {
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                 (CFStringRef)self,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                 CFStringConvertNSStringEncodingToEncoding(encoding)));
}

+(NSString *)encodeToJSONStringFromString:(NSString *)array{
    
    NSError *error;
    NSData *httpBody = [NSJSONSerialization dataWithJSONObject:array options:0 error:&error];
    return [[NSString alloc] initWithData:httpBody encoding:NSUTF8StringEncoding];
}

+(NSString *)encodeToJSONStringFromDictionary:(NSDictionary *)dictionary{
    

    NSError *error;
    
    NSData *httpBody = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&error];
    
    

    
    return [[NSString alloc] initWithData:httpBody encoding:NSUTF8StringEncoding];
}

+(NSString *)makeSignatureWithGivenFullString:(NSString *)fullString
{

    return @"";
    
}

+(NSString *)makeSignatureWithGivenDictionary:(NSDictionary *)params withKeyArray:(NSArray *)keys
{

    return @"";
}



-(NSString *)convertArrayToString:(NSArray *)array{
    
    NSString *fullString = @"";
    
    if([array count] == 0)
        return @"";
    
    for (NSString *currentString in array) {
        fullString = [fullString stringByAppendingString:currentString];
        fullString = [fullString stringByAppendingString:@","];
        
    }
    fullString = [fullString substringToIndex:fullString.length - 1];
    
    return fullString;
    
}













-(void)callWebServiceWithThis :(NSMutableDictionary *)params
{
    
    
    NSURL *baseURL = [NSURL URLWithString:
                      [baseServiceUrl stringByAppendingString:@"friends/update-groups"]
                      ];
    
    
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    
    
    [manager POST:
     [baseServiceUrl stringByAppendingString:@"friends/update-groups"]
       parameters:params
          success:^(NSURLSessionDataTask *task,
                    id responseObject)
     {
         
         NSLog(@"%@",responseObject);
         
         
         
     }
          failure:^(NSURLSessionDataTask *task, NSError *error){
              
              
              NSLog(@"%@",task.response);
              
              NSLog(@"%@",error);
              
          }];
}



/*
 [NSURLConnection sendAsynchronousRequest:request2 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

 
 }];
 
 */

+(void)callWebServiceWithTheseParams:(NSDictionary *)params
               withSignatureSequence:(NSArray *)paramSeguence
                          urlCalling:(NSString *)url isPostService:(BOOL)isPost
               withComplitionHandler:(void(^)(id result))completionHandler failureComlitionHandler:(void(^)(void))failureCompletionHandler
{
    

    
    NSDictionary *jsonDictionary = params;
    
    
    NSError *error;
    
    
    NSMutableURLRequest *request2 = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    if (isPost) {
        [request2 setHTTPMethod:@"POST"];
        NSData *httpBody = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:0 error:&error];
        
        
        [request2 setHTTPBody:httpBody];
        NSString *sending = [[NSString alloc] initWithData:httpBody encoding:NSUTF8StringEncoding];
        
    
        NSLog(@"%@",sending);
        
    }
    
    else {
        
        [request2 setHTTPMethod:@"GET"];
        
    }
    
    [request2 setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    
    
    [NSURLConnection sendAsynchronousRequest:request2 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        
        if (!data) {
            NSLog(@"sendAsynchronousRequest error: %@", connectionError);
            failureCompletionHandler();
            NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",newStr);
            
            failureCompletionHandler();
            
            
            
            
            return;
        }
        NSMutableDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        
        
        if (!dictionary) {
            NSLog(@"sendAsynchronousRequest error: %@", connectionError);
            NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            failureCompletionHandler();
            NSLog(@"%@",newStr);
            
            
            
            return;
        }
        completionHandler([dictionary dictionaryByReplacingNullsWithBlanks]);
        
        
    }];
    
 
    
    
}

-(void)callWebServiceWithTheseParams:(NSMutableDictionary *)params withSignatureSequence:(NSArray *)paramSeguence urlCalling:(NSString *)url withComplitionHandler:(void(^)(id result))completionHandler
{
    
    [params setValue:[RestCall makeSignatureWithGivenDictionary:params withKeyArray:paramSeguence]
              forKey:@"signature"];
    
    NSDictionary *jsonDictionary = params;
    
    
    NSError *error;
    NSData *httpBody = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:0 error:&error];
    NSAssert(httpBody, @"dataWithJSONObject error: %@", error);
    
    
    NSMutableURLRequest *request2 = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request2 setHTTPMethod:@"POST"];
    [request2 setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request2 setHTTPBody:httpBody];
    
    NSString *sending = [[NSString alloc] initWithData:httpBody encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",sending);
    
    
    [NSURLConnection sendAsynchronousRequest:request2 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!data) {
            
            NSLog(@"sendAsynchronousRequest error: %@", connectionError);
            [self.delegate connectionErrorDelegate];
            return;
        }
        
        
        NSMutableDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        completionHandler([dictionary dictionaryByReplacingNullsWithBlanks]);
        
    }];
    
    
    
}






- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    NSLog(@"timed out");
    
}
















//






-(void)callWeatherService2
{
    

    
    
    
    NSUserDefaults *defaults;
    defaults = [NSUserDefaults standardUserDefaults];
    
    
    NSURL *baseURL = [NSURL URLWithString:
                      @"http://api.openweathermap.org/data/2.5/weather?q=Karachi,pk"
                      ];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    
    [manager GET :
     @"http://api.openweathermap.org/data/2.5/weather?q=Karachi,pk&units=metric"
       parameters:nil
          success:^(NSURLSessionDataTask *task,
                    id responseObject)
     {
         


         
     }
          failure:^(NSURLSessionDataTask *task, NSError *error){
              
              
              NSLog(@"%@",task.response);
              
              NSLog(@"%@",error);
              
          }];
    
}





-(void)processParsedObject:(id)object{

    [self processParsedObject:object depth:0 parent:nil];

}

-(void)processParsedObject:(id)object depth:(int)depth parent:(id)parent{
    
    if([object isKindOfClass:[NSDictionary class]]){
        
        for(NSString * key in [object allKeys]){
            id child = [object objectForKey:key];
            [self processParsedObject:child depth:depth+1 parent:object];
        }
        
        
    }else if([object isKindOfClass:[NSArray class]]){
        
        for(id child in object){
            [self processParsedObject:child depth:depth+1 parent:object];
        }
        
    }
    else{
        //This object is not a container you might be interested in it's value
        
    
        if ([object isKindOfClass:[NSNull class]]) {
            
            
            object = nil;
            
        }
        
    
    }
    
    
}










@end
