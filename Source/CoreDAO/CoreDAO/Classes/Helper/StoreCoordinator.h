// 
// StoreCoordinator.h
// AppCode
// 
// Created by Egor Taflanidi on 29/10/15.
// Copyright (c) 2015 Egor Taflanidi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface StoreCoordinator : NSPersistentStoreCoordinator

- (instancetype)initWithStoreName:(NSString *)storeName;

+ (instancetype)coordinatorWithStoreName:(NSString *)storageName;

@end