//
//  RestCall.h
//  GChat
//
//  Created by Tauqeer on 2014-09-26.
//  Copyright (c) 2014 Carlin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"



@protocol RestCallDelegates


@optional


-(void)serviceCalledWithSuccess:(NSMutableArray *)result;
-(void)serviceCallFailed:(NSString *)errorMessage;

-(void)registerVCardSuccess:(id)response;

-(void)registerVCardFailed;

-(void)imageUploadSuccess:(id)responseString;

-(void)imageUploadFailed;

-(void)contactsServiceCalled : (NSDictionary *)params;

-(void)connectionErrorDelegate;
-(void)weatherImageLinkCalledWithSuccess:(NSString *)link;
-(void)weatherServicecAlledWithSuccessWithImage:(NSString *)imageLink withCurrentWeather:(id)currentWeather withForcast:(id)forcast withWeatherLocation:(id)weatherLocation;


@end

@interface RestCall : NSObject<NSXMLParserDelegate>

@property (nonatomic,strong) id<RestCallDelegates> delegate;

+(NSString *)makeSignatureWithGivenFullString:(NSString *)fullString;
+(NSString *)makeSignatureWithGivenDictionary:(NSDictionary *)params withKeyArray:(NSArray *)keys;
+(NSString *)encodeToJSONStringFromDictionary:(NSDictionary *)dictionary;






+(void)callWebServiceWithTheseParams:(NSDictionary *)params withSignatureSequence:(NSArray *)paramSeguence urlCalling:(NSString *)url isPostService:(BOOL)isPost
               withComplitionHandler:(void(^)(id result))completionHandler failureComlitionHandler:(void(^)(void))failureCompletionHandler;



+(NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding;

+(NSDictionary *)makeObjectFromJSON:(NSString *)extra;


+(NSString *)encodeToJSONStringFromArray:(NSArray *)array;



@end
