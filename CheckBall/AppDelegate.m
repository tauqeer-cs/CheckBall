//
//  AppDelegate.m
//  CheckBall
//
//  Created by Tauqeer Ahmed on 11/22/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //SignUpStoryboard
    
    NSUserDefaults *currentUserDefault = [NSUserDefaults standardUserDefaults];
    
    id isFirstTimeRunDone = [currentUserDefault objectForKey:@"isFirstTimeSignUp"];
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    
    [GMSServices provideAPIKey:@"AIzaSyCFNgBaMKeIuuncWFZ1nZmbBta7w0ajKTM"];

    
    
    
    if (!isFirstTimeRunDone){
        

        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"SignUpStoryboard" bundle:nil];
        UIViewController *initViewController;
        initViewController = [storyBoard instantiateViewControllerWithIdentifier:@"ViewController"];
        self.window.rootViewController = initViewController;
     
        return YES;
        
    }
    NSString * accountType = [isFirstTimeRunDone objectForKey:@"Account_Type"];
   
    if ([accountType isEqualToString:@"P"]) {
        
    }
    else {
        

        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MainTrainer" bundle:nil];
        UIViewController *initViewController;
        initViewController = [storyBoard instantiateViewControllerWithIdentifier:@"TapBarView"];
        self.window.rootViewController = initViewController;
        
        
        
        [self registerForRemoteNotifion];
        
        
    }
    
    return YES;
}



- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:sourceApplication
                                                               annotation:annotation
                    ];
    // Add any custom logic here.
    return handled;
}

-(void)registerForRemoteNotifion{
    
    //
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(isRegisteredForRemoteNotifications)]){
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        
    }
    else{
        
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound];
        
    }
    
    
    
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:
(NSData *)deviceToken {
    
    [deviceToken description];
    
    NSUserDefaults *defauls = [NSUserDefaults standardUserDefaults];
    
    
    NSString *tokenToSend =     [[[[deviceToken description]
                                   stringByReplacingOccurrencesOfString:@"<"withString:@""]
                                  stringByReplacingOccurrencesOfString:@">" withString:@""]
                                 stringByReplacingOccurrencesOfString: @" " withString: @""];
    [defauls setObject:tokenToSend forKey:@"deviceToken"];
    
    
    
    NSLog(@"%@",tokenToSend);
    
    //self.tokenToSend = tokenToSend;
    
    
}






@end
