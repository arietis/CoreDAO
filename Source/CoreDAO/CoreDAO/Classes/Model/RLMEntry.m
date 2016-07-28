//
//  DatabaseEntry.m
//  CoreDAO
//
//  Created by Egor Taflanidi on 28/07/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "RLMEntry.h"

@implementation RLMEntry

+ (instancetype)nullEntry
{
    RLMEntry *entry = [[self alloc] init];
    entry.entryId = @"0";
    return entry;
}

+ (NSDictionary *)defaultPropertyValues
{
    return @{ @"entryId" : [[NSDate date] description] };
}

+ (NSString *)primaryKey
{
    return @"entryId";
}

@end
