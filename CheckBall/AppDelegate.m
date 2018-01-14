//
//  AppDelegate.m
//  CheckBall
//
//  Created by Tauqeer Ahmed on 11/22/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //SignUpStoryboard
    
    NSUserDefaults *currentUserDefault = [NSUserDefaults standardUserDefaults];
    
    id isFirstTimeRunDone = [currentUserDefault objectForKey:@"isFirstTimeSignUp"];
    
    
    
    
    
    
    
    if (!isFirstTimeRunDone){
        
   ///Users/tauqeer/Work/CheckBall/CheckBall/ViewControllers/PlayerDashboardViewController.m
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
        initViewController = [storyBoard instantiateViewControllerWithIdentifier:@"RooTView"];
        self.window.rootViewController = initViewController;
        
        
        
    }
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
