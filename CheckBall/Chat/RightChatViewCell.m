//
//  RightChatViewCell.m
//  ugame
//
//  Created by Shehzad on 22/06/2016.
//  Copyright © 2016 Shehzad. All rights reserved.
//

#import "RightChatViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "DateFormatter.h"
@implementation RightChatViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initViewWithData:(NSDictionary*)data ShowTime:(BOOL)showTime {
    
    NSString *trimmedString = [[data valueForKey:@"message"] stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    chatText.text = trimmedString;
    
    if([[data valueForKey:@"userImage"] isEqualToString:@""]) {
        
        userImage.image = [UIImage imageNamed:@"user"];
        
    } else {
        [userImage setImageWithURL:[NSURL URLWithString:[data valueForKey:@"userImage"]]];
    }
    
    NSDate *chatDate = [NSDate dateWithTimeIntervalSince1970:[[data valueForKey:@"message_Timestamp"] doubleValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    if([[formatter stringFromDate:[NSDate date]] isEqualToString:[formatter stringFromDate:chatDate]]) {
        [formatter setDateFormat:@"hh:mm a"];
    } else {
        [formatter setDateFormat:@"dd MMM hh:mm a"];
    }
    
    /*
    if(showTime) {
        chatTime.text = [formatter stringFromDate:chatDate];
    } else {
        chatTime.text = @"Time";
    }*/
    
       chatTime.text = [formatter stringFromDate:chatDate];
    
    UIImage *pin = [UIImage imageNamed:@"rightchat"];
    pin = [pin imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    rightchat.image = pin;
//    rightchat.tintColor = [UIColor colorWithHex:@"#e3e3e3"];
    
    textBG.backgroundColor = [UIColor clearColor];
    
    userImage.layer.cornerRadius = 15.0;
    userImage.layer.masksToBounds = YES;
    textBG.layer.cornerRadius = 8.0;
    textBG.layer.masksToBounds = YES;
    
    chatText.textColor = [UIColor whiteColor];
    
    
    
}

@end
