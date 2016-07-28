// 
// StoreCoordinator.m
// AppCode
// 
// Created by Egor Taflanidi on 29/10/15.
// Copyright (c) 2015 Egor Taflanidi. All rights reserved.
//


#import "StoreCoordinator.h"

@implementation StoreCoordinator

- (instancetype)initWithStoreName:(NSString *)storeName
{
    if (self = [self initWithManagedObjectModel:[self mergedObjectModel]]) {
        [self addPersistentStoreWithType:NSSQLiteStoreType
                           configuration:nil
                                     URL:[self URLForStoreName:storeName]
                                 options:[self storeOptions]
                                   error:nil];
    }

    return self;
}

+ (instancetype)coordinatorWithStoreName:(NSString *)storageName
{
    return [[self alloc] initWithStoreName:storageName];
}

- (NSDictionary *)storeOptions
{
    return @{ NSMigratePersistentStoresAutomaticallyOption : @YES,
            NSInferMappingModelAutomaticallyOption : @YES,
            NSSQLitePragmasOption : @{ @"journal_mode" : @"WAL" } };
}

- (NSURL *)URLForStoreName:(NSString *)storeName
{
    NSString *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *storeAbsolutePath  = [documentsDirectory stringByAppendingPathComponent:storeName];
    return [NSURL fileURLWithPath:storeAbsolutePath];
}

- (NSManagedObjectModel *)mergedObjectModel
{
    return [NSManagedObjectModel mergedModelFromBundles:nil];
}

@end