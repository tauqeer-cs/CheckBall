//
//  Validator.m
//  GChat
//
//  Created by Tauqeer on 2014-10-10.
//  Copyright (c) 2014 Carlin. All rights reserved.
//

#import "Validator.h"

@implementation Validator
+(BOOL)validatePassword:(NSString *)givenPassword withConfirmPassword:(NSString *)confirmPassword withMinimumPasswordLimit:(int)withMinLength
{
    
    if ([givenPassword length] < withMinLength) {
        
        return NO;
    }
    
    if ([givenPassword isEqualToString:confirmPassword]) {
        
        return YES;
    }
    return NO;
}

+(BOOL)validateEmptyString:(NSString *)givenString withMinimumLimit:(int)limit{
    
    
    if ([givenString length] < limit) {
        return NO;
    }
    return YES;
}


+(BOOL)validateEmptyString:(NSString *)givenString{
 
    
    if ([givenString length] == 0) {
        
        return NO;
        
    }
    return YES;
}
+(void)setTextFieldPlaceHolderColor : (UITextField *)textField withColor:(UIColor *)currentColor
{
    [textField setValue:currentColor forKeyPath:@"_placeholderLabel.textColor"];
}
+(BOOL)validateEmptyString:(NSString *)givenString withTextField:(UITextField *)textField
{
    
    if ([givenString length] == 0) {
    
        [self setTextFieldPlaceHolderColor:textField withColor:[UIColor redColor]];
        
        return NO;
    }
    
    [self setTextFieldPlaceHolderColor:textField withColor:[UIColor grayColor]];
    
    return YES;
}
+ (BOOL)validateEmailAddress:(NSString *)emailStr
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailStr];
}

+ (BOOL) validPhone:(NSString*) phoneString {
    
    NSError *error = NULL;
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypePhoneNumber error:&error];
    
    NSRange inputRange = NSMakeRange(0, [phoneString length]);
    NSArray *matches = [detector matchesInString:phoneString options:0 range:inputRange];
    
    // no match at all
    if ([matches count] == 0) {
        return NO;
    }
    
    // found match but we need to check if it matched the whole string
    NSTextCheckingResult *result = (NSTextCheckingResult *)[matches objectAtIndex:0];
    
    if ([result resultType] == NSTextCheckingTypePhoneNumber && result.range.location == inputRange.location && result.range.length == inputRange.length) {
        // it matched the whole string
        return YES;
    }
    else {
        // it only matched partial string
        return NO;
    }
}


@end
