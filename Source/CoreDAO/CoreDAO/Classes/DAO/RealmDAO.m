//
//  RealmDAO.m
//  CoreDAO
//
//  Created by Egor Taflanidi on 28/07/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import <CoreDAO/RealmDAO.h>
#import <CoreDAO/RealmTranslator.h>
#import <CoreDAO/RLMEntry.h>
#import <CoreDAO/CascadeDelete.h>

/**
 Коллеги-авторы ORM Realm считают, что заголовочный файл RLMObjectStore.h должен быть
 приватным.

 Из-за этого следующая директива вызывает ошибку компоновщика:
 #import <Realm/RLMObjectStore.h>

 Дабы обойти это ограничение, часть сигнатур и констант из RLMObjectStore.h декларируется
 ниже:
 */
static const NSUInteger kRLMCreationOptionsCreateOrUpdate = 1 << 0;
RLMResults *RLMGetObjects(RLMRealm *realm, NSString *objectClassName, NSPredicate *predicate) NS_RETURNS_RETAINED;
id RLMGetObject(RLMRealm *realm, NSString *objectClassName, id key) NS_RETURNS_RETAINED;
RLMObjectBase *RLMCreateObjectInRealmWithValue(RLMRealm *realm, NSString *className, id value, bool createOrUpdate) NS_RETURNS_RETAINED;
/* конец */

@interface RealmDAO ()
@property (nonatomic, strong) RealmTranslator *translator;
@end

@implementation RealmDAO

static NSString *databaseFilename;
static NSUInteger databaseVersion;

+ (void)initialize
{
    databaseFilename = @"Database.realm";
    databaseVersion = 1;
}

#pragma mark - DAO

- (BOOL)persist:(id <Persistable>)entity
{
    RLMEntry *entry = [self.translator toEntry:entity];
    return [self writeEntryTransaction:entry];
}

- (BOOL)persistAll:(NSArray<id <Persistable>> *)entities
{
    NSArray *entries = [self.translator toEntries:entities];
    return [self writeEntriesTransaction:entries];
}

- (id <Persistable>)read:(id)entityId
{
    RLMEntry * entry = [self readEntryWithId:entityId];
    if (entry) return [self.translator toEntity:entry];
    return nil;
}

- (NSArray<id <Persistable>> *)readAll
{
    return [self readAllPredicated:nil
                           orderBy:nil
                         ascending:NO];
}

- (NSArray<id <Persistable>> *)readAllPredicated:(NSPredicate *)predicate
{
    return [self readAllPredicated:predicate
                           orderBy:nil
                         ascending:NO];
}

- (NSArray<id <Persistable>> *)readAllOrderBy:(NSString *)field
                                    ascending:(BOOL)ascending
{
    return [self readAllPredicated:nil
                           orderBy:field
                         ascending:ascending];
}

- (NSArray<id <Persistable>> *)readAllPredicated:(NSPredicate *)predicate
                                         orderBy:(NSString *)field
                                       ascending:(BOOL)ascending
{
    NSMutableArray *entities = [[NSMutableArray alloc] init];
    
    RLMResults *results = [self readAllEntriesPredicated:predicate];
    if (field && field.length) 
        results = [results sortedResultsUsingProperty:field ascending:ascending];
    for (RLMEntry *entry in results) [entities addObject:[self.translator toEntity:entry]];
    
    return [NSArray arrayWithArray:entities];
}

- (void)erase
{
    [self deleteEntriesTransaction:[self readAllEntriesPredicated:nil]];
}

- (void)erase:(id)entityId
{
    RLMEntry *entry = [self readEntryWithId:entityId];
    if (entry) [self deleteEntryTransaction:entry];
}

#pragma mark - RealmDAO
#pragma mark - Публичные методы

- (instancetype)initWithTranslator:(RealmTranslator *)translator
{
    return [self initWithTranslator:translator
                   databaseFilename:[[self class] databaseFilename]
                    databaseVersion:[[self class] databaseVersion]];
}

- (instancetype)initWithTranslator:(RealmTranslator *)translator
                  databaseFilename:(NSString *)filename
                   databaseVersion:(NSUInteger)version
{
    if (self = [super init]) {
        self.translator = translator;
        [self loadDefaultRealmFromFilename:filename
                    migrateToSchemaVersion:version];
    }

    return self;
}

+ (NSString *)databaseFilename
{
    return databaseFilename;
}

+ (void)assignDatabaseFilename:(NSString *)newFilename
{
    databaseFilename = newFilename;
}

+ (NSUInteger)databaseVersion
{
    return databaseVersion;
}

+ (void)assignDatabaseVersion:(NSUInteger)newVersion
{
    databaseVersion = newVersion;
}

+ (instancetype)daoWithTranslator:(RealmTranslator *)translator
{
    return [[self alloc] initWithTranslator:translator];
}

#pragma mark - Частные методы

- (BOOL)writeEntryTransaction:(RLMEntry *)entry
{
    [[self realm] beginWriteTransaction];
    RLMObject *result = (RLMObject *)RLMCreateObjectInRealmWithValue([self realm], [self.translator entryClass], entry, kRLMCreationOptionsCreateOrUpdate);
    [[self realm] commitWriteTransaction];

    return result != nil;
}

- (BOOL)writeEntriesTransaction:(NSArray *)entries
{
    NSMutableArray *results = [[NSMutableArray alloc] init];

    [[self realm] beginWriteTransaction];
    for (RLMEntry *entry in entries) {
        RLMObject *result = (RLMObject *)RLMCreateObjectInRealmWithValue([self realm], [self.translator entryClass], entry, kRLMCreationOptionsCreateOrUpdate);
        [results addObject:result];
    }
    [[self realm] commitWriteTransaction];

    return [results count] == [entries count];
}

- (RLMEntry *)readEntryWithId:(NSString *)entryId
{
    return RLMGetObject([self realm], [self.translator entryClass], entryId);;
}

- (RLMResults *)readAllEntriesPredicated:(NSPredicate *)predicate
{
    RLMResults *results = RLMGetObjects([self realm], [self.translator entryClass], predicate);
    return results;
}

- (void)deleteEntryTransaction:(RLMEntry *)entry
{
    NSArray *cascadeObjects = [self cascadeObjectsForObject:entry];

    [[self realm] transactionWithBlock:^{
        [[self realm] deleteObject:entry];
        [[self realm] deleteObjects:cascadeObjects];
    }];
}

- (void)deleteEntriesTransaction:(id)entries
{
    NSArray *cascadeObjects = [self cascadeObjectsForArray:entries];

    [[self realm] transactionWithBlock:^{
        [[self realm] deleteObjects:entries];
        [[self realm] deleteObjects:cascadeObjects];
    }];
}

- (RLMRealm *)realm
{
    return [RLMRealm defaultRealm];
}

- (void)loadDefaultRealmFromFilename:(NSString *)filename
              migrateToSchemaVersion:(NSUInteger)version
{
    NSString *path = [self absolutePathForFilename:filename];
    if ([self defaultRealmPathIsEqualToPath:path]) return;

    [self assignDefaultRealmPath:path];
    [self migrateDefaultRealmToSchemaVersion:version];
}

- (BOOL)defaultRealmPathIsEqualToPath:(NSString *)path
{
    NSString *localPath = [[RLMRealmConfiguration defaultConfiguration].fileURL absoluteString];
    return [localPath isEqualToString:path];
}

- (NSString *)absolutePathForFilename:(NSString *)name
{
    NSString *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *realmPath = [documentsDirectory stringByAppendingPathComponent:name];
    return realmPath;
}

- (void)assignDefaultRealmPath:(NSString *)path
{
    RLMRealmConfiguration *configuration = [RLMRealmConfiguration defaultConfiguration];
    configuration.fileURL = [[NSURL alloc] initWithString:path];
    [RLMRealmConfiguration setDefaultConfiguration:configuration];
}

- (void)migrateDefaultRealmToSchemaVersion:(NSUInteger)version
{
    RLMRealmConfiguration *configuration = [RLMRealmConfiguration defaultConfiguration];
    
    configuration.schemaVersion = version;
    configuration.migrationBlock = ^(RLMMigration *migration, uint64_t oldSchemaVersion) {
        if (oldSchemaVersion < version) {
            // нечего мигрировать, миграция не требует вмешательства
        }
    };
    
    [RLMRealmConfiguration setDefaultConfiguration:configuration];
}

- (NSArray<RLMObject *> *)cascadeObjectsForArray:(id)array
{
    if (![array conformsToProtocol:@protocol(NSFastEnumeration)]) {
        return @[];
    }

    NSMutableArray *cascadeObjects = [[NSMutableArray alloc] init];
    for (id object in array) {
        [cascadeObjects addObject:[self cascadeObjectsForObject:object]];
    }

    return [NSArray arrayWithArray:cascadeObjects];
}

- (NSArray<RLMObject *> *)cascadeObjectsForObject:(id)object
{
    if (![object conformsToProtocol:@protocol(CascadeDelete)]) {
        return @[];
    }

    return [self cascadeObjectsForContainer:(id <CascadeDelete>)object];
}

- (NSArray<RLMObject *> *)cascadeObjectsForContainer:(NSObject<CascadeDelete> *)container
{
    NSArray<NSString *> *cascadeProperties = [container cascadeDeleteProperties];

    NSMutableArray *objectsToBeDeleted = [[NSMutableArray alloc] init];
    for (NSString  *propertyName in cascadeProperties) {
        id propertyValue = [container valueForKey:propertyName];

        if ([propertyValue isKindOfClass:[RLMArray class]]) {
            [objectsToBeDeleted addObjectsFromArray:propertyValue];
            [objectsToBeDeleted addObjectsFromArray:[self cascadeObjectsForArray:propertyValue]];
        } else {
            [objectsToBeDeleted addObject:propertyValue];
            [objectsToBeDeleted addObjectsFromArray:[self cascadeObjectsForObject:propertyValue]];
        }
    }

    return [NSArray arrayWithArray:objectsToBeDeleted];
}

@end
