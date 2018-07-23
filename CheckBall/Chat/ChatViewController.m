//
//  ChatViewController.m
//  ugame
//
//  Created by Shehzad on 22/06/2016.
//  Copyright © 2016 Shehzad. All rights reserved.
//

#import "ChatViewController.h"
#import "RightChatViewCell.h"
#import "LeftChatViewCell.h"
#import "User.h"
//#import "OfflineMessageView.h"
//#import "NSString+Measurements.h"
#import "AppDelegate.h"
#import "AppDelegate.h"
#import "Config.h"

@interface ChatViewController ()  {
    
    NSMutableArray *chats;
    NSDictionary *selectedChat;
    NSMutableDictionary *colors;
    NSDictionary *chatMessagePopup;
    
    __weak IBOutlet UIView *topRoundContainer;
}
@property (weak, nonatomic) IBOutlet UIView *textBoxContainer;
@property (weak, nonatomic) IBOutlet UIImageView *doctorImage;
@property (weak, nonatomic) IBOutlet UILabel *lblNAme;

@property (weak, nonatomic) IBOutlet UILabel *lblSpeciality;
@property (weak, nonatomic) IBOutlet UILabel *lblQuestion;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintOfTheTextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topContrainstOfLogo;




@end

@implementation ChatViewController






- (void)viewDidLoad {
    
    //WriteAText
    
    
    
    BOOL alreadyFound = NO;
    
    chats = [NSMutableArray new];
    
    NSMutableDictionary * firstOne = [NSMutableDictionary new];
    [firstOne setObject:@"1" forKey:@"isMe"];
    [firstOne setObject:@"Message" forKey:@"message"];
    
    [chats addObject:firstOne];
    
    

    self.lblChapter.text = self.chapterString;
    
    [topRoundContainer roundTheView];
    

    colors = [[NSMutableDictionary alloc] init];
    
    [self addKeyBoardNotifications];
    
    chatListView.rowHeight = UITableViewAutomaticDimension;
    chatListView.estimatedRowHeight = 15;
    chatListView.estimatedSectionHeaderHeight = 30;
    
    [self getChatHistory];
    //tableView.registerNib(nib, forHeaderFooterViewReuseIdentifier: "TableSectionHeader")
    //tableView.registerNib(nib, forHeaderFooterViewReuseIdentifier: "TableSectionHeader")

    
    self.textBoxContainer.layer.cornerRadius  = 5;
    self.textBoxContainer.layer.borderColor = [UIColor colorWithRed:63.0/255.0 green:168.0/255.0 blue:186.0/255.0 alpha:1.0].CGColor;
    self.textBoxContainer.layer.borderWidth = 1;
    
   // self.lblNAme.text = self.expertObject.fullName;
   // self.lblSpeciality.text = self.expertObject.specialization;
    //self.title = self.expertObject.fullName;
    //[FileManager loadProfileImage:self.doctorImage url:self.expertObject.imageUrl];

    [self.doctorImage roundTheView];
 
    
    chatTextBox.text = @"Write a message";
    chatTextBox.textColor = [UIColor lightGrayColor];
    chatTextBox.delegate = self;
    

}



-(void)viewDidAppear:(BOOL)animated{
    
    //ChatHeader
 
    
    
    

    
    //chatListView.tableHeaderView = tmpView;

    
}


-(void)appDidBecomeActiveAgain{
    
    [self getChatHistory];
    
}



-(void)addKeyBoardNotifications {
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onKeyboardShowEvent:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onKeyboardHideEvent:) name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenLocked) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidBecomeActiveAgain) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    
}

- (void)handleSingleTapEvent:(UITapGestureRecognizer *)recognizer {
    [self.view endEditing:YES];
}

-(void)onKeyboardShowEvent:(NSNotification *)notification {

    
    CGRect frame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect newFrame = [self.view convertRect:frame fromView:[[UIApplication sharedApplication] delegate].window];
    float diff = newFrame.origin.y - CGRectGetHeight(self.view.frame);
    //topConstraint.constant = diff;
    bottomConstraint.constant = -diff;
    [UIView animateWithDuration:0.5
                     animations:^{
                         [self.view layoutIfNeeded];
                     }];
    
    if (chatListView.contentSize.height > chatListView.frame.size.height)
    {
        //CGPoint offset = CGPointMake(0, chatListView.contentSize.height - chatListView.frame.size.height);
        //[chatListView setContentOffset:offset animated:YES];
        
        NSIndexPath* ipath = [NSIndexPath indexPathForRow: [chats count]-1 inSection:0];
        
        
        [chatListView scrollToRowAtIndexPath: ipath atScrollPosition: UITableViewScrollPositionBottom animated: YES];
     
    
        [self slideUp:frame.size.height];
        

    }
    else {
        [self slideUp:frame.size.height];
        
        
    }
    //[self.view layoutIfNeeded];
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


-(void)onKeyboardHideEvent:(NSNotification *)notification {
    
    
}

-(void)screenLocked{
    //do stuff
    
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    
}

-(void)getChatHistory {
    
    
    [self connectWebSocket];
    
    
    
}


- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell {
    [sizingCell layoutIfNeeded];
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height;
}

-(void)TapToRetry {
    
    [self getChatHistory];
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return chats.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *chat = [chats objectAtIndex:indexPath.row];
    
    
    
    if([[chat valueForKey:@"isMe"] intValue] == 1)
    {
        static NSString *str = @"RightChatViewCell";
        RightChatViewCell *cell = (RightChatViewCell *)[tableView dequeueReusableCellWithIdentifier:str];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RightChatViewCell" owner:self options:nil];
            cell = (RightChatViewCell *)[nib objectAtIndex:0];
        }
        cell.backgroundColor = [UIColor clearColor];
        [cell initViewWithData:chat ShowTime:(selectedChat == chat)];
        return cell;
    } else {
        static NSString *str = @"LeftChatViewCell";
        LeftChatViewCell *cell = (LeftChatViewCell *)[tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LeftChatViewCell" owner:self options:nil];
            cell = (LeftChatViewCell *)[nib objectAtIndex:0];
        }
        cell.backgroundColor = [UIColor clearColor];
        [cell initViewWithData:chat ShowTime:(selectedChat == chat)];
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *chat = [chats objectAtIndex:indexPath.row];
    if(selectedChat == chat) {
        selectedChat = nil;
    } else {
        selectedChat = chat;
    }
    
    [tableView beginUpdates];
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
    [tableView endUpdates];
    
}

-(NSString *)myProfileImageUrl{
    @try {
        
        
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        
        NSLog(@"%@",[userDefaults objectForKey:@"isFirstTimeSignUp"]);
        
        if ([[userDefaults objectForKey:@"isFirstTimeSignUp"] isKindOfClass:[NSArray class]]) {
            return [[[userDefaults objectForKey:@"isFirstTimeSignUp"] firstObject] objectForKey:@"image_url"];
        }
        return [[userDefaults objectForKey:@"isFirstTimeSignUp"] objectForKey:@"image_url"];
        
        
    } @catch (NSException *exception) {
        
        return @"";
        
    }
    
}



-(IBAction)sendButtonPressed:(id)sender {
    
  
    
    

    
    if(![chatTextBox.text isEqualToString:@""]) {
        
        [self.view endEditing:YES];
        NSDictionary *chatDict;
        

        
        
        chatDict = [NSDictionary dictionaryWithObjectsAndKeys:@"group_chat",@"purpose",[NSString stringWithFormat:@"%d",self.with_user_id],@"user_id",chatTextBox.text,@"message",@"0",@"id",
                    [NSString stringWithFormat:@"%d",self.with_group_id],@"group_id",
                    [NSString stringWithFormat:@"%d",self.questionId],@"topic_id",
                    nil];
        
        [NSString stringWithFormat:@""];
        
        if ([self sendMessage:chatDict]) {
            
            NSMutableDictionary * tmpMessage  = [NSMutableDictionary new];
            [tmpMessage setObject:@"" forKey:@"user_id"];
            [tmpMessage setObject:[self myProfileImageUrl] forKey:@"userImage"];
            [tmpMessage setObject:chatTextBox.text forKey:@"message"];
            
            [tmpMessage setObject: [NSDate new] forKey:@"message_datetime"];
            [tmpMessage setObject:[self myProfileImageUrl] forKey:@"user_image_url"];
            [tmpMessage setObject:@"1" forKey:@"isMe"];
            [tmpMessage setObject:[NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]] forKey:@"message_Timestamp"];
            
            [tmpMessage setObject:@"" forKey:@"sender_name"];

            

            
            
            //                    //
            
            [chats addObject:tmpMessage];
            
            
            chatTextBox.text = @"";
            [self textViewDidChange:chatTextBox];
            
            [chatListView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:chats.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
            [self performSelector:@selector(scrollToBottom) withObject:nil afterDelay:0.5];
            [self playSound];
            [self scrollToBottom];
            
        } else {
            //[SVProgressHUD showErrorWithStatus:@"Unable to send message"];
            
        }
    }
}

-(void)scrollToBottom {
    [chatListView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:chats.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
}

-(void)playSound {
    
    
    return;
    
    SystemSoundID soundID;
    CFBundleRef mainBundle = CFBundleGetMainBundle();
    CFURLRef ref = CFBundleCopyResourceURL(mainBundle, (CFStringRef)@"chat_sound.mp3", NULL, NULL);
    AudioServicesCreateSystemSoundID(ref, &soundID);
    AudioServicesPlaySystemSound(soundID);
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    /*if ([text isEqualToString:@"\n"]) {
     [textView resignFirstResponder];
     }*/
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    CGFloat fixedWidth = textView.frame.size.width;
    CGSize newSize = [textView sizeThatFits:CGSizeMake(fixedWidth, CGFLOAT_MAX)];
    CGRect newFrame = textView.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    if(newFrame.size.height < (self.view.frame.size.height/4)) {
        textHeightConstraint.constant = newFrame.size.height + 20;
    } else {
        textHeightConstraint.constant = (self.view.frame.size.height/4) + 20;
    }
    
    if(textView.text.length == 0){
        textView.textColor = [UIColor lightGrayColor];
        textView.text = @"Write Your message";
        [textView resignFirstResponder];
        
    }
    
    //textView.frame = newFrame;
}

-(void)connectWebSocket {
    

    
}





-(void)updateBadge:(NSTimer *)timer {
    //update badge count
    AppDelegate *appDel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //   [appDel updateBadgeCount];
}

-(bool)sendMessage:(NSDictionary*)messageDictionary {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:messageDictionary options:0 error:nil];
    
    return NO;
}

-(void)ShowNotification:(NSDictionary*)chatMessage {

    
}

-(void)dropdownNotificationTopButtonTapped {
    NSLog(@"Top button tapped");
 
}

-(void)dropdownNotificationBottomButtonTapped {
}
- (IBAction)btnBackTapped:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end

