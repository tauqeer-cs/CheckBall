//
//  User.h
//  Filmer
//
//  Created by Tauqeer Ahmed on 3/15/16.
//  Copyright © 2016 Plego. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"
#import "Specialities.h"


@interface User : NSObject


@property (nonatomic) int userId;

@property (nonatomic,strong) NSString * accountType;



@property (nonatomic,strong) NSString * name;
@property (nonatomic,strong) NSString * position;
@property (nonatomic,strong) NSString * school;
@property (nonatomic,strong) NSString * bio;

@property (nonatomic,strong) NSString * myEmail;

@property (nonatomic) double height;
@property (nonatomic,strong) NSString * heightStringToShow;
@property (nonatomic,strong) NSString * heightStringToSend;

@property (nonatomic) int weight;
@property (nonatomic,strong) NSString * weightStringToShow;
@property (nonatomic,strong) NSString * zipCode;
@property (nonatomic,strong) NSString * phoneName;

@property (nonatomic) BOOL hasImage;
@property (nonatomic,strong) NSArray <Specialities *>* specialites;

@property (nonatomic,strong) NSMutableArray <NSString *> * videos;


@property (nonatomic,strong) NSString * orignalHeightString;

@property (nonatomic,strong) NSMutableArray <Location *>* locations;

+(void)callRegisterUserWithParams:(NSDictionary *)params
           withComplitionHandler:(void(^)(id result))completionHandler withFailueHandler:(void(^)(void))failureHandler
        withAlreadyExistsHandler:(void(^)(id result))alreadyExistHandler;


+(void)callChangePasswordWithOldPassword:(NSString *)oldPassword
                         withNewPassword:(NSString *)newPassword
                                withMyId:(int)myId
                   withComplitionHandler:(void(^)(id result))completionHandler
                       withFailueHandler:(void(^)(void))failureHandler;



+(void)callLoginUserWithEmail:(NSString *)email withPassword:(NSString *)password
        withComplitionHandler:(void(^)(id result))completionHandler withFailueHandler:(void(^)(void))failureHandler
   withNoAccountExistsHandler:(void(^)(id result))noAccountExistsHandler;
+(void)callCheckFbLoginIdExists:(NSString *)loginId withDoesNotExistsHandler:(void(^)(id result))doesNotExists
              withFailueHandler:(void(^)(void))failureHandler
       withAlreadyExistsHandler:(void(^)(id result))alreadyExistHandler;


+(void)callEditProfileWithEmail:(NSString *)emailAddress
                       withName:(NSString *)name
                        withDob:(NSString *)dob
                   withIsSingle:(NSString *)isSingle
                     withGender:(NSString *)gender
                      withImage:(UIImage *)profileImage
          withComplitionHandler:(void(^)(id result))completionHandler
              withFailueHandler:(void(^)(void))failureHandler
       withAlreadyExistsHandler:(void(^)(id result))alreadyExistHandler;

+(void)callSerchUserWithKeyword:(NSString *)keyword completionHandler:(void(^)(id result))completionHandler
              withFailueHandler:(void(^)(void))failureHandler;

+(void)uploadUserProfileImageWithUserId:(int)userId
                          withUserImage:(UIImage *)imageToUpload
                               withName:(NSString *)name
                              withEmail:(NSString *)email
                        withPhoneNumber:(NSString *)phoneNumber
                  withComplitionHandler:(void(^)(id result))completionHandler
                      withFailueHandler:(void(^)(void))failureHandler;

+(void)updateProfileWithOutImage:(int)userId WithName:(NSString *)name withEmail:(NSString *)email
                       withPhone:(NSString *)phoneNumber
           withComplitionHandler:(void(^)(id result))completionHandler
               withFailueHandler:(void(^)(void))failureHandler;

+(void)callCheckUserContacts:(NSString *)contactEmails
            withPhoneNumbers:(NSString *)phoneNumbers
           completionHandler:(void(^)(id result))completionHandler
           withFailueHandler:(void(^)(void))failureHandler;

+(void)callGetMyFriendsWithUserId:(NSString *)userId
                completionHandler:(void(^)(id result))completionHandler
                withFailueHandler:(void(^)(void))failureHandler;

+(void)callAddFacebookFriendsWithUser:(NSString *)userId
                        withFriendIds:(NSString *)friends
                withComplitionHandler:(void(^)(id result))completionHandler
                    withFailueHandler:(void(^)(void))failureHandler;
+(void)callRemoveFriendsWith:(NSString *)userId
               withFriendIds:(NSString *)friendId
           ComplitionHandler:(void(^)(id result))completionHandler
           withFailueHandler:(void(^)(void))failureHandler;

+(void)callForgetPasswordWithEmail:(NSString *)email
                 complitionHandler:(void(^)(id result))completionHandler
                 withFailueHandler:(void(^)(void))failureHandler;

+(void)callCheckUserExistsWithEmail:(NSString *)email
                  complitionHandler:(void(^)(id result))completionHandler
                  withFailueHandler:(void(^)(void))failureHandler;
+(void)callChangeUserPasswordWithUserId:(NSString *)userId
                        withOldPassword:(NSString *)oldPassword
                        withNewPassword:(NSString *)newPassword
                      complitionHandler:(void(^)(id result))completionHandler
                      withFailueHandler:(void(^)(void))failureHandler;
//

+(void)callLogOut:(NSString *)email
withComplitionHandler:(void(^)(id result))completionHandler
withFailueHandler:(void(^)(void))failureHandler;



+(void)callForgetAccount:(NSString *)email
   withComplitionHandler:(void(^)(id result))completionHandler
       withFailueHandler:(void(^)(void))failureHandler;



+(void)callEditPeriodInfo:(NSString *)dateString
       withNoOfPeriodDays:(int)noOfPeriodDay
   WithmenstrualCycleDays:(int)menstrualCycleDays
    withComplitionHandler:(void(^)(id result))completionHandler
        withFailueHandler:(void(^)(void))failureHandler;

+(void)callContactUs:(NSString *)subject
         withMessage:(NSString *)message
withComplitionHandler:(void(^)(id result))completionHandler
   withFailueHandler:(void(^)(void))failureHandler;

+(void)callCheckGooogleLoginIdExists:(NSString *)loginId
            withDoesNotExistsHandler:(void(^)(id result))doesNotExists
                   withFailueHandler:(void(^)(void))failureHandler
            withAlreadyExistsHandler:(void(^)(id result))alreadyExistHandler;

+(void)callEditProfileWithImage:(UIImage *)profileImage
          withComplitionHandler:(void(^)(id result))completionHandler
              withFailueHandler:(void(^)(void))failureHandler
       withAlreadyExistsHandler:(void(^)(id result))alreadyExistHandler;




+(void)callGetUserProfileById:(NSString *)profileId
        WithComplitionHandler:(void(^)(id result))completionHandler
            withFailueHandler:(void(^)(void))failureHandler;

+(void)callGetPlayersWithZipCode:(NSString *)myZipCode WithComplitionHandler:(void(^)(id result))completionHandler withFailueHandler:(void(^)(void))failureHandler;
+(void)callGetTrainersWithZipCode:(NSString *)myZipCode WithComplitionHandler:(void(^)(id result))completionHandler withFailueHandler:(void(^)(void))failureHandler;

+(void)callUpdateProfileWithParams:(NSDictionary *)params
             withComplitionHandler:(void(^)(id result))completionHandler withFailueHandler:(void(^)(void))failureHandler
          withAlreadyExistsHandler:(void(^)(id result))alreadyExistHandler;
+(void)callUploadProfileWithId:(NSString *)imageId
                 withImageName:(UIImage *)imageName
         withComplitionHandler:(void(^)(id result))completionHandler
             withFailueHandler:(void(^)(void))failureHandler;


+(void)callConnectUserWithMyId:(NSString *)myId
            andUserOtherUserId:(NSString *)otherId
         withComplitionHandler:(void(^)(id result))completionHandler withFailueHandler:(void(^)(void))failureHandler
      withAlreadyExistsHandler:(void(^)(id result))alreadyExistHandler;

-(NSMutableDictionary *)makeParam;

+(void)callLoginUserWithFaceBool:(NSString *)faceboodId
           withComplitionHandler:(void(^)(id result))completionHandler withFailueHandler:(void(^)(void))failureHandler
      withNoAccountExistsHandler:(void(^)(id result))noAccountExistsHandler;

@end
