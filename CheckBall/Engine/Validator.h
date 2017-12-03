//
//  Validator.h
//  GChat
//
//  Created by Tauqeer on 2014-10-10.
//  Copyright (c) 2014 Carlin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Validator : NSObject

+ (BOOL)validateEmailAddress:(NSString *)emailStr;
+ (BOOL) validPhone:(NSString*) phoneString ;
+(BOOL)validateEmptyString:(NSString *)givenString;
+(BOOL)validateEmptyString:(NSString *)givenString withMinimumLimit:(int)limit;
+(BOOL)validatePassword:(NSString *)givenPassword withConfirmPassword:(NSString *)confirmPassword withMinimumPasswordLimit:(int)withMinLength;
+(BOOL)validateEmptyString:(NSString *)givenString withTextField:(UITextField *)textField;

@end
