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

-(NSString *)myEmail{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];;
    if ([[userDefaults objectForKey:@"isFirstTimeSignUp"] isKindOfClass:[NSArray class]]) {
        return [[[userDefaults objectForKey:@"isFirstTimeSignUp"] firstObject] objectForKey:@"Email"];
    }
    return [[userDefaults objectForKey:@"isFirstTimeSignUp"] objectForKey:@"Email"];
    
}

-(NSString *)weightStringToShow{
    
    return [NSString stringWithFormat:@"Weight ( %d lb )",self.weight];
    
}
-(NSString *)heightStringToShow{
    
    NSString * heightShowing ;
    
        if ([self.orignalHeightString intValue] < 10) {

            if ([self.orignalHeightString length] == 1) {
                
                NSLog(@"Height is within 1");
                heightShowing = [NSString stringWithFormat:@"%.01f",self.height];
                
            }
            else if ([self.orignalHeightString length] == 3) {
                
                NSLog(@"Height is within 1");
            heightShowing = [NSString stringWithFormat:@"%.01f",self.height];
                
            }
            else {
                
                heightShowing = [NSString stringWithFormat:@"%.02f",self.height];
                
            }
        }
        else {
            
            if ([self.orignalHeightString length] == 4) {
                
                NSLog(@"Height is within 1");
                heightShowing = [NSString stringWithFormat:@"%.01f",self.height];
                
            }
            else {
                
                heightShowing = [NSString stringWithFormat:@"%.02f",self.height];
                
            }
            
        }
    

    
    
    heightShowing = [heightShowing stringByReplacingOccurrencesOfString:@"." withString:@"\""];
    heightShowing = [heightShowing stringByAppendingString:@"'"];
    heightShowing = [NSString stringWithFormat:@"Height ( %@ )",heightShowing];
    
    return heightShowing;
    
}

-(BOOL)hasImage{
    
    if ([self.phoneName length] == 0) {
        
        return NO;
        
    }
    
    return YES;
}

-(NSMutableArray *)videos{
    
    if (!_videos) {
        
        _videos  = [NSMutableArray new];
        
        
    }
    
    return _videos;
    
}
-(NSMutableArray *)locations{
    if (!_locations) {
        
        _locations  = [NSMutableArray new];
        
        
    }
    return _locations;
    
}

-(NSMutableDictionary *)makeParam{
    
    NSMutableDictionary * paramDictionary = [NSMutableDictionary new] ;
    
    NSMutableDictionary * tmpDictionary = [NSMutableDictionary new];
    
    
    
    
    [tmpDictionary setObject:[NSString stringWithFormat:@"%d",self.userId] forKey:@"ID"];
    [tmpDictionary setObject:self.name forKey:@"Name"];
    [tmpDictionary setObject:self.myEmail forKey:@"Email"];
    [tmpDictionary setObject:self.accountType forKey:@"Account_Type"];
    
    
    [tmpDictionary setObject:self.heightStringToSend forKey:@"Height"];
    
    id tmp = [self.heightStringToSend substringFromString:@"."];
    
    if ([tmp intValue] == 10) {
        
        
        
     
        [tmpDictionary setObject:[NSString stringWithFormat:@"%d.13",[[self.heightStringToSend substringToString:@"."] intValue]] forKey:@"Height"];
        
        
    }
    
    [tmpDictionary setObject:[NSString stringWithFormat:@"%d",self.weight] forKey:@"Weight"];
    [tmpDictionary setObject:self.position forKey:@"Position"];
    [tmpDictionary setObject:self.school forKey:@"School"];
    [tmpDictionary setObject:self.bio forKey:@"Bio"];
    [tmpDictionary setObject:self.zipCode forKey:@"ZipCode"];
    [paramDictionary setObject:@[tmpDictionary] forKey:@"Account"];
    
    
    if ([self.specialites count] > 0)
    {
    
        NSMutableArray * tmpSpecialitesArray = [NSMutableArray new];
     
        //"Specilities":[{"ID":4},{"ID":2},{"ID":1}],

        for (Specialities * currentSpecialites in self.specialites) {
            
            
            [tmpSpecialitesArray addObject:@{@"ID":[NSNumber numberWithInt:currentSpecialites.itemId]}];
            
            
        }
        
        [paramDictionary setObject:tmpSpecialitesArray forKey:@"Specilities"];
        
    }
    else {
        [paramDictionary setObject:@[] forKey:@"Specilities"];
    }
    
    
    NSMutableArray * videosArray = [NSMutableArray new];
    
    
    for (NSString * currentVideo in self.videos) {
        
        [videosArray addObject:
         @{@"Url":currentVideo}];
        
    }
    
    [paramDictionary setObject:videosArray forKey:@"Videos"];
    
    
    
    if ([self.locations count] == 0) {
        
        [paramDictionary setObject:@[] forKey:@"Locations"];
        
    }
    else {
        
        NSMutableArray * tmpLocationArray = [NSMutableArray new];
        
        for (Location * currentLocation in self.locations) {
            
        [tmpLocationArray addObject: @{@"Description":currentLocation.locationDescription,@"Latitude": [NSNumber numberWithFloat:currentLocation.userLatitude],@"Longitude": [NSNumber numberWithFloat:currentLocation.userLongitude]}];
            
            
           

            
            
        }
        
        [paramDictionary setObject:tmpLocationArray forKey:@"Locations"];
        
        
        
    }
 
    return paramDictionary;
    
    
}

+(User *)parseItemFromItem:(id)item{
    
    User *currentItem = [User new];
    
    NSLog(@"");
    
    id accountItem = [[item objectForKey:@"Account"] firstObject];
    currentItem.accountType =  [accountItem objectForKey:@"Account_Type"];
    currentItem.bio =  [accountItem objectForKey:@"Bio"];

    currentItem.orignalHeightString = [accountItem objectForKey:@"Height"];
    
    if ([[currentItem.orignalHeightString substringFromString:@"."] intValue] == 13) {
        
       currentItem.orignalHeightString =  [NSString stringWithFormat:@"%d.10",[[currentItem.orignalHeightString substringToString:@"."] intValue]];
        
        currentItem.height =  [currentItem.orignalHeightString doubleValue];
        
        
    }
    else {
        currentItem.height =  [[accountItem objectForKey:@"Height"] doubleValue];
        
        
    }
    
    //currentItem.heightStringToSend = [NSString stringWithFormat:@""];
    
    currentItem.userId =  [[accountItem objectForKey:@"ID"] intValue];
    
    currentItem.name =  [accountItem objectForKey:@"Name"];
    currentItem.position =  [accountItem objectForKey:@"Position"];
    currentItem.school =  [accountItem objectForKey:@"School"];
    currentItem.weight =  [[accountItem objectForKey:@"Weight"] intValue];
    currentItem.zipCode =  [accountItem objectForKey:@"ZipCode"];
    currentItem.phoneName =  [accountItem objectForKey:@"photo"];
    
    
    
    id locations = [item objectForKey:@"Locations"];
    

    
    for (id currentTmpLocaton in locations)
    {
    
        [currentItem.locations addObject:
         [Location parseItemFromItem:currentTmpLocaton]];
    }
 
    
    id videos = [item objectForKey:@"Videos"];
    
    for (id currentVideo in videos)
    {
        [currentItem.videos addObject:[currentVideo objectForKey:@"Url"]];
    }
    

    currentItem.specialites =   [Specialities parteArray:[item objectForKey:@"Specilities"]];
    
    return currentItem;
    
}




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

+(void)callConnectUserWithMyId:(NSString *)myId
            andUserOtherUserId:(NSString *)otherId
            withComplitionHandler:(void(^)(id result))completionHandler withFailueHandler:(void(^)(void))failureHandler
         withAlreadyExistsHandler:(void(^)(id result))alreadyExistHandler
{
    
    

    
    
    
    
    NSMutableDictionary * tmpConnect = [NSMutableDictionary new];
    [tmpConnect setObject:[NSString stringWithFormat:@"%d",[myId intValue]] forKey:@"IDFrom"];
    [tmpConnect setObject:[NSString stringWithFormat:@"%d",[otherId intValue]] forKey:@"IDTo"];
    
    [RestCall callWebServiceWithTheseParams:tmpConnect
                      withSignatureSequence:nil
                                 urlCalling:
     [baseServiceUrl stringByAppendingString:@"contact"]
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
                                withMyId:(int)myId
   withComplitionHandler:(void(^)(id result))completionHandler
       withFailueHandler:(void(^)(void))failureHandler

{
    
    
    /*
     {"":"3",
     "" : "plego123",
     "" : "plego100",
     "" : "plego100"}
     */
    NSMutableDictionary *currentDictionary = [NSMutableDictionary new];
    [currentDictionary setObject:oldPassword forKey:@"ConfirmPassword"];
    
    
    
    [currentDictionary setObject:newPassword forKey:@"NewPassword"];
    [currentDictionary setObject:oldPassword forKey:@"OldPassword"];
    [currentDictionary setObject:[NSString stringWithFormat:@"%d",myId] forKey:@"ID"];
    
    
    
    
    [RestCall callWebServiceWithTheseParams:currentDictionary
                      withSignatureSequence:nil
                                 urlCalling:
     [baseServiceUrl stringByAppendingString:@"ChangePassword"]
                              isPostService:YES
                      withComplitionHandler:^(id result) {
                          
                          @try {
                              
                              id message = [result
                                            objectForKey:@"status"];
                              
                              if ([message isEqualToString:@"Success"]) {
                                  
                                  completionHandler(@"success");
                                  
                                  
                              }
                              else if ([message isEqualToString:@"Failure"]){
                                  
                                  failureHandler();
                                  
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


+(void)callLoginUserWithFaceBool:(NSString *)faceboodId
        withComplitionHandler:(void(^)(id result))completionHandler withFailueHandler:(void(^)(void))failureHandler
   withNoAccountExistsHandler:(void(^)(id result))noAccountExistsHandler

{
    
    
    NSMutableDictionary *currentDictionary = [NSMutableDictionary new];
    [currentDictionary setObject:faceboodId forKey:@"email"];
    [currentDictionary setObject:@"" forKey:@"password"];
    [currentDictionary setObject:@"FB" forKey:@"LoginBy"];
    
    
    
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
                              
                              
                         
                              
                              completionHandler([self parseItemFromItem:result]);
                              
                          }
                          else {
                              
                              failureHandler();
                              
                          }
                          
                          
                          
                          
                          
                          NSLog(@"");
                          
                          
                          
                      } failureComlitionHandler:^{
                          failureHandler();
                          
                          
                          
                      }];
    
    
}



+(void)callUploadProfileWithId:(NSString *)imageId
                 withImageName:(UIImage *)imageName
         withComplitionHandler:(void(^)(id result))completionHandler
             withFailueHandler:(void(^)(void))failureHandler

{
    
    
    NSData *imageData;
    imageData = UIImageJPEGRepresentation(imageName, 1.0);
    
    
    
    
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST"
                                                                                              URLString:[baseServiceUrl stringByAppendingString:@"UpdatePhoto"] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                                                                                  
                                                                                                  
                                                                                                  
                                                                                                  [formData appendPartWithFileData:imageData name:@"image" fileName:[NSString stringWithFormat:@"%d.jpg",[imageId intValue]] mimeType:@"image/jpeg"];
                                                                                                  
                                                                                                  
                                                                                                  
                                                                                                  
                                                                                                  
                                                                                              } error:nil];
    
    
    
    
    
    
    
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
                              
                              /*
                              if ([[responseObject objectForKey:@"message"] isEqualToString:@"Success"]) {
                                  
                                  
                                  //dataObject =  [dataObject dictionaryByReplacingNullsWithBlanks];
                                  
                                  
                                  
                                  completionHandler(nil);
                                  
                                  
                                  
                                  
                                  //
                              }*/
                              
                              
                          }
                  }];
    
    [uploadTask resume];
    
}





@end
