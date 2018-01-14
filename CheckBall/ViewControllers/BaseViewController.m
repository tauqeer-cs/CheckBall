//
//  BaseViewController.m
//  GChat
//
//  Created by Tauqeer on 2014-09-26.
//  Copyright (c) 2014 Carlin. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"
#import "DateFormatter.h"
#import <AVFoundation/AVFoundation.h>


@import AVKit;




@implementation BaseViewController


- (void)playerViewControllerDidStopPictureInPicture:(AVPlayerViewController *)playerViewController{
    [self hideLoader];
    

[playerViewController dismissViewControllerAnimated:YES completion:^{
    
}];
    

}
-(void)setViewTitle:(NSString *)viewTitle{

    self.viewTitleContainer.backgroundColor =[UIColor clearColor];
    _viewTitle = viewTitle;
}
- (BOOL) isInternetConnectionAvailable
{
    Reachability *internet = [Reachability reachabilityWithHostName: @"www.google.com"];
    NetworkStatus netStatus = [internet currentReachabilityStatus];
    bool netConnection = false;
    switch (netStatus)
    {
        case NotReachable:
        {
            NSLog(@"Access Not Available");
            netConnection = false;
            break;
        }
        case ReachableViaWWAN:
        {
            netConnection = true;
            break;
        }
        case ReachableViaWiFi:
        {
            netConnection = true;
            break;
        }
    }
    return netConnection;
}

-(void)setWhenDidFilesWereDeletedLastTime{
    
    [self.userDefaults setObject:[DateFormatter showDate:[NSDate date] inStringFormate:@"dd-MM-yy"] forKey:@"WhenDidFilesWereDeletedLastTime"];
    
}


-(int)whenDidFilesWereDeletedLastTime{
    
    
    
    return 1;
    
}

-(void)EmptySandbox
{
    
    NSFileManager *fileMgr = [[NSFileManager alloc] init];
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSArray *files = [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:nil];
    
    while (files.count > 0) {
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSArray *directoryContents = [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:&error];
        if (error == nil) {
            for (NSString *path in directoryContents) {
                NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:path];
                BOOL removeSuccess = [fileMgr removeItemAtPath:fullPath error:&error];
                files = [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:nil];
                if (!removeSuccess) {
                    // Error
                }
            }
        } else {
            // Error
        }
    }
}

-(NSString *)salt{
    
    return serviceSalt;
    
}

+(NSString *)giveServiceSalt{
    
    return serviceSalt;
    
}
-(NSUserDefaults *)userDefaults
{
    
    if (!_userDefaults) {
         _userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return _userDefaults;
}


-(void)topImageViewTapped{
    
}

-(void)mainMenuButtonTapped{
    
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
-(void)addTopBarButtonByCode {
    
    //
    
    UIBarButtonItem *flipButton = [[UIBarButtonItem alloc]
                                   initWithImage:[UIImage imageNamed:@"menu-icon"]
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(showMenuViewController)];
    self.navigationItem.rightBarButtonItem = flipButton;
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
    
    

}






-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
 
         [self.navigationController setNavigationBarHidden:NO animated:YES];

}



-(void)topBarButtonTapped{
    
    NSLog(@"Top Bar Button Tapped");
    

    
    id currentSearch = [self viewControllerFromStoryBoard:@"Main" withViewControllerName:@"SelectCityViewController"];
    [self.navigationController pushViewController:currentSearch animated:YES];
}
-(void)btnLocationTapped{
    
    id currentSearch = [self viewControllerFromStoryBoard:@"Main" withViewControllerName:@"MapViewController"];
    
    
    if ([self isKindOfClass:[currentSearch class]]) {
        return;
    }
    
    [self.navigationController pushViewController:currentSearch animated:YES];
}







-(void)setMyMap{

    
    
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
















-(void)showAlert:(NSString *)title message:(NSString *)currentMessage
{
    
    if ([currentMessage isKindOfClass:[NSArray class]]) {
        
        NSString * result = [[currentMessage valueForKey:@"id"] componentsJoinedByString:@","];
        currentMessage = result;
        
    }
    if (IS_IOS8) {
        UIAlertView *ErrorAlert = [[UIAlertView alloc]
                                   initWithTitle:title
                                   message:currentMessage
                                   delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil, nil];
        ErrorAlert.tag = 0;
        ErrorAlert.delegate = self;
        [ErrorAlert show];
        return;
    }

    UIAlertController *myAlertController = [UIAlertController alertControllerWithTitle:title
                                                                               message: currentMessage
                                                                        preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [myAlertController dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    [myAlertController addAction: ok];
    [self presentViewController:myAlertController animated:YES completion:nil];
    
}

-(void)showAlert:(NSString *)title message:(NSString *)currentMessage customTag:(int)currentTag
{
        UIAlertView *ErrorAlert = [[UIAlertView alloc] initWithTitle:title
                                                             message:currentMessage
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil, nil];
        ErrorAlert.tag = currentTag;
        ErrorAlert.delegate = self;
        [ErrorAlert show];
  
    return;
   
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
	return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
	return NO;
}




-(void)CallCreateNewChainView{
    UIViewController *desination = [self viewControllerFromStoryBoard:@"CreateVideo" withViewControllerName:@"SelectetChainTitleViewController"];
    
    
    [self.navigationController pushViewController:desination
                                         animated:YES];
    
}


-(AppDelegate *)sharedDelegate{
    
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
}

-(NSString *)myCountryCode{
    
    NSUserDefaults *defaults;
    defaults = [NSUserDefaults standardUserDefaults];
    NSString *countryCode = [defaults objectForKey:@"phoneCode"];
    
    if (!countryCode) {
        return @"0";
        
    }
    return countryCode;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    if (motion == UIEventSubtypeMotionShake)
    {
        NSLog(@"Shaked");
        

    }
}


-(UIViewController *)viewControllerFromStoryBoard:(NSString *)storyboardName withViewControllerName:(NSString *)viewId{

 
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:storyboardName
                                                             bundle: nil];
    return (UIViewController *)[mainStoryboard
                                instantiateViewControllerWithIdentifier: viewId];

}

-(void)addBackGroundViewForTableView:(UITableView *)tableView withText:(NSString *)text{
    UIView *currentView = [UIView new];
    
    currentView.backgroundColor = [UIColor clearColor];
    
    [currentView setFrame:CGRectMake(tableView.frame.origin.x,
                                     tableView.frame.origin.y,
                                     tableView.frame.size.width,
                                     tableView.frame.size.height)];
    
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, self.view.bounds.size.width, 30)];
    
    messageLabel.text = text;
    messageLabel.textColor = [UIColor blackColor];
    //messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    
    
    
    [currentView addSubview:messageLabel];
    
    
    tableView.backgroundView = currentView;
    
    if ([text length] == 0) {
               tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    else
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    

}




- (IBAction)btnBackTapped {
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(int)groupId{
    

    if ([[self.userDefaults objectForKey:@"myProfileObject"] isKindOfClass:[NSArray class]]) {
        
        return [[[[self.userDefaults objectForKey:@"isFirstTimeSignUp"] firstObject] objectForKey:@"group_id"] intValue];
        
    }
    
    return [[[self.userDefaults objectForKey:@"myProfileObject"] objectForKey:@"group_id"] intValue];
    
}

-(NSString *)myJid{
    
    if ([[self.userDefaults objectForKey:@"isFirstTimeSignUp"] isKindOfClass:[NSArray class]]) {
        return [[[self.userDefaults objectForKey:@"isFirstTimeSignUp"] firstObject] objectForKey:@"id"];
    }
    return [[self.userDefaults objectForKey:@"isFirstTimeSignUp"] objectForKey:@"id"];
    
}


-(NSString *)myName{
    
    
    if ([[self.userDefaults objectForKey:@"isFirstTimeSignUp"] isKindOfClass:[NSArray class]]) {
        return [[[self.userDefaults objectForKey:@"isFirstTimeSignUp"] firstObject] objectForKey:@"name"];
    }
    return [[self.userDefaults objectForKey:@"isFirstTimeSignUp"] objectForKey:@"name"];
    
}

-(NSString *)myEmail{
    
    
    if ([[self.userDefaults objectForKey:@"isFirstTimeSignUp"] isKindOfClass:[NSArray class]]) {
        return [[[self.userDefaults objectForKey:@"isFirstTimeSignUp"] firstObject] objectForKey:@"email"];
    }
    return [[self.userDefaults objectForKey:@"isFirstTimeSignUp"] objectForKey:@"email"];
    
}

-(NSString *)myPhoneNumber{
    
    
    if ([[self.userDefaults objectForKey:@"isFirstTimeSignUp"] isKindOfClass:[NSArray class]]) {
        return [[[self.userDefaults objectForKey:@"isFirstTimeSignUp"] firstObject] objectForKey:@"phone_number"];
    }
    return [[self.userDefaults objectForKey:@"isFirstTimeSignUp"] objectForKey:@"phone_number"];
    
}

-(NSString *)myProfileImageUrl{
    @try {


        if ([[self.userDefaults objectForKey:@"isFirstTimeSignUp"] isKindOfClass:[NSArray class]]) {
            return [[[self.userDefaults objectForKey:@"isFirstTimeSignUp"] firstObject] objectForKey:@"profile_image"];
        }
        return [[self.userDefaults objectForKey:@"isFirstTimeSignUp"] objectForKey:@"profile_image"];
    
        
    } @catch (NSException *exception) {
     
        return nil;
        
    }

}


-(NSDictionary *)completedAssetLink{
    
    return [self.userDefaults objectForKey:@"completedAssetLink"];;
    
}


-(void)connectionErrorDelegate{
    
    //[self.view makeToast:@"Unable to establish connection with the Server. Please check your internet connection and try again!"];
    
    
    for (UIView *allSubView in [self.view subviews]) {
        
        if ([allSubView isKindOfClass:[UIActivityIndicatorView class]]) {
            
            UIActivityIndicatorView *tmp = allSubView;
            
            [tmp stopAnimating];
            
        
        }
    }
    [self stopLoader];
    
}





-(void)slideUp:(int)scale{
    CGRect viewFrame;
    viewFrame=self.view.frame;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.3];
    viewFrame.origin.y = -scale;
    self.view.frame=viewFrame;
    [UIView commitAnimations];
}

-(void)slideBackToNormal{
    CGRect viewFrame;
    viewFrame=self.view.frame;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.3];
    viewFrame.origin.y = 0;
    self.view.frame=viewFrame;
    [UIView commitAnimations];
}


-(void)makeCallToNumber:(NSString *)number{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",number]]];;
}

-(void)profileButtonTapped{
    
    
    [self showMyProfileView];
    
    
    
}

-(void)mapButtonTapped{

    [self dismissViewControllerAnimated:YES completion:^{

        /*
        MapViewController *destination = (MapViewController *)[self viewControllerFromStoryBoard:@"Main" withViewControllerName:@"MapViewController"];
        
        
        
        
        [self.navigationController pushViewController:destination animated:YES];
       */
        
    }];
    
        
    
}
-(void)showMyProfileView{
    
    
    
    /*
    ProfileViewController *destination = (ProfileViewController *)[self viewControllerFromStoryBoard:@"Main" withViewControllerName:@"ProfileViewController"];
    
    
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    
    [self.view.window.layer addAnimation:transition forKey:nil];
    [self.navigationController.view.layer addAnimation:transition forKey:nil];

    [self.navigationController pushViewController:destination animated:NO];
    
    */
    
    

}











-(void)useMyCurrentLocationUpdated{
    
}





-(void)insertSpinnerOfStyle:(RTSpinKitViewStyle)style
            backgroundColor:(UIColor*)backgroundColor
                      label:(NSString *)labelString
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = CGRectGetWidth(screenBounds);
    
     self.spinner = [[RTSpinKitView alloc] initWithStyle:style color:[UIColor whiteColor]];
    
    self.spinner.center = CGPointMake(CGRectGetMidX(screenBounds), CGRectGetMidY(screenBounds));
    [self.spinner startAnimating];
    
    
     self.panel = [[UIView alloc] initWithFrame:CGRectOffset(self.view.bounds, 1.0, 1.0)];
    
    self.panel.backgroundColor = backgroundColor;
    
    [self.panel addSubview:self.spinner];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 50.0, screenWidth, 30.0)];
    label.text = labelString;
    label.font = [UIFont systemFontOfSize:25.0];
    label.textColor = [UIColor whiteColor];
    
    if ([label respondsToSelector:@selector(tintColor)]) {
        label.textAlignment = NSTextAlignmentCenter;
    } else {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        label.textAlignment = UITextAlignmentCenter;
#pragma GCC diagnostic pop
        label.backgroundColor = [UIColor clearColor];
    }
    
    [self.panel addSubview:label];
    [self.view addSubview:self.panel];
    

}


-(NSString *)myPhoneCode{
    
    return @"+1";
    
}


-(void)showLoader{
    @try {

      //  [[self insertSpinnerOfStyle:RTSpinKitViewStylePlane backgroundColor:[UIColor grayColor]] label:@"Test"];
        
        if ( self.spinner) {
            
            [self.panel setHidden:NO];
            [self.view bringSubviewToFront:self.panel];
            
        }
        else {
            
            [self insertSpinnerOfStyle:RTSpinKitViewStylePlane backgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5] label:@""];
            
        
            
        }

    } @catch (NSException *exception) {
     
        
    }
    
}

-(void)showMenuViewController{
    
    /*
    MenuViewController * menuViewController =
    (MenuViewController *)[self viewControllerFromStoryBoard:@"Main" withViewControllerName:@"MenuViewController"];
   
    menuViewController.delegate = self;
    
    
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:transition forKey:nil];

    
    [self presentViewController:menuViewController animated:NO completion:^{
        
    }];
    
    */
    
    
    
}
-(void)hideLoader{
    
    @try {

        [self.panel setHidden:YES];
        
        [self.view sendSubviewToBack:self.panel];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }

}






-(BOOL) validateStringContainsNumbersOnly:(NSString*)strng
{
    NSCharacterSet *s = [NSCharacterSet characterSetWithCharactersInString:@"+1234567890"];
    
    s = [s invertedSet];
    //And you can then use a string method to find if your string contains anything in the inverted set:
    
    NSRange r = [strng rangeOfCharacterFromSet:s];
    if (r.location != NSNotFound) {
        NSLog(@"the string contains illegal characters");
        return NO;
    }
    else
        return YES;
}

- (BOOL)isAlphanumeric:(NSString *)string
{
    NSString *regex = @"[A-Z]+";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL result = [test evaluateWithObject:string];
    
    return result;
    
}



-(NSString *)contactsJSON{
    
    

    
    
    
    
    return @"";
    
}

-(void)showImageFromHttpUrl:(NSString *)urlToShow{
    
    [self showLoader];
    
    [FileManager loadImageFromurl:urlToShow
            withComplitionHandler:^(id tmp)
     {
         
         dispatch_async(dispatch_get_main_queue(), ^{
             
             
             [self hideLoader];
             

                              JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
                 imageInfo.image = tmp;
             
             imageInfo.referenceRect = self.view.frame;
             
             imageInfo.referenceView = self.view;
             
             JTSImageViewController *imageViewer = [[JTSImageViewController alloc]
                                                    initWithImageInfo:imageInfo
                                                    mode:JTSImageViewControllerMode_Image
                                                    backgroundStyle:JTSImageViewControllerBackgroundOption_Scaled];
             [imageViewer showFromViewController:self transition:JTSImageViewControllerTransition_FromOriginalPosition];
             
             
             

         });
     }
                   withFailHander:^(int tmp) {
                       
                   }];
    
    
}

-(void)callAlertViewControllerWithTitle:(NSString *)title withMessage:(NSString *)message withOkButtonTitle:(NSString *)okTitle withCancleTitle:(NSString *)cancleTitle withOKHandler:(void(^)(void))okHandler withCancelHandler:(void(^)(void))CancelHandler
{
    
    UIAlertController *myAlertController = [UIAlertController alertControllerWithTitle:title
                                                                               message:message
                                                                        preferredStyle:UIAlertControllerStyleAlert                   ];
    
    
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:okTitle
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             
                             [myAlertController dismissViewControllerAnimated:YES completion:^{
                                 
                             }];
                             
                             okHandler();
                             
                         }];
    
    [myAlertController addAction: ok];
    
    if ([cancleTitle length] > 0) {

        UIAlertAction* cancelAction = [UIAlertAction
                                       actionWithTitle:cancleTitle
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action)
                                       {
                                           
                                           [myAlertController dismissViewControllerAnimated:YES completion:nil];
                                           
                                           
                                           CancelHandler();
                                           
                                       }];
        [myAlertController addAction: cancelAction];
    
        
    }
    
    //[myAlertController setBackgroundColor:[UIColor darkGrayColor]];

    
    //[[UIView appearanceWhenContainedIn:[UIAlertController class], nil] setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];

    
    //alertContentView.backgroundColor = UIColor.blackColor()

    
//myAlertController
    
    [self presentViewController:myAlertController animated:YES completion:nil];
    
}

- (UIImage*)previewFromFileAtPath:(NSString*)path ratio:(CGFloat)ratio
{
    AVAsset *asset = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:path]];
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc]initWithAsset:asset];
    CMTime duration = asset.duration;
    CGFloat durationInSeconds = duration.value / duration.timescale;
    CMTime time = CMTimeMakeWithSeconds(durationInSeconds * ratio, (int)duration.value);
    CGImageRef imageRef = [imageGenerator copyCGImageAtTime:time actualTime:NULL error:NULL];
    UIImage *thumbnail = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return thumbnail;
}





-(UIColor *)transperancyColor{
    
    return [UIColor colorWithRed:1 green:1 blue:1 alpha:0.85];
    
}

-(NSAttributedString *)requestTextWithText:(NSString *)text{
    
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:text];
    
    id normalFont = [UIFont fontWithName:FontToUserMedium size:27];
    
    [attrString beginEditing];
    
    NSRange normalRange2 = NSMakeRange(0, [text length]);
    

    
    [attrString addAttribute:kCTFontAttributeName
                       value:normalFont
                       range:normalRange2];
    
    [attrString endEditing];
    
    return attrString;
    
}


-(int)totalPoints {
    
    
    return [self.park1Level1Score intValue] + [self.park1Level2Score intValue] +
    [self.park2Level1Score intValue] + [self.park2Level2Score intValue] +
    [self.park3Level1Score intValue] + [self.park3Level2Score intValue];
    
}





-(NSAttributedString *)textForScoreWithScore:(NSString *)score withLevel:(int)level withPark:(int)park
{
    
    
    NSString *levelString = @"";
    
    NSString *parkString = @"";
    
    
    NSString *scoreStinrg = [NSString stringWithFormat:@"%@/30\n",score];
    
    
    if (level == 1) {
        
        levelString = @"Junior Recruit";
        
    }
    else {
        levelString = @"Recruit";
        
        
    }
    
    if (park == 1) {
     
        parkString = @"Hegewisch\nMarsh\n";
        
    }
    else if (park == 2) {
        
        parkString = @"Big\nMarsh\n";
        
    }
    else if (park == 3) {
        
        parkString = @"Indian Ridge\nMarsh\n";
        
    }
    
    
    NSString *fullSting = [NSString stringWithFormat:@"%@%@%@",scoreStinrg,parkString,levelString];
    
    
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:fullSting];
    
    
    id boldFontName = [UIFont fontWithName:FontToUserBlack size:31];
    id normalFont = [UIFont fontWithName:FontToUseLightItalic size:24];
    
    
    [attrString beginEditing];
    
    
    NSRange boldedRange = NSMakeRange(0, scoreStinrg.length+parkString.length-1);
    
    NSRange normalRange2 = NSMakeRange(scoreStinrg.length+parkString.length, levelString.length);
    
    
    [attrString addAttribute:kCTFontAttributeName
                       value:boldFontName
                       range:boldedRange];
    
    [attrString addAttribute:kCTFontAttributeName
                       value:normalFont
                       range:normalRange2];
    
    [attrString endEditing];
    
    return attrString;
    
}


-(NSAttributedString *)attributedTextPointsTitle {
    int totalPoints = self.totalPoints;
    
    NSAttributedString *answer;
    
    
    
    
    
    if (totalPoints < 45) {
        
        
        answer = self.revisitorText;
        
        
    }
    else if (totalPoints < 90) {
        
        answer = self.reSearcherText;
        
        
    }
    else {
        
        answer = self.Rewilder;
        
    }
    
    return answer;
    
    
    
}
-(NSAttributedString *)requestText{
    
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@"request"];
    id boldFontName = [UIFont fontWithName:FontToUserBlack size:36];
    id normalFont = [UIFont fontWithName:FontToUseRegular size:36];
    
    [attrString beginEditing];
    
    NSRange boldedRange = NSMakeRange(2, 5);
    NSRange normalRange2 = NSMakeRange(0, 2);
    
    [attrString addAttribute:kCTFontAttributeName
                       value:boldFontName
                       range:boldedRange];
    
    [attrString addAttribute:kCTFontAttributeName
                       value:normalFont
                       range:normalRange2];
    
    [attrString endEditing];
    
    return attrString;
    
}

//

//



-(NSAttributedString *)Rewilder{
    
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@"rewilder"];
    id boldFontName = [UIFont fontWithName:FontToUserBlack size:45];
    id normalFont = [UIFont fontWithName:FontToUseRegular size:45];
    
    [attrString beginEditing];
    
    NSRange boldedRange = NSMakeRange(2, [attrString length] -2);
    NSRange normalRange2 = NSMakeRange(0, 2);
    
    [attrString addAttribute:kCTFontAttributeName
                       value:boldFontName
                       range:boldedRange];
    
    [attrString addAttribute:kCTFontAttributeName
                       value:normalFont
                       range:normalRange2];
    
    [attrString endEditing];
    
    return attrString;
    
}


-(NSAttributedString *)revisitorText{
    
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@"revisitor"];
    id boldFontName = [UIFont fontWithName:FontToUserBlack size:45];
    id normalFont = [UIFont fontWithName:FontToUseRegular size:45];
    
    [attrString beginEditing];
    
    NSRange boldedRange = NSMakeRange(2, [attrString length] -2);
    NSRange normalRange2 = NSMakeRange(0, 2);
    
    [attrString addAttribute:kCTFontAttributeName
                       value:boldFontName
                       range:boldedRange];
    
    [attrString addAttribute:kCTFontAttributeName
                       value:normalFont
                       range:normalRange2];
    
    [attrString endEditing];
    
    return attrString;
    
}


-(NSAttributedString *)reSearcherText{
    
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@"researcher"];
    id boldFontName = [UIFont fontWithName:FontToUserBlack size:45];
    id normalFont = [UIFont fontWithName:FontToUseRegular size:45];
    
    [attrString beginEditing];
    
    NSRange boldedRange = NSMakeRange(2, [attrString length] -2);
    NSRange normalRange2 = NSMakeRange(0, 2);
    
    [attrString addAttribute:kCTFontAttributeName
                       value:boldFontName
                       range:boldedRange];
    
    [attrString addAttribute:kCTFontAttributeName
                       value:normalFont
                       range:normalRange2];
    
    [attrString endEditing];
    
    return attrString;
    
}


-(UILabel *)navLabel{
    
         AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
 
        return nil;
    
}


-(NSString *)park1Level1Score {
    NSString *parkIdToSave =  [NSString stringWithFormat:@"Park%@%@",@"1",@"1"];
    
    id parkInfo = [self.userDefaults objectForKey:parkIdToSave];
    
    if (parkInfo) {
        return parkInfo;
        
    }
    
    return @"0";
    
}

-(NSString *)park1Level2Score {
    NSString *parkIdToSave =  [NSString stringWithFormat:@"Park%@%@",@"2",@"1"];
    
    id parkInfo = [self.userDefaults objectForKey:parkIdToSave];
    
    if (parkInfo) {
        return parkInfo;
        
    }
    
    return @"0";
    
}


-(NSString *)park2Level1Score {
    NSString *parkIdToSave =  [NSString stringWithFormat:@"Park%@%@",@"1",@"2"];
    id parkInfo = [self.userDefaults objectForKey:parkIdToSave];
    if (parkInfo) {
        return parkInfo;
        
    }
    
    return @"0";
    
}

-(NSString *)park2Level2Score {
    NSString *parkIdToSave =  [NSString stringWithFormat:@"Park%@%@",@"2",@"2"];
    id parkInfo = [self.userDefaults objectForKey:parkIdToSave];
    if (parkInfo) {
        return parkInfo;
        
    }
    
    return @"0";
    
}




-(NSString *)park3Level1Score {
    NSString *parkIdToSave =  [NSString stringWithFormat:@"Park%@%@",@"1",@"3"];
    id parkInfo = [self.userDefaults objectForKey:parkIdToSave];
    if (parkInfo) {
        return parkInfo;
    }
    
    return @"0";
    
}

-(NSString *)park3Level2Score {
    NSString *parkIdToSave =  [NSString stringWithFormat:@"Park%@%@",@"2",@"3"];
    id parkInfo = [self.userDefaults objectForKey:parkIdToSave];
    if (parkInfo) {
        return parkInfo;
    }
    
    return @"0";
    
}

-(UIImage*)imageWithImage: (UIImage*) sourceImage scaledToWidth: (float) i_width
{
    float oldWidth = sourceImage.size.width;
    float scaleFactor = i_width / oldWidth;
    
    float newHeight = sourceImage.size.height * scaleFactor;
    float newWidth = oldWidth * scaleFactor;
    
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


-(UIImage*)imageWithHeightWithImage: (UIImage*) sourceImage heihgt: (float) height
{
    float oldHeight = sourceImage.size.height;
    float scaleFactor = height / oldHeight;
    
    float newWidth = sourceImage.size.width * scaleFactor;
    
    float newHeihgt = oldHeight * scaleFactor;
    
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeihgt));
    [sourceImage drawInRect:CGRectMake(0, 0, newWidth, newHeihgt)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
}




@end
