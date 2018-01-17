//
//  User.m
//  Filmer
//
//  Created by Tauqeer Ahmed on 3/15/16.
//  Copyright © 2016 Plego. All rights reserved.//

#import "User.h"
#import "RestCall.h"
#import "Config.h"
#import "AppDelegate.h"
#import "NSDictionary+NullReplacement.h"
#import "NSArray+NullReplacement.h"
#import "DateFormatter.h"


@implementation User


+(void)callCheckFbLoginIdExists:(NSString *)loginId
       withDoesNotExistsHandler:(void(^)(id result))doesNotExists
              withFailueHandler:(void(^)(void))failureHandler
       withAlreadyExistsHandler:(void(^)(id result))alreadyExistHandler
{
    
    NSMutableDictionary *currentDictionary = [NSMutableDictionary new];
    [currentDictionary setObject:loginId forKey:@"facebook_token"];
    
   
    NSUserDefaults *defauls = [NSUserDefaults standardUserDefaults];
    NSString *token = [defauls objectForKey:@"deviceToken"];;
    
    [currentDictionary setObject:@"IOS" forKey:@"device"];
    
 
    if (token)
    {
        [currentDictionary setObject:token forKey:@"device_id"];
        
    }
    
    
  
    
    
    NSUserDefaults *currentUserDefault = [NSUserDefaults standardUserDefaults];
    
    [RestCall callWebServiceWithTheseParams:currentDictionary
                      withSignatureSequence:nil
                                 urlCalling:
     [baseServiceUrl stringByAppendingString:@"/login_facebook"]
                              isPostService:YES
                      withComplitionHandler:^(id result) {
                          
                          @try {
                              
                              
                              
                              id message = [result objectForKey:@"data"];
                              
                              
                              BOOL isNew = [[message objectForKey:@"is_new"] boolValue];
                             
                              id dataObject = [result objectForKey:@"data"];
                              
                              
                              
                              dataObject =  [dataObject dictionaryByReplacingNullsWithBlanks];
                              
                              
                              [defauls setObject:dataObject forKey:@"isFirstTimeSignUp"];
                              
                              
                              
                              if (isNew) {
                                  
                                  doesNotExists(nil);
                                  
                              }
                              else {
                                  
                                  alreadyExistHandler(nil);
                                  
                                  
                              }
                              
                              

                              
                              
                          }
                          @catch (NSException *exception) {
                              
                              failureHandler();
                              
                          }
                          
                          
                      } failureComlitionHandler:^{
                          
                          failureHandler();
                          
                      }];
    
}

+(void)callCheckGooogleLoginIdExists:(NSString *)loginId
       withDoesNotExistsHandler:(void(^)(id result))doesNotExists
              withFailueHandler:(void(^)(void))failureHandler
       withAlreadyExistsHandler:(void(^)(id result))alreadyExistHandler
{
    
    NSMutableDictionary *currentDictionary = [NSMutableDictionary new];
    [currentDictionary setObject:loginId forKey:@"google_token"];
    
    
    NSUserDefaults *defauls = [NSUserDefaults standardUserDefaults];
    NSString *token = [defauls objectForKey:@"device_id"];;
    
    
    if (!token) {
        
        AppDelegate *myAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
    }
    
    if (token)
    {
        [currentDictionary setObject:token forKey:@"device_id"];
        [currentDictionary setObject:@"IOS" forKey:@"device"];
    }
    
    
    
    
    
    
    [RestCall callWebServiceWithTheseParams:currentDictionary
                      withSignatureSequence:nil
                                 urlCalling:
     [baseServiceUrl stringByAppendingString:@"/login_google"]
                              isPostService:YES
                      withComplitionHandler:^(id result) {
                          
                          @try {
                              
                              
                              
                              id message = [result objectForKey:@"data"];
                              
                              
                              BOOL isNew = [[message objectForKey:@"is_new"] boolValue];
                              
                              id dataObject = [result objectForKey:@"data"];
                              
                              
                              
                              dataObject =  [dataObject dictionaryByReplacingNullsWithBlanks];
                              
                              
                              [defauls setObject:dataObject forKey:@"isFirstTimeSignUp"];
                              
                              
                              
                              if (isNew) {
                                  
                                  doesNotExists(nil);
                                  
                              }
                              else {
                                  
                                  alreadyExistHandler(nil);
                                  
                                  
                              }
                              
                              
                              
                              
                              
                          }
                          @catch (NSException *exception) {
                              
                              failureHandler();
                              
                          }
                          
                          
                      } failureComlitionHandler:^{
                          
                          failureHandler();
                          
                      }];
    
}



+(NSString *)myJid{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    
    if ([[userDefaults objectForKey:@"isFirstTimeSignUp"] isKindOfClass:[NSArray class]]) {
        return [[[userDefaults objectForKey:@"isFirstTimeSignUp"] firstObject] objectForKey:@"id"];
    }
    return [[userDefaults objectForKey:@"isFirstTimeSignUp"] objectForKey:@"id"];
    
}

+(void)callCheckUserContacts:(NSString *)contactEmails
            withPhoneNumbers:(NSString *)phoneNumbers
           completionHandler:(void(^)(id result))completionHandler
              withFailueHandler:(void(^)(void))failureHandler
{
    
  
}





+(void)callEditPeriodInfo:(NSString *)dateString
                       withNoOfPeriodDays:(int)noOfPeriodDay
                       WithmenstrualCycleDays:(int)menstrualCycleDays
          withComplitionHandler:(void(^)(id result))completionHandler
              withFailueHandler:(void(^)(void))failureHandler

{
    
    
    NSMutableDictionary *currentDictionary = [NSMutableDictionary new];
    [currentDictionary setObject:dateString forKey:@"last_period_date"];
    [currentDictionary setObject:[NSString stringWithFormat:@"%d",noOfPeriodDay] forKey:@"no_of_period_days"];
    [currentDictionary setObject:[NSString stringWithFormat:@"%d",menstrualCycleDays] forKey:@"menstrual_cycle_days"];
    
    

    
    
    
    
    
    NSUserDefaults *defauls = [NSUserDefaults standardUserDefaults];
    NSString *token = [defauls objectForKey:@"deviceToken"];;
    
    if (!token) {
        
        AppDelegate *sharedDelegate =(AppDelegate *) [[UIApplication sharedApplication] delegate];
        

        
        
    }
    
    
    NSData *imageData;
    

    
    
    
    NSUserDefaults * myDefault =  [NSUserDefaults standardUserDefaults];
    id c =  [myDefault objectForKey:@"isFirstTimeSignUp"];
    
    
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST"
                                                                                              URLString:[baseServiceUrl stringByAppendingString:@"edit_Profile"] parameters:currentDictionary constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                                                                                  

                                                                                                  
                                                                                                  
                                                                                              } error:nil];
    
    
    
    
    
    if ([c isKindOfClass:[NSDictionary class]]) {
        
        NSString * authKey = [c objectForKey:@"authtoken"];
        [request setValue:authKey forHTTPHeaderField:@"Authtoken"];
        
    }
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]
                                    initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:nil
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      
                      if ([[responseObject objectForKey:@"code"] intValue] == 409) {
                          
                          completionHandler(nil);
                          
                          
                      }
                      else
                          if (error) {
                              NSLog(@"Error: %@", error);
                              
                              failureHandler();
                              
                          } else {
                              NSLog(@"%@ %@", response, responseObject);
                              
                              if ([[responseObject objectForKey:@"status"] isEqualToString:@"success"]) {
                                  
                                  id dataObject = [responseObject objectForKey:@"data"];
                                  
                                  
                                  
                                  //dataObject =  [dataObject dictionaryByReplacingNullsWithBlanks];
                                  
                                  
                                  [defauls setObject:dataObject forKey:@"isFirstTimeSignUp"];
                                  
                                  
                                  completionHandler(dataObject);
                                  
                                  
                                  
                                  
                                  //
                              }
                              else {
                                  
                                  
                              }
                              
                          }
                  }];
    
    [uploadTask resume];
    
}



+(void)callEditProfileWithImage:(UIImage *)profileImage
          withComplitionHandler:(void(^)(id result))completionHandler
              withFailueHandler:(void(^)(void))failureHandler
       withAlreadyExistsHandler:(void(^)(id result))alreadyExistHandler

{
    
    
    NSMutableDictionary *currentDictionary = [NSMutableDictionary new];
    
    
    
    
    
    
    NSUserDefaults *defauls = [NSUserDefaults standardUserDefaults];
    NSString *token = [defauls objectForKey:@"deviceToken"];;
    
    if (!token) {
        
        AppDelegate *sharedDelegate =(AppDelegate *) [[UIApplication sharedApplication] delegate];
        

        
    }
    
    
    NSData *imageData;
    
    if (profileImage) {
        imageData = UIImageJPEGRepresentation(profileImage, 1.0);
        
    }
    
    
    
    NSUserDefaults * myDefault =  [NSUserDefaults standardUserDefaults];
    id c =  [myDefault objectForKey:@"isFirstTimeSignUp"];
    
    
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST"
                                                                                              URLString:[baseServiceUrl stringByAppendingString:@"edit"] parameters:currentDictionary constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                                                                                  
                                                                                                  if (imageData) {
                                                                                                      
                                                                                                      [formData appendPartWithFileData:imageData name:@"image" fileName:@"photo.jpg" mimeType:@"image/jpeg"];
                                                                                                      
                                                                                                      
                                                                                                  }
                                                                                                  
                                                                                                  
                                                                                                  
                                                                                                  NSLog(@"");
                                                                                                  
                                                                                                  
                                                                                              } error:nil];
    
    
    
    
    
    if ([c isKindOfClass:[NSDictionary class]]) {
        
        NSString * authKey = [c objectForKey:@"authtoken"];
        [request setValue:authKey forHTTPHeaderField:@"Authtoken"];
        
    }
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]
                                    initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:nil
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      
                      if ([[responseObject objectForKey:@"code"] intValue] == 409) {
                          
                          alreadyExistHandler(@"Already exists");
                          
                      }
                      else
                          if (error) {
                              NSLog(@"Error: %@", error);
                              
                              failureHandler();
                              
                          } else {
                              NSLog(@"%@ %@", response, responseObject);
                              
                              if ([[responseObject objectForKey:@"status"] isEqualToString:@"success"]) {
                                  
                                  id dataObject = [responseObject objectForKey:@"data"];
                                  
                                  
                                  
                                  dataObject =  [dataObject dictionaryByReplacingNullsWithBlanks];
                                  
                                  
                                  [defauls setObject:dataObject forKey:@"isFirstTimeSignUp"];
                                  
                                  
                                  completionHandler(dataObject);
                                  
                                  
                                  
                                  
                                  //
                              }
                              else {
                                  
                                  
                              }
                              
                          }
                  }];
    
    [uploadTask resume];
    
}


+(void)callEditProfileWithEmail:(NSString *)emailAddress
                        withName:(NSString *)name
                         withDob:(NSString *)dob
                    withIsSingle:(NSString *)isSingle
                      withGender:(NSString *)gender
                       withImage:(UIImage *)profileImage
           withComplitionHandler:(void(^)(id result))completionHandler
              withFailueHandler:(void(^)(void))failureHandler
        withAlreadyExistsHandler:(void(^)(id result))alreadyExistHandler

{
    
    
    NSMutableDictionary *currentDictionary = [NSMutableDictionary new];


    //[currentDictionary setObject:emailAddress forKey:@"email"];
    [currentDictionary setObject:name forKey:@"fullname"];

    
    if ([dob length] > 0) {
        [currentDictionary setObject:dob forKey:@"dob"];
        
    }

    
    if ([gender length] > 0) {
        
        [currentDictionary setObject:gender forKey:@"gender"];
    }
    
    if ([isSingle length] > 0) {
        [currentDictionary setObject:isSingle forKey:@"marital_status"];
    }
    
    
    
    
    
    
    NSUserDefaults *defauls = [NSUserDefaults standardUserDefaults];
    NSString *token = [defauls objectForKey:@"deviceToken"];;
    
    if (!token) {
        
        AppDelegate *sharedDelegate =(AppDelegate *) [[UIApplication sharedApplication] delegate];
        
        
        
    }
    

    NSData *imageData;
    
    if (profileImage) {
        imageData = UIImageJPEGRepresentation(profileImage, 1.0);
        
    }
    
    
    
    NSUserDefaults * myDefault =  [NSUserDefaults standardUserDefaults];
     id c =  [myDefault objectForKey:@"isFirstTimeSignUp"];
    

    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST"
                                                                                              URLString:[baseServiceUrl stringByAppendingString:@"editProfile"] parameters:currentDictionary constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                                                                                  
                                                                                                  if (imageData) {
                                                                                                      
                                                                                                      [formData appendPartWithFileData:imageData name:@"image" fileName:@"photo.jpg" mimeType:@"image/jpeg"];
                                                                                                      
                                                                                                      
                                                                                                  }
                                                                                                  
                                                                                                  
                                                                                                  
                                                                                                  NSLog(@"");
                                                                                                  
                                                                                                  
                                                                                              } error:nil];
    
    
    

    
    if ([c isKindOfClass:[NSDictionary class]]) {
        
        NSString * authKey = [c objectForKey:@"authtoken"];
        [request setValue:authKey forHTTPHeaderField:@"Authtoken"];
        
    }
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] 
                                    initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:nil
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      
                      if ([[responseObject objectForKey:@"code"] intValue] == 409) {
                          
                          alreadyExistHandler(@"Already exists");
                          
                      }
                      else
                          if (error) {
                              NSLog(@"Error: %@", error);
                              
                              failureHandler();
                              
                          } else {
                              NSLog(@"%@ %@", response, responseObject);
                              
                              if ([[responseObject objectForKey:@"status"] isEqualToString:@"success"]) {
                                  
                                  id dataObject = [responseObject objectForKey:@"data"];
                                  
                                  
                                  
                                  dataObject =  [dataObject dictionaryByReplacingNullsWithBlanks];
                                  
                                  
                                  [defauls setObject:dataObject forKey:@"isFirstTimeSignUp"];
                                  
                                  
                                  completionHandler(dataObject);
                                  
                                  
                                  
                                  
                                  //
                              }
                              else {
                                  
                                  
                              }
                              
                          }
                  }];
    
    [uploadTask resume];
    
}


+(void)callRegisterUserWithParams:(NSDictionary *)params
            withComplitionHandler:(void(^)(id result))completionHandler withFailueHandler:(void(^)(void))failureHandler
         withAlreadyExistsHandler:(void(^)(id result))alreadyExistHandler
{
    

    
    NSUserDefaults *currentUserDefault = [NSUserDefaults standardUserDefaults];
    
    
    
    
    [RestCall callWebServiceWithTheseParams:params
                      withSignatureSequence:nil
                                 urlCalling:
     [baseServiceUrl stringByAppendingString:@"register"]
                              isPostService:YES
                      withComplitionHandler:^(id result) {
                          
                          @try {
                              
                              id message = [[result
                                             objectForKey:@"message"] objectForKey:@"status"];
                              
                              if ([message isEqualToString:@"Success"]) {
                                  
                                  id data = [[result objectForKey:@"message"] objectForKey:@"Data"];
                                  
                                  if ([data isKindOfClass:[NSArray class]])
                                  {
                                      data  =  data[0];
                                      
                                  }
                                  
                                  [currentUserDefault setObject:data forKey:@"isFirstTimeSignUp"];
                                  completionHandler(data);
                                  
                                  
                              }
                              else if ([message isEqualToString:@"Failure"]){
                               
                                  
                                  if ([[[result
                                         objectForKey:@"message"] objectForKey:@"Error"] isEqualToString:@"Email Found"]) {
                                      alreadyExistHandler(@"");
                                      
                                  }
                                  else {
                                   
                                    failureHandler();
                                  }
                              }
                              else{
                                  
                                  failureHandler();
                              }
                              
                              
                              
                              
                          }
                          @catch (NSException *exception) {
                              
                              failureHandler();
                              
                          }
                          
                          
                      } failureComlitionHandler:^{
                          
                          failureHandler();
                          
                      }];
    
    
}

+(void)callUpdateProfileWithParams:(NSDictionary *)params
            withComplitionHandler:(void(^)(id result))completionHandler withFailueHandler:(void(^)(void))failureHandler
         withAlreadyExistsHandler:(void(^)(id result))alreadyExistHandler
{
    
    
    
    NSUserDefaults *currentUserDefault = [NSUserDefaults standardUserDefaults];
    
    
    
    
    [RestCall callWebServiceWithTheseParams:params
                      withSignatureSequence:nil
                                 urlCalling:
     [baseServiceUrl stringByAppendingString:@"UpdateProfile"]
                              isPostService:YES
                      withComplitionHandler:^(id result) {
                          
                          @try {
                              
                              id message = [[result
                                             objectForKey:@"message"] objectForKey:@"status"];
                              
                              if ([message isEqualToString:@"Success"]) {
                                  
                                  id data = [[result objectForKey:@"message"] objectForKey:@"Data"];
                                  
                                  if ([data isKindOfClass:[NSArray class]])
                                  {
                                      data  =  data[0];
                                      
                                  }
                                  
                                  [currentUserDefault setObject:data forKey:@"isFirstTimeSignUp"];
                                  completionHandler(data);
                                  
                                  
                              }
                              else if ([message isEqualToString:@"Failure"]){
                                  
                                  
                                  if ([[[result
                                         objectForKey:@"message"] objectForKey:@"Error"] isEqualToString:@"Email Found"]) {
                                      alreadyExistHandler(@"");
                                      
                                  }
                                  else {
                                      
                                      failureHandler();
                                  }
                              }
                              else{
                                  
                                  failureHandler();
                              }
                              
                              
                              
                              
                          }
                          @catch (NSException *exception) {
                              
                              failureHandler();
                              
                          }
                          
                          
                      } failureComlitionHandler:^{
                          
                          failureHandler();
                          
                      }];
    
    
}


+(void)callContactUs:(NSString *)subject
                         withMessage:(NSString *)message
                   withComplitionHandler:(void(^)(id result))completionHandler
                       withFailueHandler:(void(^)(void))failureHandler

{
    
    
    NSMutableDictionary *currentDictionary = [NSMutableDictionary new];
    
    [currentDictionary setObject:subject forKey:@"subject"];
    [currentDictionary setObject:message forKey:@"message"];
    
    
    [RestCall callWebServiceWithTheseParams:currentDictionary
                      withSignatureSequence:nil
                                 urlCalling:
     [baseServiceUrl stringByAppendingString:@"contact_us"]
                              isPostService:YES
                      withComplitionHandler:^(id result) {
                          
                          @try {
                              
                              id message = [result
                                            objectForKey:@"status"];
                              
                              if ([message isEqualToString:@"success"]) {
                                  
                                  completionHandler(@"success");
                                  
                                  
                              }
                              else if ([message isEqualToString:@"failed"]){
                                  
                                  completionHandler(@"failed");
                                  
                              }
                              else{
                                  
                                  failureHandler();
                              }
                              
                              
                              
                              
                          }
                          @catch (NSException *exception) {
                              
                              failureHandler();
                              
                          }
                          
                          
                      } failureComlitionHandler:^{
                          
                          failureHandler();
                          
                      }];
}


+(void)callChangePasswordWithOldPassword:(NSString *)oldPassword
                         withNewPassword:(NSString *)newPassword
   withComplitionHandler:(void(^)(id result))completionHandler
       withFailueHandler:(void(^)(void))failureHandler

{
    
    
    NSMutableDictionary *currentDictionary = [NSMutableDictionary new];
    
    [currentDictionary setObject:newPassword forKey:@"NewPassword"];
    [currentDictionary setObject:oldPassword forKey:@"OldPassword"];
    [currentDictionary setObject:oldPassword forKey:@"ConfirmPassword"];
    
    
    
    
    [RestCall callWebServiceWithTheseParams:currentDictionary
                      withSignatureSequence:nil
                                 urlCalling:
     [baseServiceUrl stringByAppendingString:@"ChangePassword"]
                              isPostService:YES
                      withComplitionHandler:^(id result) {
                          
                          @try {
                              
                              id message = [result
                                            objectForKey:@"status"];
                              
                              if ([message isEqualToString:@"success"]) {
                                  
                                  completionHandler(@"success");
                                  
                                  
                              }
                              else if ([message isEqualToString:@"failed"]){
                                  
                                  completionHandler(@"failed");
                                  
                              }
                              else{
                                  
                                  failureHandler();
                              }
                              
                              
                              
                              
                          }
                          @catch (NSException *exception) {
                              
                              failureHandler();
                              
                          }
                          
                          
                      } failureComlitionHandler:^{
                          
                          failureHandler();
                          
                      }];
}

+(void)callForgetAccount:(NSString *)email
withComplitionHandler:(void(^)(id result))completionHandler
withFailueHandler:(void(^)(void))failureHandler

{
    
    
    NSMutableDictionary *currentDictionary = [NSMutableDictionary new];
    
    [currentDictionary setObject:email forKey:@"email"];
    
    NSUserDefaults *currentUserDefault = [NSUserDefaults standardUserDefaults];
    
    
    
    
    [RestCall callWebServiceWithTheseParams:currentDictionary
                      withSignatureSequence:nil
                                 urlCalling:
     [baseServiceUrl stringByAppendingString:@"forgotPassword"]
                              isPostService:YES
                      withComplitionHandler:^(id result) {
                          
                          @try {
                              
                              id message = [result
                                            objectForKey:@"status"];
                              
                              if ([message isEqualToString:@"success"]) {
                                  
                                  id data = [result objectForKey:@"data"];
                                  
                                  [currentUserDefault setObject:nil forKey:@"isFirstTimeSignUp"];
                                  completionHandler(data);
                                  
                                  
                              }
                              else if ([message isEqualToString:@"failed"]){
                              }
                              else{
                                  
                                  failureHandler();
                              }
                              
                              
                              
                              
                          }
                          @catch (NSException *exception) {
                              
                              failureHandler();
                              
                          }
                          
                          
                      } failureComlitionHandler:^{
                          
                          failureHandler();
                          
                      }];
}



//forgotPassword

+(void)callLogOut:(NSString *)email
        withComplitionHandler:(void(^)(id result))completionHandler
withFailueHandler:(void(^)(void))failureHandler

{
    
    
    NSMutableDictionary *currentDictionary = [NSMutableDictionary new];
    
    NSUserDefaults *currentUserDefault = [NSUserDefaults standardUserDefaults];
    
    

    
    [RestCall callWebServiceWithTheseParams:nil
                      withSignatureSequence:nil
                                 urlCalling:
     [baseServiceUrl stringByAppendingString:@"logout"]
                              isPostService:YES
                      withComplitionHandler:^(id result) {
                          
                          @try {
                              
                              id message = [result
                                            objectForKey:@"status"];
                              
                              if ([message isEqualToString:@"success"]) {
                                  
                                  id data = [result objectForKey:@"data"];
                                  
                                  [currentUserDefault setObject:nil forKey:@"isFirstTimeSignUp"];
                                  completionHandler(data);
                                  
                                  
                              }
                              else if ([message isEqualToString:@"failed"]){
                                  
                                  completionHandler(nil);
                                  
                                  
                                  
                              }
                              else{
                                  
                                  failureHandler();
                              }
                              
                              
                              
                              
                          }
                          @catch (NSException *exception) {
                              
                              failureHandler();
                              
                          }
                          
                          
                      } failureComlitionHandler:^{
                          
                          failureHandler();
                          
                      }];
}

+(void)callLoginUserWithEmail:(NSString *)email withPassword:(NSString *)password
           withComplitionHandler:(void(^)(id result))completionHandler withFailueHandler:(void(^)(void))failureHandler
        withNoAccountExistsHandler:(void(^)(id result))noAccountExistsHandler

{
    
    
    NSMutableDictionary *currentDictionary = [NSMutableDictionary new];
    [currentDictionary setObject:email forKey:@"email"];
    [currentDictionary setObject:password forKey:@"password"];
    [currentDictionary setObject:@"APP" forKey:@"LoginBy"];
    
    
    //
    NSUserDefaults *currentUserDefault = [NSUserDefaults standardUserDefaults];
    
    
    
    
    [RestCall callWebServiceWithTheseParams:currentDictionary
                      withSignatureSequence:nil
                                 urlCalling:
     [baseServiceUrl stringByAppendingString:@"Login"]
     isPostService:YES
                      withComplitionHandler:^(id result) {
                          
                          @try {
                              
                              id message = [[result
                                             objectForKey:@"message"] objectForKey:@"status"];
                              
                              if ([message isEqualToString:@"Success"]) {
                                  
                                  
                                  id data = [[result objectForKey:@"message"] objectForKey:@"Data"];;
                                  
                                  if ([data isKindOfClass:[NSArray class]])
                                  {
                                      data  =  data[0];
                                      
                                  }
                                  [currentUserDefault setObject:data forKey:@"isFirstTimeSignUp"];
                                  completionHandler(data);
                                  
                              }
                              else if ([message isEqualToString:@"failed"]){
                                  noAccountExistsHandler(nil);
                              }
                              else{
                                  
                                  failureHandler();
                              }
                              
                              
                              
                              
                          }
                          @catch (NSException *exception) {
                              
                              failureHandler();
                              
                          }
                          
                          
                      } failureComlitionHandler:^{
                          
                          failureHandler();
                          
                      }];
}




+(void)callSerchUserWithKeyword:(NSString *)keyword completionHandler:(void(^)(id result))completionHandler
           withFailueHandler:(void(^)(void))failureHandler
{
    
    NSMutableDictionary *currentDictionary = [NSMutableDictionary new];
    [currentDictionary setObject:keyword forKey:@"keyword"];
    
    
   
    [RestCall callWebServiceWithTheseParams:currentDictionary
                      withSignatureSequence:
     nil
                                 urlCalling:
     [baseServiceUrl stringByAppendingString:@"FlpUsers/search.json"]
                              isPostService:YES
                      withComplitionHandler:^(id result) {
                          
                          @try {
                              
                              
                              
                              id message = [result objectForKey:@"message"];
                              
                           
                              if ([[message objectForKey:@"status"] isEqualToString:@"success"]) {
                                  
                                  completionHandler([message objectForKey:@"data"]);
                                  
                                  return;
                                  
                              }
                              else{
                                                                failureHandler();
                              }
                              NSLog(@"");
                              
                              
                              
                          }
                          @catch (NSException *exception) {
                              
                              failureHandler();
                              
                          }
                          
                          
                      } failureComlitionHandler:^{
                          
                          failureHandler();
                          
                      }];
    
}


+(void)callGetMyFriendsWithUserId:(NSString *)userId
                completionHandler:(void(^)(id result))completionHandler
              withFailueHandler:(void(^)(void))failureHandler
{
    
    
    NSMutableDictionary *currentDictionary = [NSMutableDictionary new];
    [currentDictionary setObject:[NSString stringWithFormat:@"%d",[userId intValue]] forKey:@"userid"];
    
    [RestCall callWebServiceWithTheseParams:currentDictionary
                      withSignatureSequence:
     nil
                                 urlCalling:
     [baseServiceUrl stringByAppendingString:@"FlpUserFriends/getlistoffriends.json"]
                              isPostService:YES
                      withComplitionHandler:^(id result) {
                          
                          @try {
                              
                              
                              
                              id message = [result objectForKey:@"message"];
                              
                              
                              if ([[message objectForKey:@"status"] isEqualToString:@"Success"]) {
                                  
                                  completionHandler([message objectForKey:@"data"]);
                                  
                                  return;
                                  
                              }
                              else if ([[message objectForKey:@"status"] isEqualToString:@"No User Found."]){
                                  
                                  completionHandler(nil);
                                  
                                  
                                  
                              }
                              else{
                                  failureHandler();
                                  
                                  
                              }
                              NSLog(@"");
                              
                              
                              
                          }
                          @catch (NSException *exception) {
                              
                              failureHandler();
                              
                          }
                          
                          
                      } failureComlitionHandler:^{
                          
                          failureHandler();
                          
                      }];
    
}

+(void)callAddFacebookFriendsWithUser:(NSString *)userId
                        withFriendIds:(NSString *)friends
                withComplitionHandler:(void(^)(id result))completionHandler
                    withFailueHandler:(void(^)(void))failureHandler
{
    //userid, fbids
    //parameters =  ,  (comma separated)
    //
    
    [RestCall callWebServiceWithTheseParams:@{@"userid":[NSString stringWithFormat:@"%d",[userId intValue]],
                                              @"fbids":friends}
                      withSignatureSequence:nil
                                 urlCalling:
     [baseServiceUrl stringByAppendingString:@"FlpUserFriends/addsocialfriends.json"]
                              isPostService:YES
                      withComplitionHandler:^(id result) {
                          
                          @try {
                              id message = [result objectForKey:@"message"];
                              if ([message isKindOfClass:[NSArray class]]) {
                                  
                                  if ([message count] == 0 ) {
                                      
                                      failureHandler();
                                      
                                  }
                              }
                              else if ([[message objectForKey:@"status"] isEqualToString:@"Success"]) {
                                  
                                  id data = [message objectForKey:@"data"];
                                  
                                  completionHandler(data);
                                  
                              }
                              
                              else{
                                  
                                  completionHandler(nil);
                                  
                              }
                              
                              
                              
                              
                          }
                          @catch (NSException *exception) {
                              
                              failureHandler();
                              
                          }
                          
                          
                      } failureComlitionHandler:^{
                          
                          failureHandler();
                          
                      }];
    
    
}

+(void)callRemoveFriendsWith:(NSString *)userId
                             withFriendIds:(NSString *)friendId
                         ComplitionHandler:(void(^)(id result))completionHandler
                         withFailueHandler:(void(^)(void))failureHandler
{
    //userid , requestid
    [RestCall callWebServiceWithTheseParams:@{@"requestid":[NSString stringWithFormat:@"%d",[friendId intValue]],
                                              @"userid":[NSString stringWithFormat:@"%d",[userId intValue]]}
                      withSignatureSequence:nil
                                 urlCalling:
     [baseServiceUrl stringByAppendingString:@"FlpUserFriends/delete.json"]
                              isPostService:YES
                      withComplitionHandler:^(id result) {
                          
                          @try {
                              
                              id message = [result objectForKey:@"message"];
                              if ([message isKindOfClass:[NSArray class]]) {
                                  
                                  if ([message count] == 0 ) {
                                      
                                      failureHandler();
                                      
                                  }
                              }
                              else if ([[message objectForKey:@"status"] isEqualToString:@"Success"]) {
                                  
                                  id data = [message objectForKey:@"data"];
                                  
                                  completionHandler(data);
                                  
                              }
                              
                              else{
                                  
                                  completionHandler(nil);
                                  
                              }
                              
                              
                              
                              
                          }
                          @catch (NSException *exception) {
                              
                              failureHandler();
                              
                          }
                          
                          
                      } failureComlitionHandler:^{
                          
                          failureHandler();
                          
                      }];
    
    
}


+(void)callForgetPasswordWithEmail:(NSString *)email
           complitionHandler:(void(^)(id result))completionHandler
           withFailueHandler:(void(^)(void))failureHandler
{
    //userid , requestid
    [RestCall callWebServiceWithTheseParams:@{@"email":email}
                      withSignatureSequence:nil
                                 urlCalling:
     [baseServiceUrl stringByAppendingString:@"ForgotPassword"]
                              isPostService:YES
                      withComplitionHandler:^(id result) {
                          
                          @try {
                              
                              id message = [[result objectForKey:@"message"] objectForKey:@"status"];
                             if ([message isEqualToString:@"Success"]) {
                                  
                                  id data = [[result objectForKey:@"message"] objectForKey:@"Data"];
                                  
                                  completionHandler(data);
                                  
                              }
                              
                              else{
                                  
                                  completionHandler(nil);
                                  
                              }
                              
                              /*message = "Given Email Id Not Found In Database";
                               status 
                                message = "Email sent to user successfully";
                               */
                              
                              
                          }
                          @catch (NSException *exception) {
                              
                              failureHandler();
                              
                          }
                          
                          
                      } failureComlitionHandler:^{
                          
                          failureHandler();
                          
                      }];
    
    
}

+(void)callCheckUserExistsWithEmail:(NSString *)email
                 complitionHandler:(void(^)(id result))completionHandler
                 withFailueHandler:(void(^)(void))failureHandler
{
    //userid , requestid
    [RestCall callWebServiceWithTheseParams:@{@"email":email}
                      withSignatureSequence:nil
                                 urlCalling:
     [baseServiceUrl stringByAppendingString:@"ValidateEmail"]
                              isPostService:YES
                      withComplitionHandler:^(id result) {
                          
                          @try {
                              
                              id message = [[result objectForKey:@"message"] objectForKey:@"status"];
                              if ([message isEqualToString:@"Success"]) {
                                  
                                  id data = [[result objectForKey:@"message"] objectForKey:@"Data"];
                                  
                                  completionHandler(data);
                                  
                                  
                              }
                              else{
                                  
                                  failureHandler();
                                  
                              }
                              

                              
                              
                          }
                          @catch (NSException *exception) {
                              
                              failureHandler();
                              
                          }
                          
                          
                      } failureComlitionHandler:^{
                          
                          failureHandler();
                          
                      }];
    
    
}


+(void)callChangeUserPasswordWithUserId:(NSString *)userId
                        withOldPassword:(NSString *)oldPassword
                        withNewPassword:(NSString *)newPassword
                  complitionHandler:(void(^)(id result))completionHandler
                  withFailueHandler:(void(^)(void))failureHandler
{
    //userid , requestid
    
    [RestCall callWebServiceWithTheseParams:@{@"userid":[NSString stringWithFormat:@"%d",[userId intValue] ],@"oldpassword":oldPassword,@"newpassword":newPassword}
                      withSignatureSequence:nil
                                 urlCalling:
     [baseServiceUrl stringByAppendingString:@"FlpUsers/updatepassword.json"]
                              isPostService:YES
                      withComplitionHandler:^(id result) {
                          
                          @try {
                              
                              id message = [result objectForKey:@"message"];
                              if ([message isKindOfClass:[NSArray class]]) {
                                  
                                  if ([message count] == 0 ) {
                                      
                                      failureHandler();
                                      
                                  }
                              }
                              else{
                                  
                                  id data = [message objectForKey:@"message"];
                                  
                                  if ([data isEqualToString:@"Password Updated"]) {
                                      completionHandler(@"Password Updated");
                                      
                                  }
                                  else
                                  completionHandler(@"Invalid Password");
                                  
                              }
                              
                              
                              
                              
                          }
                          @catch (NSException *exception) {
                              
                              failureHandler();
                              
                          }
                          
                          
                      } failureComlitionHandler:^{
                          
                          failureHandler();
                          
                      }];
    
    
}

//http://check-ball.plego.net/CheckBallService.svc/GetListing/T/10011
///http://check-ball.plego.net/CheckBallService.svc/GetListing/P/10011



+(void)callGetPlayersWithZipCode:(NSString *)myZipCode WithComplitionHandler:(void(^)(id result))completionHandler withFailueHandler:(void(^)(void))failureHandler
{
    
    
    [RestCall callWebServiceWithTheseParams:nil
                      withSignatureSequence:nil
                                 urlCalling:
     [baseServiceUrl stringByAppendingString:[NSString stringWithFormat:@"GetListing/P/%@",myZipCode]]
                              isPostService:NO
                      withComplitionHandler:^(id result) {
                          
                          id message = [result objectForKey:@"message"];
                          
                          
                          NSString * status = [message objectForKey:@"status"];
                          
                          
                          if ([status isEqualToString:@"Success"]) {
                              
                              id list = [message objectForKey:@"Data"];
                              
                              completionHandler(list);
                          }
                          else if ([status isEqualToString:@"Failure"] & [[message allKeys] containsObject:@"Error"]) {
                              
                              //[[message allKeys] containsObject:@"Error"]
                              
                              
                              if ([[message  objectForKey:@"Error"] isEqualToString:@"List Not Found"]) {
                                  
                                  completionHandler(nil);
                                  
                              }
                              else {
                                  
                                  failureHandler();
                              }
                              
                              
                          }
                          else {
                              
                              failureHandler();
                              
                          }
                          
                          
                          
                          
                          
                          NSLog(@"");
                          
                          
                          
                      } failureComlitionHandler:^{
                          failureHandler();
                          
                          
                          
                      }];
    
    
}



+(void)callGetTrainersWithZipCode:(NSString *)myZipCode WithComplitionHandler:(void(^)(id result))completionHandler withFailueHandler:(void(^)(void))failureHandler
{
    
    
    [RestCall callWebServiceWithTheseParams:nil
                      withSignatureSequence:nil
                                 urlCalling:
     [baseServiceUrl stringByAppendingString:[NSString stringWithFormat:@"GetListing/T/%@",myZipCode]]
                              isPostService:NO
                      withComplitionHandler:^(id result) {
                          
                          id message = [result objectForKey:@"message"];
                          
                          
                          NSString * status = [message objectForKey:@"status"];
                          
                          
                          if ([status isEqualToString:@"Success"]) {
                              
                              id list = [message objectForKey:@"Data"];
                              
                              completionHandler(list);
                          }
                          else if ([status isEqualToString:@"Failure"] & [[message allKeys] containsObject:@"Error"]) {
                              
                              //[[message allKeys] containsObject:@"Error"]
                              
                              
                              if ([[message  objectForKey:@"Error"] isEqualToString:@"List Not Found"]) {
                                  
                                  completionHandler(nil);
                                  
                              }
                              else {
                               
                                    failureHandler();
                              }
                              

                          }
                          
                          else {
                              
                              failureHandler();
                              
                          }
                          
                          
                          
                          
                          
                          NSLog(@"");
                          
                          
                          
                      } failureComlitionHandler:^{
                          failureHandler();
                          
                          
                          
                      }];
    
    
}


+(void)callGetSpecialitesWithComplitionHandler:(void(^)(id result))completionHandler withFailueHandler:(void(^)(void))failureHandler
{

    [RestCall callWebServiceWithTheseParams:nil
                      withSignatureSequence:nil
                                 urlCalling:
     [baseServiceUrl stringByAppendingString:@"getspecilities"]
                              isPostService:NO
                      withComplitionHandler:^(id result) {
                          
                              id message = [result objectForKey:@"message"];
                          
                          
                          NSString * status = [message objectForKey:@"status"];
                          
                          
                          if ([status isEqualToString:@"Success"]) {
                              
                              id list = [message objectForKey:@"Data"];
                           
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

+(void)callGetUserProfileById:(NSString *)profileId
        WithComplitionHandler:(void(^)(id result))completionHandler withFailueHandler:(void(^)(void))failureHandler
{

    int tmpID = [profileId intValue];
    
   
    [RestCall callWebServiceWithTheseParams:nil
                      withSignatureSequence:nil
                                 urlCalling:
     [baseServiceUrl stringByAppendingString:[@"getprofile/" stringByAppendingString: [NSString stringWithFormat:@"%d",tmpID]]]
                              isPostService:NO
                      withComplitionHandler:^(id result) {
                          result = [result objectForKey:@"message"];
                          
                          
                          NSString * status = [result objectForKey:@"status"];
                          
                          
                          if ([status isEqualToString:@"Success"]) {
                              
                              //id list = [result objectForKey:@"Data"];
                              
                              id videos = [result objectForKey:@"Videos"];
                              id specilities = [result objectForKey:@"Specilities"];
                              id locations = [result objectForKey:@"Locations"];
                              id account = [result objectForKey:@"Account"];
                              
                              
                              completionHandler(@{@"Videos":videos,@"Specialites": specilities,@"Location":locations,@"Account":account});
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
