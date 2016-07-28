//
//  RealmTranslator.m
//  CoreDAO
//
//  Created by Egor Taflanidi on 29/07/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "RealmTranslator.h"

@implementation RealmTranslator

+ (instancetype)translator
{
    return [[self alloc] init];
}

- (RLMEntry *)toEntry:(id<Persistable>)entity
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"Abstract method"
                                 userInfo:nil];
}

- (id<Persistable>)toEntity:(RLMEntry *)entry
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"Abstract method"
                                 userInfo:nil];
}

- (NSString *)entryClass
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"Abstract method"
                                 userInfo:nil];
}

- (NSArray *)toEntries:(NSArray *)entities
{
    NSMutableArray *entries = [[NSMutableArray alloc] init];
    for (id entity in entities) [entries addObject:[self toEntry:entity]];
    return [NSArray arrayWithArray:entries];
}

- (NSArray *)toEntities:(id<NSFastEnumeration>)entries
{
    NSMutableArray *entities = [[NSMutableArray alloc] init];
    for (id entry in entries) [entities addObject:[self toEntity:entry]];
    return [NSArray arrayWithArray:entities];
}

- (RLMArray *)toRealmArray:(NSArray *)array
{
    RLMArray *realmArray = [[RLMArray alloc] initWithObjectClassName:[self entryClass]];
    [realmArray addObjects:array];
    return realmArray;
}

@end
