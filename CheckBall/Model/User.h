//
//  User.h
//  Filmer
//
//  Created by Tauqeer Ahmed on 3/15/16.
//  Copyright © 2016 Plego. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

+(void)callRegisterUserWithEmail:(NSString *)emailAddress withName:(NSString *)name
                    withPassword:(NSString *)password withMobile:(NSString *)mobile
                    withDeviceId:(NSString *)deviceId
                         withDob:(NSString *)dob
                    withIsSingle:(NSString *)isSingle
                      withGender:(NSString *)gender
                       withImage:(UIImage *)profileImage
           withComplitionHandler:(void(^)(id result))completionHandler withFailueHandler:(void(^)(void))failureHandler
        withAlreadyExistsHandler:(void(^)(id result))alreadyExistHandler;



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


+(void)callChangePasswordWithOldPassword:(NSString *)oldPassword
                         withNewPassword:(NSString *)newPassword
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


+(void)callGetSpecialitesWithComplitionHandler:(void(^)(id result))completionHandler
                             withFailueHandler:(void(^)(void))failureHandler;

+(void)callGetUserProfileById:(NSString *)profileId
        WithComplitionHandler:(void(^)(id result))completionHandler
            withFailueHandler:(void(^)(void))failureHandler;


@end
