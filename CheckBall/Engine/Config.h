//
//  Config.h
//  GChat
//
//  Created by Tauqeer on 2014-09-26.
//  Copyright (c) 2014 Carlin. All rights reserved.
//

#import <Foundation/Foundation.h>
//http:///pingem/api/vendor/create-vendor-from-user



///CheckBallService.svc/getlisting/p/75300
#define baseServiceUrl (isLive) ? @"http://check-ball.plego.net/CheckBallService.svc/" : @"http://check-ball.plego.net/CheckBallService.svc/"
//http://main.iamkarachiapp.com/api/
#define baseImageLink (isLive) ? @"http://check-ball.plego.net/Images/DP/" : @"http://check-ball.plego.net/Images/DP/"
#define serviceLink (isLive) ? @"http://check-ball.plego.net/CheckBallService.svc/" : @"http://check-ball.plego.net/CheckBallService.svc/"
//define serviceLink (isLive) ? @"http://beta.iamkarachiapp.com/" : @"http://dev.iamkarachiapp.com/"
//http://main.iamkarachiapp.com/
#define serviceStart (isLive) ? @"api/" : @"api/"


#define serviceSalt @"ad17e4a5dc70dc6aaf4f4a7d0cab8b41"
#define showRegisterationCode 0
#define isLive 0


#define FontToUseBold @"VistaSlabOT-Bold"
#define FontToUseRegular @"VistaSlabOT-Reg"
#define FontToUseLightItalic @"VistaSlabOT-LightItalic"
#define FontToUserBlack @"VistaSlabOT-Black"
#define FontToUserBook @"VistaSlabOT-Book"
#define FontToUserMedium @"VistaSlabOT-Medium"

#define ArboriaSemiBold @"Raleway-SemiBold"
#define ArboriaBook @"Raleway-Regular"
#define ArboriaMedium @"Raleway-Medium"
#define ArboriaBold @"Raleway-Bold"
#define ArboriaBlack @"Raleway-ExtraBold"


//








#define ParkAndLevelFont [UIFont fontWithName:FontToUserMedium size:27]

#define ParkAndLevelFontColor [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0]


#define HomeViewQuestionFont [UIFont fontWithName:FontToUserBlack size:50]
#define HomeViewQuestionFontColor [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]

#define SelectLevelWelcomeToFont [UIFont fontWithName:FontToUserBlack size:29]
#define SelectLevelNameFont [UIFont fontWithName:FontToUserBlack size:39]
#define SelectLevelTextFont [UIFont fontWithName:ArboriaSemiBold size:21]


#define QuestionFont [UIFont fontWithName:ArboriaBook size:28]
#define QuestionFontColor [UIColor colorWithRed:35.0/255.0 green:31.0/255.0 blue:32.0/255.0 alpha:1.0]
#define QuestionViewBottomButtonFonts [UIFont fontWithName:FontToUseBold size:20]

#define AnswerYouFoundFont [UIFont fontWithName:FontToUserMedium size:20]
#define AnswerFontColor [UIColor colorWithRed:1 green:1 blue:1 alpha:1.0]
#define AnswerTitleFont [UIFont fontWithName:FontToUserBlack size:26]
#define AnswerDescriptionFont [UIFont fontWithName:ArboriaBold size:18]


#define ScoreViewCongratsFont [UIFont fontWithName:FontToUserBlack size:50]
#define ScoreViewYouveCompletedFont [UIFont fontWithName:FontToUserBlack size:27]
#define ScoreViewPlaceFont [UIFont fontWithName:FontToUserBlack size:40]
#define ScoreYourScoreFont [UIFont fontWithName:FontToUserBlack size:33]
#define ScoreScoreFont [UIFont fontWithName:FontToUserBlack size:80]
#define ScoreYouRAFont [UIFont fontWithName:FontToUserBlack size:30]


#define ProfileViewYouAreA [UIFont fontWithName:FontToUseBold size:23]
#define ProfileViewTotalPointsLabelFont [UIFont fontWithName:FontToUserBlack size:22]
#define ProfileViewTotalPointsScoreFont [UIFont fontWithName:FontToUseBold size:122]
#define ProfileViewLevelScoreFont [UIFont fontWithName:FontToUserBlack size:31]
#define ProfileViewLevelScoreRegularFont [UIFont fontWithName:FontToUseRegular size:31]
#define LightGreenTextColor [UIColor colorWithRed:173.0/255.0 green:209.0/255.0 blue:68.0/255.0 alpha:1.0]

#define ProfileViewGrayColor [UIColor colorWithRed:182.0/255.0 green:183.0/255.0 blue:183.0/255.0 alpha:1.0]


#define MapRegularTextFont [UIFont fontWithName:FontToUserMedium size:18]
#define MapBoldTextFont [UIFont fontWithName:FontToUserBlack size:20]

#define RulesRegularTextFont [UIFont fontWithName:FontToUserMedium size:17]
#define RulesBoldTextFont [UIFont fontWithName:FontToUseBold size:21]

#define HintBoldFont [UIFont fontWithName:FontToUseBold size:34]
#define HintRegularFont [UIFont fontWithName:FontToUseBold size:18]


#define BonusViewQuestionFont [UIFont fontWithName:FontToUseBold size:25]
#define BonusViewTextFont [UIFont fontWithName:FontToUseBold size:35]

#define BonusPointsCongratsViewNumberFont [UIFont fontWithName:FontToUseBold size:68]
#define BonusPointsCongratsViewCongratsFont [UIFont fontWithName:FontToUseBold size:26]


//

#define getFunchtionName @"function_news.php"
#define IS_IOS_6 ([[[UIDevice currentDevice] systemVersion] floatValue])
#define IS_IPHONE ( [[[UIDevice currentDevice] model] isEqualToString:@"iPhone"]  || [[[UIDevice currentDevice] model] isEqualToString:@"iPhone Simulator"])
#define IS_IPad ( [[[UIDevice currentDevice] model] isEqualToString:@"iPad"]  || [[[UIDevice currentDevice] model] isEqualToString:@"iPad Simulator"])
#define IS_IPOD   ( [[[UIDevice currentDevice ] model] isEqualToString:@"iPod touch"] )
#define IS_HEIGHT_GTE_568 [[UIScreen mainScreen ] bounds].size.height == 568.0f
#define IS_HEIGHT_GTE_4 [[UIScreen mainScreen ] bounds].size.height == 480.0f
#define IS_HEIGHT_GTE_667 [[UIScreen mainScreen ] bounds].size.height == 667.0f
#define IS_HEIGHT_GTE_736 [[UIScreen mainScreen ] bounds].size.height == 736.0f

#define IS_IPHONE_5 ( IS_IPHONE && IS_HEIGHT_GTE_568 )
#define IS_IPHONE_6 ( IS_IPHONE && IS_HEIGHT_GTE_667 )
#define IS_IPHONE_6P ( IS_IPHONE && IS_HEIGHT_GTE_736 )
#define IS_IPHONE_4S ( IS_IPHONE && IS_HEIGHT_GTE_4 )
#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)
#define IS_OS_5_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)
#define IS_OS_6_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define IS_OS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IS_OS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IS_OS_9_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define IS_IOS8     ([[UIDevice currentDevice].systemVersion compare:@"8.0" options:NSNumericSearch] != NSOrderedAscending)

#define IPHONE4S_RATIO 1.252
#define IPHONE5_RATIO 1.038
#define   IsIphone5     ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IPHONE4S @"iphone4s"
#define IPHONE5 @"iphone5"
#define IPAD @"ipad"
#define IPAD_RETINA @"ipadretina"
#define HeadingFontName @"HelveticaNeue-CondensedBold"
#define ASSET_BY_SCREEN_HEIGHT(regular, longScreen) (([[UIScreen mainScreen] bounds].size.height <= 480.0) ? regular : longScreen)
#define INTERNET_INAVAILABLE_MSG @"Internet has not been detected on your device. Please check your internet settings again to proceed!"
#define SOMETHING_WENT_WRONG_MSG @"Something went wrong while fetching your request. Please try again later!"
#define FEATURE_FEED_ERROR_MSG @"Something went wrong while fetching the Kurfuffls. Please try again later"
#define FEED_CELL_CUSTOM_MSG @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
#define LOCATION_OFF_QIBLA @"Turn on your Location Service for getting corrent direction."
#define LOCATION_OFF_PLAYER @"Turn on your Location Service for getting accurate Player Timings."
//IS_IPHONE_4S ? @"FriendsRadarWizard4" : @"FriendsRadarWizard"
// Text View Sizes
#define FEEDCELL_TEXT_VIEW_SIZE CGSizeMake(205, 12)

// Color From Hex
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]
#define toRad(X) (X*M_PI/180.0)
#define toDeg(X) (X*180.0/M_PI)
#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f

#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width

#define X(v)                    (v).frame.origin.x
#define Y(v)                    (v).frame.origin.y
#define WIDTH(v)                (v).frame.size.width
#define HEIGHT(v)               (v).frame.size.height

#define MinX(v)                 CGRectGetMinX((v).frame)
#define MinY(v)                 CGRectGetMinY((v).frame)

#define MidX(v)                 CGRectGetMidX((v).frame)
#define MidY(v)                 CGRectGetMidY((v).frame)

#define MaxX(v)                 CGRectGetMaxX((v).frame)
#define MaxY(v)                 CGRectGetMaxY((v).frame)


#define RECT_CHANGE_x(v,x)          CGRectMake(x, Y(v), WIDTH(v), HEIGHT(v))
#define RECT_CHANGE_y(v,y)          CGRectMake(X(v), y, WIDTH(v), HEIGHT(v))
#define RECT_CHANGE_point(v,x,y)    CGRectMake(x, y, WIDTH(v), HEIGHT(v))
#define RECT_CHANGE_width(v,w)      CGRectMake(X(v), Y(v), w, HEIGHT(v))
#define RECT_CHANGE_height(v,h)     CGRectMake(X(v), Y(v), WIDTH(v), h)
#define RECT_CHANGE_size(v,w,h)     CGRectMake(X(v), Y(v), w, h)

#define REGEX_USER_NAME_LIMIT @"^.{3,10}$"
#define REGEX_USER_NAME @"[A-Za-z0-9]{3,10}"
#define REGEX_EMAIL @"[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define REGEX_PASSWORD_LIMIT @"^.{6,20}$"
#define REGEX_PASSWORD @"[A-Za-z0-9]{6,20}"
#define REGEX_PHONE_DEFAULT @"[0-9]{3}\\-[0-9]{3}\\-[0-9]{4}"
#define REGEX_WEB_URL @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"

#define TIMER_INTERVAL 0.05
#define VIDEO_FOLDER @"videoFolder"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface Config : NSObject

@end
