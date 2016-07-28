//
//  TidyRealmDAO.m
//  CoreDAO
//
//  Created by Egor Taflanidi on 27/10/15.
//  Copyright © 2015 RedMadRobot LLC. All rights reserved.
//

#import <CoreDAO/TidyRealmDAO.h>
#import <CoreDAO/RealmDAO+Protected.h>
#import <CoreDAO/Subordinate.h>

@interface TidyRealmDAO ()
@property (nonatomic, assign) DAOCleanupMode cleanupMode;
@end

@implementation TidyRealmDAO

#pragma mark - Публичные методы

- (instancetype)initWithTranslator:(RealmTranslator *)translator
                       cleanupMode:(DAOCleanupMode)cleanupMode
{
    if (self = [super initWithTranslator:translator]) {
        [self setupCleanup:cleanupMode];
    }
    return nil;
}

+ (instancetype)daoWithTranslator:(RealmTranslator *)translator
                      cleanupMode:(DAOCleanupMode)cleanupMode
{
    return [[self alloc] initWithTranslator:translator
                                cleanupMode:cleanupMode];
}

- (void)setupCleanup:(DAOCleanupMode)cleanupMode
{
    self.cleanupMode = cleanupMode;
}

- (void)cleanup
{
    NSArray *entriesToBeDeleted =
        [self extractEntriesToBeDeleted:[self readAllEntriesPredicated:nil]];

    [self deleteEntriesTransaction:entriesToBeDeleted];
}

#pragma mark - DAO

- (BOOL)persist:(id <Persistable>)entity
{
    if (self.cleanupMode == DAOCleanupModeEveryWrite) [self cleanup];
    return [super persist:entity];
}

- (BOOL)persistAll:(NSArray *)entities
{
    if (self.cleanupMode == DAOCleanupModeEveryWrite) [self cleanup];
    return [super persistAll:entities];
}

- (id <Persistable>)read:(id)entityId
{
    if (self.cleanupMode == DAOCleanupModeEveryRead) [self cleanup];
    return [super read:entityId];
}

- (NSArray *)readAll
{
    if (self.cleanupMode == DAOCleanupModeEveryRead) [self cleanup];
    return [super readAll];
}

- (NSArray *)readAllPredicated:(NSPredicate *)predicate
{
    if (self.cleanupMode == DAOCleanupModeEveryRead) [self cleanup];
    return [super readAllPredicated:predicate];
}

- (NSArray *)readAllOrderBy:(NSString *)field
                  ascending:(BOOL)ascending
{
    if (self.cleanupMode == DAOCleanupModeEveryRead) [self cleanup];
    return [super readAllOrderBy:field ascending:ascending];
}

- (NSArray *)readAllPredicated:(NSPredicate *)predicate
                       orderBy:(NSString *)field
                     ascending:(BOOL)ascending
{
    if (self.cleanupMode == DAOCleanupModeEveryRead) [self cleanup];
    return [super readAllPredicated:predicate orderBy:field ascending:ascending];
}

#pragma mark - Частные методы

- (NSArray *)extractEntriesToBeDeleted:(RLMResults *)entries
{
    NSMutableArray *entriesToBeDeleted = [[NSMutableArray alloc] init];

    for (RLMEntry *entry in entries)
        if ([self entryShouldBeDeleted:entry])
            [entriesToBeDeleted addObject:entry];

    return [NSArray arrayWithArray:entriesToBeDeleted];
}

- (BOOL)entryShouldBeDeleted:(RLMEntry *)entry
{
    return [entry conformsToProtocol:@protocol(Subordinate)]
        && [((id <Subordinate>)entry) referenceCount] == 0;
}

@end
