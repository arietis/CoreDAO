//
//  CoreDataDAO.m
//  CoreDAO
//
//  Created by Egor Taflanidi on 29/10/15.
//  Copyright © 2015 RedMadRobot LLC. All rights reserved.
//

#import "CoreDataDAO.h"
#import "CoreDataTranslator.h"
#import "StoreCoordinator.h"
#import "FetchRequest.h"
#import "ManagedObject.h"

@interface CoreDataDAO ()
@property (nonatomic, readwrite, strong) CoreDataTranslator *translator;
@property (nonatomic, readwrite, strong) NSPersistentStoreCoordinator *coordinator;
@end

@implementation CoreDataDAO

#pragma mark - Публичные методы

- (instancetype)initWithTranslator:(CoreDataTranslator *)translator
{
    return [self initWithTranslator:translator
                          storeName:@"Database.db"];
}

- (instancetype)initWithTranslator:(CoreDataTranslator *)translator
                         storeName:(NSString *)storeName
{
    if (self = [super init]) {
        self.translator = translator;
        self.coordinator = [StoreCoordinator coordinatorWithStoreName:storeName];
    }

    return self;
}

+ (instancetype)daoWithTranslator:(CoreDataTranslator *)translator
{
    return [[self alloc] initWithTranslator:translator];
}


+ (instancetype)daoWithTranslator:(CoreDataTranslator *)translator
                        storeName:(NSString *)storeName
{
    return [[self alloc] initWithTranslator:translator
                                  storeName:storeName];
}

#pragma mark - DAO

- (BOOL)persist:(id <Persistable>)entity
{
    BOOL success = YES;
    if ([self entryExistWithId:entity.entityId]) {
        success = success && [self updateEntryTransaction:entity];
    } else {
        success = success && [self createEntryTransaction:entity];
    }

    return success;
}

- (BOOL)persistAll:(NSArray<id <Persistable>> *)entities
{
    return NO;
}

- (id <Persistable>)read:(id)entityId
{
    NSArray *entries = [[self context] executeFetchRequest:[self requestWithId:entityId]
                                                     error:nil];

    if (entries && entries.count) {
        id <Persistable> entity = (id <Persistable>)[[[self.translator entityClass] alloc] init];
        [self.translator fillEntity:entity
                          withEntry:entries.firstObject];
        return entity;
    }

    return nil;
}

- (NSArray<id <Persistable>> *)readAll
{
    NSArray *allEntries = [[self context] executeFetchRequest:[self requestWithPredicate:nil]
                                                        error:nil] ?: @[];

    NSMutableArray *entities = [[NSMutableArray alloc] init];
    for (NSManagedObject *entry in allEntries) {
        id <Persistable> entity = (id <Persistable>)[[[self.translator entityClass] alloc] init];
        [self.translator fillEntity:entity
                          withEntry:entry];
        [entities addObject:entity];
    }

    return [NSArray arrayWithArray:entities];
}

- (NSArray<id <Persistable>> *)readAllPredicated:(NSPredicate *)predicate
{
    NSArray *entries = [[self context] executeFetchRequest:[self requestWithPredicate:predicate]
                                                     error:nil] ?: @[];

    NSMutableArray *entities = [[NSMutableArray alloc] init];
    for (NSManagedObject *entry in entries) {
        id <Persistable> entity = (id <Persistable>)[[[self.translator entityClass] alloc] init];
        [self.translator fillEntity:entity
                          withEntry:entry];
        [entities addObject:entity];
    }

    return [NSArray arrayWithArray:entities];
}

- (NSArray<id <Persistable>> *)readAllOrderBy:(NSString *)field
                                    ascending:(BOOL)ascending
{
    NSArray *entries = [[self context] executeFetchRequest:[self requestWithPredicate:nil
                                                                      sortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:field
                                                                                                                      ascending:ascending]]]
                                                     error:nil] ?: @[ ];

    NSMutableArray *entities = [[NSMutableArray alloc] init];
    for (NSManagedObject *entry in entries) {
        id <Persistable> entity = (id <Persistable>)[[[self.translator entityClass] alloc] init];
        [self.translator fillEntity:entity
                          withEntry:entry];
        [entities addObject:entity];
    }

    return [NSArray arrayWithArray:entities];
}

- (NSArray<id <Persistable>> *)readAllPredicated:(NSPredicate *)predicate
                                         orderBy:(NSString *)field
                                       ascending:(BOOL)ascending
{
    NSArray *entries = [[self context] executeFetchRequest:[self requestWithPredicate:predicate
                                                                      sortDescriptors:@[ [NSSortDescriptor sortDescriptorWithKey:field
                                                                                                                       ascending:ascending] ]]
                                                     error:nil] ?: @[ ];

    NSMutableArray *entities = [[NSMutableArray alloc] init];
    for (NSManagedObject *entry in entries) {
        id <Persistable> entity = (id <Persistable>)[[[self.translator entityClass] alloc] init];
        [self.translator fillEntity:entity
                          withEntry:entry];
        [entities addObject:entity];
    }

    return [NSArray arrayWithArray:entities];
}

- (void)erase
{
    [self deleteAllEntriesTransaction];
}

- (void)erase:(id)entityId
{
    [self deleteEntryTransaction:entityId];
}

#pragma mark - Частные методы

- (NSManagedObjectContext *)context
{
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.persistentStoreCoordinator = self.coordinator;
    return context;
}

- (NSArray *)fetchEntriesWithId:(id)entryId
                      inContext:(NSManagedObjectContext *)context
{
    return [context executeFetchRequest:[self requestWithId:entryId]
                                  error:nil] ?: @[];
}

- (NSFetchRequest *)requestWithId:(id)entryId
{
    return [self requestWithPredicate:[self predicateWithId:entryId]];
}

- (NSFetchRequest *)requestWithPredicate:(NSPredicate *)predicate
{
    return [FetchRequest fetchRequestWithEntryClass:[self.translator entryClass]
                                          predicate:predicate];
}

- (NSFetchRequest *)requestWithPredicate:(NSPredicate *)predicate
                         sortDescriptors:(NSArray <NSSortDescriptor *> *)descriptors
{
    return [FetchRequest fetchRequestWithEntryClass:[self.translator entryClass]
                                          predicate:predicate
                                    sortDescriptors:descriptors];
}

- (NSPredicate *)predicateWithId:(id)entryId
{
    return [NSPredicate predicateWithFormat:@"entryId == %@", entryId];
}

#pragma mark - Транзакции

- (BOOL)entryExistWithId:(id)entryId
{
    NSManagedObjectContext *entryCheckContext = [self context];
    NSArray *existingEntries = [self fetchEntriesWithId:entryId inContext:entryCheckContext];
    return existingEntries && existingEntries.count;
}

- (BOOL)updateEntryTransaction:(id <Persistable>)entity
{
    NSManagedObjectContext *transactionContext = [self context];
    NSArray *existingEntries = [self fetchEntriesWithId:entity.entityId
                                              inContext:transactionContext];

    if (!(existingEntries && existingEntries.count)) return NO;

    BOOL success = YES;
    for (NSManagedObject *entry in existingEntries)
        success = success && [self.translator fillEntry:entry
                                             withEntity:entity
                                              inContext:transactionContext];

    return success && [transactionContext save:nil];
}

- (BOOL)createEntryTransaction:(id <Persistable>)entity
{
    NSManagedObjectContext *transactionContext = [self context];

    NSManagedObject *entry = [ManagedObject objectOfClass:[self.translator entryClass]
                                                inContext:transactionContext];

    BOOL success = [self.translator fillEntry:entry
                                   withEntity:entity
                                    inContext:transactionContext];

    return success && [transactionContext save:nil];
}

- (void)deleteAllEntriesTransaction
{
    NSManagedObjectContext *transactionContext = [self context];

    NSArray *allEntries = [transactionContext executeFetchRequest:[self requestWithPredicate:nil]
                                                            error:nil] ?: @[];

    for (NSManagedObject *entry in allEntries) {
        [transactionContext deleteObject:entry];
    }

    [transactionContext save:nil];
}

- (void)deleteEntryTransaction:(id)entityId
{
    NSManagedObjectContext *transactionContext = [self context];
    NSArray *entriesWithId = [self fetchEntriesWithId:entityId
                                            inContext:transactionContext];

    for (NSManagedObject *entry in entriesWithId) {
        [transactionContext deleteObject:entry];
    }

    [transactionContext save:nil];
}

@end
