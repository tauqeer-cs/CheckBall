//
//  MyUserProfileViewController.h
//  CheckBall
//
//  Created by Shehzad Bilal on 15/01/2018.
//  Copyright © 2018 plego. All rights reserved.
//

#import "BaseViewController.h"
#import "AddingTextViewControl.h"
#import "CropImageViewController.h"
#import "TOActionSheet.h"
#import "SelectMapLocationViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "YTPlayerView.h"
@interface MyUserProfileViewController : BaseViewController<YTPlayerViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *viewProfileImageButtonContainer;
@property (weak, nonatomic) IBOutlet UIButton *btnUserProfileButton;

@property (weak, nonatomic) IBOutlet UIView *viewBasicInfoContainer;
@property (weak, nonatomic) IBOutlet UIView *viewSchoolContainer;

@property (weak, nonatomic) IBOutlet UILabel *lblBio;

@property (weak, nonatomic) IBOutlet UIView *viewBioContainer;
@property (weak, nonatomic) IBOutlet UIView *viewVideoContainer;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewUsing;

@property (weak, nonatomic) IBOutlet UIButton *btnUpdate;

@property (weak, nonatomic) IBOutlet UILabel *lblMyName;
@property (weak, nonatomic) IBOutlet UILabel *lblPosition;
@property (weak, nonatomic) IBOutlet UILabel *lblMyName2;

@property (weak, nonatomic) IBOutlet UILabel *lblHeight;
@property (weak, nonatomic) IBOutlet UILabel *lblWeight;
@property (weak, nonatomic) IBOutlet UILabel *lblPosition2;
@property (weak, nonatomic) IBOutlet UILabel *lblSchool;

@property (nonatomic,strong) AddingTextViewControl * addingTextView;

@property (nonatomic) BOOL changingTheName;
@property (nonatomic) BOOL changingThePosition;
@property (nonatomic) BOOL changingTheSchool;
@property (nonatomic) BOOL changingTheBioDetails;

@property (nonatomic) BOOL changingYouTubeOne;
@property (nonatomic) BOOL changingYouTubeTwo;

@property (nonatomic) BOOL hasEditingAnyField;


@property (weak, nonatomic) IBOutlet UIPickerView *heightPickerView;

@property (weak, nonatomic) IBOutlet UIView *viewPickerContainer;
@property (weak, nonatomic) IBOutlet UILabel *lblSelectHeight;
@property (nonatomic,strong) NSArray * heightFeets;
@property (nonatomic,strong) NSArray * heightInches;

@property (nonatomic,strong) NSMutableArray * weightsArray;

@property (nonatomic) BOOL isSelectingHeight;

@property (nonatomic,strong) NSString * heightSelected;
@property (nonatomic,strong) NSString * weightSelected;


@property (weak, nonatomic) IBOutlet UILabel *lblYouTubeOne;

@property (weak, nonatomic) IBOutlet UILabel *lblYouTubeTwo;

@property (nonatomic,strong) NSMutableArray * allVideos;
@property (nonatomic) UIImagePickerController *imagePickerController;

@property (nonatomic,strong) UIImage * selectedImage;


@property (nonatomic) BOOL comingFromListing;

@property (nonatomic) int idCalling;

@property (weak, nonatomic) IBOutlet UIButton *btnCOnnect;

@property (nonatomic) BOOL hasImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *videoContainerHeight;

@property (weak, nonatomic) IBOutlet UIView *viewVideoContent;

@property (nonatomic,strong) IBOutlet YTPlayerView *youTubePrayer;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *videoLoader;

@property (nonatomic) int currentIndexOfVideos;

@property (weak, nonatomic) IBOutlet UIButton *btnNextVideo;

@property (nonatomic) BOOL doShowTheNextButton;

@property (weak, nonatomic) IBOutlet UILabel *lblNoVideoLabel;
- (void)enterBasicInfoToLabler:(User *)result;
- (void)setVideLabelsForEditor:(User *)result;

- (void)setYoutubePlaerForUer:(User *)result;

@property (nonatomic,strong) User * currentUserShowing;

@end
