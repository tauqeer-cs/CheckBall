//
//  NSString+MyString.m
//  Filmer
//
//  Created by Tauqeer Ahmed on 4/7/16.
//  Copyright © 2016 Plego. All rights reserved.
//

#import "NSString+MyString.h"

@implementation NSString (MyString)

-(NSString*)stringByCleaningPhoneNumber{
    
    NSString *clean = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    clean = [clean stringByReplacingOccurrencesOfString:@"\u00a0" withString:@""];
    clean = [clean stringByReplacingOccurrencesOfString:@" " withString:@""];
    clean = [clean stringByReplacingOccurrencesOfString:@"-" withString:@""];
    clean = [clean stringByReplacingOccurrencesOfString:@"(" withString:@""];
    clean = [clean stringByReplacingOccurrencesOfString:@")" withString:@""];
    clean = [clean stringByReplacingOccurrencesOfString:@"." withString:@""];
    clean = [clean stringByReplacingOccurrencesOfString:@"+" withString:@"00"];
    if(self){
        NSString *totalPrefix = [NSString stringWithFormat:@"00%@", self];
        if([clean hasPrefix:totalPrefix]){
            clean = [clean substringFromIndex:totalPrefix.length];
        }
    }
    
    return clean;
}

-(NSString *)filerString{
    
    NSString *unfilteredString = self;
    NSCharacterSet *notAllowedChars = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"] invertedSet];
    NSString *resultString = [[unfilteredString componentsSeparatedByCharactersInSet:notAllowedChars] componentsJoinedByString:@""];
    return resultString;
}


@end
