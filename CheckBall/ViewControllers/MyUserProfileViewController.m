//
//  MyUserProfileViewController.m
//  CheckBall
//
//  Created by Shehzad Bilal on 15/01/2018.
//  Copyright © 2018 plego. All rights reserved.
//

#import "MyUserProfileViewController.h"
#import "User.h"


@interface MyUserProfileViewController ()<CropImageViewControllerDelegate>


@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *allItemsToRemove;

@end


@implementation MyUserProfileViewController


-(NSMutableArray *)allVideos{
    
    if (!_allVideos) {
        
        _allVideos = [NSMutableArray new];
        
        
    }
    return _allVideos;
}


-(void)hidePickerViewITems{
    
    [self.viewPickerContainer setHidden:YES];
    [self.scrollViewUsing setHidden:NO];
    
    
}
- (IBAction)btnHEightPickerCancelTapped:(id)sender
{
    
    [self hidePickerViewITems];
    
    
}





- (IBAction)btnHeightSelectedDoneTapped:(id)sender {
    
    [self hidePickerViewITems];
    
    self.hasEditingAnyField = YES;
    
    
    if (self.isSelectingHeight){
        int feetIndex = [self.heightPickerView selectedRowInComponent:0];
        int inchesIndex = [self.heightPickerView selectedRowInComponent:1];
        
        
        NSString * finalSelectedHeight = [NSString stringWithFormat:@"%@%@",[self.heightFeets objectAtIndex:feetIndex],[self.heightInches objectAtIndex:inchesIndex]];
        
        //self.txtHeight.txtView.text = finalSelectedHeight;

        self.heightSelected = [finalSelectedHeight stringByReplacingOccurrencesOfString:@"'" withString:@"."];
        
        self.heightSelected = [self.heightSelected stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        

        finalSelectedHeight = [NSString stringWithFormat:@"Height ( %@ )",finalSelectedHeight];
        
        self.lblHeight.text = finalSelectedHeight;
        
        

    }
    else {
        
        NSString * finalSelectedHeight = [NSString stringWithFormat:@"%@",[self.weightsArray objectAtIndex:[self.heightPickerView selectedRowInComponent:0]]];
        
        //self.txtWeight.txtView.text = finalSelectedHeight;

        self.weightSelected = [finalSelectedHeight stringByReplacingOccurrencesOfString:@" lb" withString:@""];
        NSLog(@"%@",self.weightSelected);
        self.lblWeight.text = [NSString stringWithFormat:@"Weight ( %@ )",finalSelectedHeight];;
        
    }
    
    NSLog(@"");
    
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    // return the number of components required
    
    if (self.isSelectingHeight) {
        
        return 2;
        
    }
    return 1;
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (self.isSelectingHeight) {
        
        if (component == 0) {
            return [self.heightFeets count];
        }
        else {
            
            return [self.heightInches count];
            
        }
    }
    
    return [self.weightsArray count];
    
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    // Component 0 should load the array1 values, Component 1 will have the array2 values
    if (self.isSelectingHeight){
        
        
        if (component == 0) {
            return  [self.heightFeets objectAtIndex:row];
        }
        else if (component == 1) {
            return  [self.heightInches objectAtIndex:row];
        }
    }
    
    return [self.weightsArray objectAtIndex:row];;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
}

- (IBAction)btnHeightTapped:(id)sender {
    
    self.isSelectingHeight = YES;
    
    [self.scrollViewUsing setHidden:YES];
    [self.viewPickerContainer setHidden:NO];
    
    [self.view endEditing:YES];
    self.lblSelectHeight.text = @"Select Height";
    
    [self.heightPickerView reloadAllComponents];
    
   // self.txtHeight.txtView.text = finalSelectedHeight;
    
    
    
    
}

- (IBAction)btnWeightTapped:(id)sender {
    
    self.isSelectingHeight = NO;
    
    [self.scrollViewUsing setHidden:YES];
    [self.viewPickerContainer setHidden:NO];
    
    [self.view endEditing:YES];
    self.lblSelectHeight.text = @"Select Weight";
    
    [self.heightPickerView reloadAllComponents];
    
    // self.txtHeight.txtView.text = finalSelectedHeight;
    
    
    
    
}

-(void)hideKeyBoard {
    
 
    [self.view endEditing:YES];
    
    [self addingTextFieldCancelButtonTapped];
    
}



-(void)addingTextFieldCancelButtonTapped{
    [self.addingTextView setHidden:YES];
    [self.view sendSubviewToBack:self.addingTextView];
    
    [self.view endEditing:YES];
    
    self.changingTheName = NO;
    self.changingThePosition = NO;
    self.changingTheSchool = NO;
    self.changingTheBioDetails = NO;
    self.changingYouTubeOne = NO;
    self.changingYouTubeTwo = NO;
    
}

-(void)addingTextFieldOkButtonTapped{
    
    [self.view endEditing:YES];
    
    self.hasEditingAnyField = YES;
    
    if (self.changingTheName) {
        
        self.lblMyName.text = self.addingTextView.txtBoxEntering.text;
        self.lblMyName2.text = self.addingTextView.txtBoxEntering.text;
    
        self.changingTheName = NO;
        
    }
    else if(self.changingThePosition){
        
        self.lblPosition.text = self.addingTextView.txtBoxEntering.text;
        self.lblPosition2.text = self.addingTextView.txtBoxEntering.text;
        self.changingThePosition = NO;
        
        
    }
    else if(self.changingTheSchool){
        
        self.lblSchool.text = self.addingTextView.txtBoxEntering.text;
        self.lblSchool.text = self.addingTextView.txtBoxEntering.text;
        self.changingTheSchool = NO;
        
        
    }
    else if(self.changingTheBioDetails){
        
        self.lblBio.text = self.addingTextView.txtBoxEntering.text;
        self.lblBio.text = self.addingTextView.txtBoxEntering.text;
        self.changingTheBioDetails = NO;
        
        
    }
    else if(self.changingYouTubeOne){
        
        self.lblYouTubeOne.text = self.addingTextView.txtBoxEntering.text;
        self.lblYouTubeOne.text = self.addingTextView.txtBoxEntering.text;
        self.changingYouTubeOne = NO;
        
        
    }
    else if(self.changingYouTubeTwo){
        
        self.lblYouTubeTwo.text = self.addingTextView.txtBoxEntering.text;
        self.lblYouTubeTwo.text = self.addingTextView.txtBoxEntering.text;
        self.changingYouTubeTwo  = NO;
        
        
    }
    
    
    [self.addingTextView setHidden:YES];
    [self.view sendSubviewToBack:self.addingTextView];
    

}


-(AddingTextViewControl *)addingTextView{
    
    if (!_addingTextView) {
        
        _addingTextView = (AddingTextViewControl *)
        [self.view addSubViewWithContainerView:self.view
                               andEnteringView:_addingTextView
                                   withNibName:@"AddingTextViewControl"];
        
        [_addingTextView.btnOk addTarget:self action:@selector(addingTextFieldOkButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        
        [_addingTextView.btnCancel addTarget:self action:@selector(addingTextFieldCancelButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        
        
    }

    return _addingTextView;
    
}
- (IBAction)btnNameOptionToOpenTap:(UIButton *)sender {
    _addingTextView.txtBoxEntering.text = @"";
    
    
    [self.addingTextView setHidden:NO];
    [self.view bringSubviewToFront:self.addingTextView];
    
    
    self.changingTheName = YES;
    
    [self.addingTextView.txtBoxEntering becomeFirstResponder];
    
    
}
- (IBAction)btnSelectPositionTapped:(id)sender {
    
    _addingTextView.txtBoxEntering.text = @"";
    
    
    [self.addingTextView setHidden:NO];
    [self.view bringSubviewToFront:self.addingTextView];
    
    
    self.changingThePosition = YES;
    
    [self.addingTextView.txtBoxEntering becomeFirstResponder];
    
    
}


- (IBAction)btnSchoolNameTapped:(id)sender {
    _addingTextView.txtBoxEntering.text = @"";
    
    [self.addingTextView setHidden:NO];
    [self.view bringSubviewToFront:self.addingTextView];
    
    
    self.changingTheSchool = YES;
    
    
    
    [self.addingTextView.txtBoxEntering becomeFirstResponder];
    
    [self.addingTextView.txtBoxEntering becomeFirstResponder];
    
    
    
}

- (IBAction)btnBioTapped:(id)sender {
    _addingTextView.txtBoxEntering.text = @"";
    
    
    [self.addingTextView setHidden:NO];
    [self.view bringSubviewToFront:self.addingTextView];
    
    
    self.changingTheBioDetails = YES;
    
    [self.addingTextView.txtBoxEntering becomeFirstResponder];
    
    
}

- (IBAction)btnYouTubeOneTapped:(id)sender {
    _addingTextView.txtBoxEntering.text = @"";
    
    
    [self.addingTextView setHidden:NO];
    [self.view bringSubviewToFront:self.addingTextView];
    
    
    self.changingYouTubeOne = YES;
    
    [self.addingTextView.txtBoxEntering becomeFirstResponder];
    
    
}
- (IBAction)btnYouTubeTwoTapped:(id)sender {
    _addingTextView.txtBoxEntering.text = @"";
    
    
    [self.addingTextView setHidden:NO];
    [self.view bringSubviewToFront:self.addingTextView];
    
    
    self.changingYouTubeTwo = YES;
    
    
    [self.addingTextView.txtBoxEntering becomeFirstResponder];
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self.btnUserProfileButton setImage:[UIImage imageNamed:@"gander-icon"] forState:UIControlStateNormal];
    
    [self.scrollViewUsing setHidden:YES];
    
    [self showLoader];
    
    [self.viewProfileImageButtonContainer roundTheView];
    
    [self.btnUserProfileButton roundTheView];
    //226 184
    
    self.viewBasicInfoContainer.layer.cornerRadius = 10;
    
    self.viewBioContainer.layer.cornerRadius = 10;
    
    self.viewVideoContainer.layer.cornerRadius = 10;
    
    //
    self.lblBio.text = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incidid";
    
    
    self.btnUpdate.layer.cornerRadius = 5;
    
    
    
    self.heightFeets = @[@"1'",@"2'",@"3'",@"4'",@"5'",@"6'",@"7'",@"8'"];
    
    self.heightInches = @[@"1\"",@"2\"",@"3\"",@"4\"",@"5\"",@"6\"",@"7\"",@"8\"",@"9\"",@"10\"",@"11\""];
    self.weightsArray = [NSMutableArray new];
    
    for (int i = 50;i<1451;i++)
    {
        [self.weightsArray addObject:[NSString stringWithFormat:@"%d lb",i]];
    }
    
    
    
   if (self.comingFromListing)
   {
       [FileManager loadProfileImageToButton:self.btnUserProfileButton :[baseImageLink stringByAppendingString:[NSString stringWithFormat:@"%d.jpg",self.idCalling ]] loader:nil];
       
   }

    else
    { [FileManager loadProfileImageToButton:self.btnUserProfileButton :[baseImageLink stringByAppendingString:[NSString stringWithFormat:@"%d.jpg",[self.myJid intValue]]] loader:nil];
    }
    
    
    if (self.comingFromListing) {
        for (UIView * currentView in self.allItemsToRemove)
        {
            
            [currentView removeFromSuperview];
            
        }
        
    }
    
    //733
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    

    if (self.comingFromListing) {
        
        [User
         callGetUserProfileById:[NSString stringWithFormat:@"%d",self.idCalling]
         WithComplitionHandler:^(id result) {
             [self hideLoader];
             id videosList = [result objectForKey:@"Videos"];
             if ([videosList isKindOfClass:[NSArray class]] && [videosList count] > 0)
             {for (id currentItem in videosList)
             {
                 [self.allVideos addObject:[currentItem objectForKey:@"Url"]];
             }
             }
             self.lblMyName.text = [[[result objectForKey:@"Account"] firstObject] objectForKey:@"Name"];
             self.lblMyName2.text = [[[result objectForKey:@"Account"] firstObject] objectForKey:@"Name"];
             self.lblPosition.text = [[[result objectForKey:@"Account"] firstObject] objectForKey:@"Position"];
             self.lblPosition2.text = [[[result objectForKey:@"Account"] firstObject] objectForKey:@"Position"];
             self.lblSchool.text = [[[result objectForKey:@"Account"] firstObject] objectForKey:@"School"];
             self.lblBio.text =  [[[result objectForKey:@"Account"] firstObject] objectForKey:@"Bio"];
             NSString * heightShowing = [[[result objectForKey:@"Account"] firstObject] objectForKey:@"Height"];
             if (![heightShowing isKindOfClass:[NSString class]]) {
                 heightShowing = [NSString stringWithFormat:@"%.02f",[heightShowing doubleValue]];
                 self.heightSelected = heightShowing;
             }
             heightShowing = [heightShowing stringByReplacingOccurrencesOfString:@"." withString:@"\""];
             heightShowing = [heightShowing stringByAppendingString:@"'"];
             heightShowing = [NSString stringWithFormat:@"Height ( %@ )",heightShowing];
             self.lblHeight.text = heightShowing;
             NSString * weight = [[[result objectForKey:@"Account"] firstObject] objectForKey:@"Weight"];
             if (![weight isKindOfClass:[NSString class]]) {
                 weight = [NSString stringWithFormat:@"%d",[weight intValue]];self.weightSelected = weight;
             }
             weight = [weight stringByAppendingString:@" lb"];
             self.lblWeight.text = [NSString stringWithFormat:@"Weight ( %@ )",weight];;
             [self.scrollViewUsing setHidden:NO];
             if ([self.allVideos count] >= 2) {
                 self.lblYouTubeOne.text = self.allVideos[0]; self.lblYouTubeTwo.text = self.allVideos[1];
                 
             }
             else if([self.allVideos count] >= 1){
                 self.lblYouTubeOne.text = self.allVideos[0];
             }
             
         } withFailueHandler:^{
             
             [self hideLoader];
             [self showAlert:@"" message:@"Error while laoding data"];
         }];
        
    }
    {
     
        [User
         callGetUserProfileById:self.myJid WithComplitionHandler:^(id result) {
             [self hideLoader];
             id videosList = [result objectForKey:@"Videos"];
             if ([videosList isKindOfClass:[NSArray class]] && [videosList count] > 0)
             {for (id currentItem in videosList)
             {
                 [self.allVideos addObject:[currentItem objectForKey:@"Url"]];
             }
             }
             self.lblMyName.text = [[[result objectForKey:@"Account"] firstObject] objectForKey:@"Name"];
             self.lblMyName2.text = [[[result objectForKey:@"Account"] firstObject] objectForKey:@"Name"];
             self.lblPosition.text = [[[result objectForKey:@"Account"] firstObject] objectForKey:@"Position"];
             self.lblPosition2.text = [[[result objectForKey:@"Account"] firstObject] objectForKey:@"Position"];
             self.lblSchool.text = [[[result objectForKey:@"Account"] firstObject] objectForKey:@"School"];
             self.lblBio.text =  [[[result objectForKey:@"Account"] firstObject] objectForKey:@"Bio"];
             NSString * heightShowing = [[[result objectForKey:@"Account"] firstObject] objectForKey:@"Height"];
             if (![heightShowing isKindOfClass:[NSString class]]) {
                 heightShowing = [NSString stringWithFormat:@"%.02f",[heightShowing doubleValue]];
                 self.heightSelected = heightShowing;
             }
             heightShowing = [heightShowing stringByReplacingOccurrencesOfString:@"." withString:@"\""];
             heightShowing = [heightShowing stringByAppendingString:@"'"];
             heightShowing = [NSString stringWithFormat:@"Height ( %@ )",heightShowing];
             self.lblHeight.text = heightShowing;
             NSString * weight = [[[result objectForKey:@"Account"] firstObject] objectForKey:@"Weight"];
             if (![weight isKindOfClass:[NSString class]]) {
                 weight = [NSString stringWithFormat:@"%d",[weight intValue]];self.weightSelected = weight;
             }
             weight = [weight stringByAppendingString:@" lb"];
             self.lblWeight.text = [NSString stringWithFormat:@"Weight ( %@ )",weight];;
             [self.scrollViewUsing setHidden:NO];
             if ([self.allVideos count] >= 2) {
                 self.lblYouTubeOne.text = self.allVideos[0]; self.lblYouTubeTwo.text = self.allVideos[1];
                 
             }
             else if([self.allVideos count] >= 1){
                 self.lblYouTubeOne.text = self.allVideos[0];
             }
             
         } withFailueHandler:^{
             
             [self hideLoader];
             [self showAlert:@"" message:@"Error while laoding data"];
         }];
        
    }

    
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect: self.viewSchoolContainer.bounds byRoundingCorners: UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii: (CGSize){10.0, 10.}].CGPath;
    
    self.viewSchoolContainer.layer.mask = maskLayer;
    
    
    maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect: self.viewBioContainer.bounds byRoundingCorners: UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii: (CGSize){10.0, 10.}].CGPath;
    
    self.viewBioContainer.layer.mask = maskLayer;
    
    maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect: self.viewVideoContainer.bounds byRoundingCorners: UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii: (CGSize){10.0, 10.}].CGPath;
    
    self.viewVideoContainer.layer.mask = maskLayer;
    
    
    
    [self.scrollViewUsing setContentSize:CGSizeMake(self.view.frame.size.width, 773)];
    
    //
}


- (IBAction)btnUpdateProfileTapped:(id)sender {
    
    if (!self.hasEditingAnyField) {
    
        return;
    }
    NSMutableDictionary * paramDictionary = [NSMutableDictionary new] ;
    
    NSMutableDictionary * tmpDictionary = [NSMutableDictionary new];
    
    [tmpDictionary setObject:self.myJid forKey:@"ID"];
    [tmpDictionary setObject:self.lblMyName.text forKey:@"Name"];
    [tmpDictionary setObject:self.myEmail forKey:@"Email"];
    [tmpDictionary setObject:self.myAccountType forKey:@"Account_Type"];
    [tmpDictionary setObject:self.heightSelected forKey:@"Height"];
    [tmpDictionary setObject:self.weightSelected forKey:@"Weight"];
    
    [tmpDictionary setObject:self.lblPosition.text forKey:@"Position"];
    
    [tmpDictionary setObject:self.lblSchool.text forKey:@"School"];
    [tmpDictionary setObject:self.lblBio.text forKey:@"Bio"];
    [tmpDictionary setObject:self.myZipCode forKey:@"ZipCode"];
    
    [paramDictionary setObject:@[tmpDictionary] forKey:@"Account"];
    
    [paramDictionary setObject:@[] forKey:@"Specilities"];
  
    
    NSMutableArray * videosArray = [NSMutableArray new];
    
    if ([self.lblYouTubeOne.text length] > 0) {
        [videosArray addObject:
         @{@"Url":self.lblYouTubeOne.text}];
        
    }
    
    if ([self.lblYouTubeTwo.text length] > 0) {
     
        [videosArray addObject:
         @{@"Url":self.lblYouTubeTwo.text}];
        
        
    }

    [paramDictionary setObject:videosArray forKey:@"Videos"];
    [paramDictionary setObject:@[] forKey:@"Locations"];
    
    
    
    [self showLoader];
    
    [User callUpdateProfileWithParams:paramDictionary
                withComplitionHandler:^(id result) {
        
                    [self hideLoader];
                    
                    
    } withFailueHandler:^{
        
    } withAlreadyExistsHandler:^(id result) {
        
    }];
    
    
    
    
    
}
- (IBAction)btnImagePickerTapped:(id)sender {
    
    
    TOActionSheet *actionSheet = [[TOActionSheet alloc] init];
    actionSheet.title = @"Select an option";
    actionSheet.style = TOActionSheetStyleLight;
    
    actionSheet.contentstyle = TOActionSheetContentStyleDefault;
    
    
    [actionSheet addButtonWithTitle:@"Capture Image" icon:nil tappedBlock:^{
        
        
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusDenied)
        {
            // Denies access to camera, alert the user.
            // The user has previously denied access. Remind the user that we need camera access to be useful.
            UIAlertController *alertController =
            [UIAlertController alertControllerWithTitle:@"Unable to access the Camera"
                                                message:@"To enable access, go to Settings > Privacy > Camera and turn on Camera access for this app."
                                         preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:ok];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else if (authStatus == AVAuthorizationStatusNotDetermined)
            // The user has not yet been presented with the option to grant access to the camera hardware.
            // Ask for it.
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^( BOOL granted ) {
                // If access was denied, we do not set the setup error message since access was just denied.
                if (granted)
                {
                    // Allowed access to camera, go ahead and present the UIImagePickerController.
                    [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera fromButton:sender];
                }
            }];
        else
        {
            // Allowed access to camera, go ahead and present the UIImagePickerController.
            [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera fromButton:sender];
        }
        
    }];
    
    
    [actionSheet addButtonWithTitle:@"Select Image" icon:nil tappedBlock:^{
        
        [self showImagePickerForSourceType:UIImagePickerControllerSourceTypePhotoLibrary fromButton:nil];
        
    }];
    
    actionSheet.actionSheetDismissedBlock = ^{
        
        
    };
    [actionSheet showFromView:sender inView:self.navigationController.view];
    
    
    
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        CropImageViewController *cropImageViewController = [[CropImageViewController alloc]initWithNibName:@"CropImageViewController" bundle:nil];
        cropImageViewController.image = image;
        cropImageViewController.delegate = self;
        
        [self presentViewController:cropImageViewController animated:YES completion:^{
            
            
        }];
        
        
        
    }];
    
    
    NSLog(@"");
    
}


- (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType fromButton:(UIBarButtonItem *)button
{
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.sourceType = sourceType;
    imagePickerController.delegate = self;
    imagePickerController.modalPresentationStyle =
    (sourceType == UIImagePickerControllerSourceTypeCamera) ? UIModalPresentationFullScreen : UIModalPresentationPopover;
    
    UIPopoverPresentationController *presentationController = imagePickerController.popoverPresentationController;
    presentationController.barButtonItem = button;  // display popover from the UIBarButtonItem as an anchor
    presentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    
    if (sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        imagePickerController.showsCameraControls = YES;
        
    }
    
    _imagePickerController = imagePickerController; // we need this for later
    
    [self presentViewController:self.imagePickerController
                       animated:YES
                     completion:^{
                         
                         //.. done presenting
                         
                     }];
}



- (void) imageCropedInCircle : (UIImage *) Croppedimage{
    
    
    
    [User callUploadProfileWithId:self.myJid
                    withImageName:Croppedimage
            withComplitionHandler:^(id result) {
                
                
                    } withFailueHandler:^{
                       
                        [self showAlert:@"" message:@"Error while uploading image"];
                    }];
    
    [self.btnUserProfileButton setImage:Croppedimage forState:UIControlStateNormal];
    [self.btnUserProfileButton roundTheView];
    self.selectedImage = Croppedimage;
    
    
    
    
    
}

- (IBAction)btnConnectStarted:(UIButton *)sender {
    
    [self showLoader];
    
    
    
    
    [User callConnectUserWithMyId:self.myJid andUserOtherUserId:[NSString stringWithFormat:@"%d",self.idCalling] withComplitionHandler:^(id result) {
        
        [self showAlert:@"" message:result];
        
        [self hideLoader];
        
    } withFailueHandler:^{
        
        [self hideLoader];
        [self showAlert:@"" message:@"Error while connecting to user"];
        
        
    } withAlreadyExistsHandler:^(id result) {
        
    }];
    
}


@end

