//
//  ChatViewController.h
//  ugame
//
//  Created by Shehzad on 22/06/2016.
//  Copyright © 2016 Shehzad. All rights reserved.
//

#import "BaseViewController.h"


@interface ChatViewController : BaseViewController <UITableViewDelegate, UITableViewDataSource, UITextViewDelegate> {
    IBOutlet UITableView *chatListView;
    IBOutlet UITextView *chatTextBox;
    IBOutlet UIButton *sendButton;
    IBOutlet NSLayoutConstraint *textHeightConstraint;
    IBOutlet NSLayoutConstraint *bottomConstraint;
    IBOutlet NSLayoutConstraint *topConstraint;
    
}

@property(nonatomic,strong) NSString *chatTitle;
@property int with_user_id;
@property int with_group_id;
@property (nonatomic) int questionId;

@property (weak, nonatomic) IBOutlet UILabel *lblChapter;

@property (nonatomic,strong) NSString * chapterString;
@property (nonatomic,strong) NSString * chapterQuestion;
@property (weak, nonatomic) IBOutlet UIView *chatContainerView;

@end
