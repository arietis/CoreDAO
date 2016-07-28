//
//  RLMString.m
//  AlfaStrah
//
//  Created by Egor Taflanidi on 04/06/27 H.
//  Copyright (c) 27 Heisei RedMadRobot. All rights reserved.
//

#import "RLMString.h"

@implementation RLMString

#pragma mark - RLMObject

+ (NSDictionary *)defaultPropertyValues
{
    return @{ @"string" : @"" };
}

#pragma mark - Конструкторы

+ (instancetype)stringWithString:(NSString *)string
{
    RLMString *realmString = [[RLMString alloc] init];
    realmString.string = string;
    return realmString;
}

@end
