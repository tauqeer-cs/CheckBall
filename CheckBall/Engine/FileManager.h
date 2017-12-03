//
//  FileManager.h
//  
//
//  Created by Tauqeer on 2014-10-17.
//  Copyright (c) 2014 Tauqeer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface FileManager : NSObject

+(void)saveProfileImageToDisk :(NSData *)imageToSave fileName:(NSString *)fileName;

+(UIImage *)getImage:(NSString *)directory;

+(NSString *)saveImageToDisk :(UIImage *)imageToSave;
+(NSString*)generateRandomString:(int)num;
+(void)saveProfileImageToDisk :(NSData *)imageToSave fileName:(NSString *)fileName;
+(BOOL )fileExistsAtPath:(NSString *)directory;

+(void)loadImage : (UIImage *)imageToBeLoaded;
+(void)loadProfileImage : (UIImageView *)imageToBeLoaded url:(NSString *)urlToLoad;
+(void)loadProfileImageToButton : (UIButton *)button :(NSString *)urlToLoad loader:(UIActivityIndicatorView *)loader;
+(UIImage *)loadProfileImageFromUrl:(NSString *)urlToLoad;
+(UIImage *)loadCoverImageFromurl:(NSString *)urlToLoad;

+(void)loadLandmarkImage : (UIImageView *)imageToBeLoaded
                   url:(NSString *)urlToLoad;

+(void)giveProfileImage : (UIImageView *)imageToBeLoaded url:(NSString *)urlToLoad;

+(void)loadCoverImage : (UIImageView *)imageToBeLoaded
                   url:(NSString *)urlToLoad loader:(UIActivityIndicatorView *)loader withFrameHeight:(int)frameHeight withFrameWidth:(int)frameWidth;

+(void)loadProfileImage : (UIImageView *)imageToBeLoaded url:(NSString *)urlToLoad loader:(UIActivityIndicatorView *)loader;

+(void)loadReportTypeImage : (UIImageView *)imageToBeLoaded
                        url:(NSString *)urlToLoad loader:(UIActivityIndicatorView *)loader;

+(void)loadCityVoiceImage : (UIImageView *)imageToBeLoaded
                       url:(NSString *)urlToLoad loader:(UIActivityIndicatorView *)loader;
+(UIImage *)loadCityVoiceImageFromurl:(NSString *)urlToLoad;

//// Events

+(BOOL )fileEventExistsAtPath:(NSString *)directory;

+(void)saveEventImageToDisk :(NSData *)imageToSave fileName:(NSString *)fileName;

+(void)loadEventImage : (UIImageView *)imageToBeLoaded
                   url:(NSString *)urlToLoad loader:(UIActivityIndicatorView *)loader;



+(void)loadDirectoryImage : (UIImageView *)imageToBeLoaded
                       url:(NSString *)urlToLoad loader:(UIActivityIndicatorView *)loader;

+(void)loadEventMediaImage : (UIImageView *)imageToBeLoaded
                        url:(NSString *)urlToLoad loader:(UIActivityIndicatorView *)loader;

/*
+(void)loadFeedsImage : (UIImageView *)imageToBeLoaded
                   url:(NSString *)urlToLoad loader:(UIActivityIndicatorView *)loader;
*/

+(void)loadFeedsImage : (UIImageView *)imageToBeLoaded
                   url:(NSString *)urlToLoad loader:(UIActivityIndicatorView *)loader withFinalWidt:(int)width height:(int)height removeView:(UIView *)removingView;

+(UIImage*) scaleImage:(UIImage*)image toSize:(CGSize)newSize ;
+(void)loadFeedsLogoImage : (UIImageView *)imageToBeLoaded
                       url:(NSString *)urlToLoad loader:(UIActivityIndicatorView *)loader withFinalWidt:(int)width height:(int)height;

+(UIImage *)loadFeedsImageurl:(NSString *)urlToLoad;

+(void)loadBackgroundImage : (UIImageView *)imageToBeLoaded
                        url:(NSString *)urlToLoad loader:(UIActivityIndicatorView *)loader
      withComplitionHandler:(void(^)(void))completionHandler;
+(BOOL)ifBackgroundImageExistsUrl:(NSString *)urlToLoad;
+(UIImage *)BackgroundFromUrl:(NSString *)urlToLoad;

+(void)loadWeathImage : (UIImageView *)imageToBeLoaded
                   url:(NSString *)urlToLoad loader:(UIActivityIndicatorView *)loader;

+(void)loadScripterImage : (UIImageView *)imageToBeLoaded
                      url:(NSString *)urlToLoad loader:(UIActivityIndicatorView *)loader;



+(void)loadAssetImageWithCountry : (NSString *)country
                              url:(NSString *)urlToLoad
            withComplitionHandler:(void(^)(void))completionHandler
               withFailureHandler:(void(^)(void))failHandler;

+(void)loadAssetAudioWithCountry : (NSString *)country
                              url:(NSString *)urlToLoad
            withComplitionHandler:(void(^)(void))completionHandler
               withFailureHandler:(void(^)(void))failHandler;

+(void)loadAssetVideoWithCountry : (NSString *)country
                              url:(NSString *)urlToLoad
            withComplitionHandler:(void(^)(void))completionHandler
               withFailureHandler:(void(^)(void))failHandler;

+(void)loadAssetOtherWithCountry : (NSString *)country
                              url:(NSString *)urlToLoad
            withComplitionHandler:(void(^)(void))completionHandler
               withFailureHandler:(void(^)(void))failHandler;


+(void)getAssetAudioWithUrl:(NSString *)urlToLoad
      withComplitionHandler:(void(^)(NSString * path))completionHandler
         withFailureHandler:(void(^)(void))failHandler;

+(void)getAssetVideoWithUrl:(NSString *)urlToLoad
      withComplitionHandler:(void(^)(NSString * path))completionHandler
         withFailureHandler:(void(^)(void))failHandler;


+(void)loadAssetImageWithImageView:(UIImageView *)imageView
                               url:(NSString *)urlToLoad
             withComplitionHandler:(void(^)(void))completionHandler
                withFailureHandler:(void(^)(void))failHandler;

+(void)loadLandmarkImageByHeight : (UIImageView *)imageToBeLoaded
                              url:(NSString *)urlToLoad;

+(UIImage *)loadLandmarkImageFromurl:(NSString *)urlToLoad;
+(void)loadVendorImage : (UIImageView *)imageToBeLoaded
                    url:(NSString *)urlToLoad loader:(UIActivityIndicatorView *)loader
  withComplitionHandler:(void(^)(void))completionHandler;


+(void)loadAssetWithUrl:(NSString *)urlToLoad
         withFolderName:(NSString *)folderName
   withFileIndexLoading:(int)index
  withComplitionHandler:(void(^)(id))completionHandler
         withFailHander:(void(^)(int))failureHandler;
+(void)loadImageFromurl:(NSString *)urlToLoad  withComplitionHandler:(void(^)(id))completionHandler
         withFailHander:(void(^)(int))failureHandler;
+(UIImage *)loadNotSynceImageFromurl:(NSString *)urlToLoad;

+(NSString *)loadVideosNotSynceImageFromurl:(NSString *)urlToLoad;

+(NSString *)asyncLoadVideosNotSynceImageFromurl:(NSString *)urlToLoad;
+(void)loadDataFromurl:(NSString *)urlToLoad  withComplitionHandler:(void(^)(id))completionHandler
        withFailHander:(void(^)(int))failureHandler;

+(void)loadProfileImage : (UIImageView *)imageToBeLoaded url:(NSString *)urlToLoad withLoader:(UIActivityIndicatorView *)loader;

+(void)loadProfileImageUrl:(NSString *)urlToLoad withLoader:(UIActivityIndicatorView *)loader  withComplitionHandler:(void(^)(id))completionHandler
            withFailHander:(void(^)(int))failureHandler;
+(UIImage *)getImage;


@end
