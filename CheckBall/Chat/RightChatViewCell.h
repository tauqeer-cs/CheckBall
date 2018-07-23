//
//  RightChatViewCell.h
//  ugame
//
//  Created by Shehzad on 22/06/2016.
//  Copyright © 2016 Shehzad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RightChatViewCell : UITableViewCell {
    IBOutlet UIImageView *userImage;
    IBOutlet UIView *chatView;
    IBOutlet UIView *textBG;
    IBOutlet UILabel *chatText;
    IBOutlet UIImageView *rightchat;
    IBOutlet UILabel *chatTime;
}

-(void)initViewWithData:(NSDictionary*)data ShowTime:(BOOL)showTime;

@end
