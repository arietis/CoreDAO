//
//  RealmTranslator.h
//  CoreDAO
//
//  Created by Egor Taflanidi on 29/07/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@protocol Persistable;
@class RLMEntry;

/**
 Сущность для преобразования модельных объектов в объекты базы данных и обратно.
 */
@interface RealmTranslator : NSObject

+ (instancetype)translator;

- (RLMEntry *)toEntry:(id <Persistable>)entity;

- (id<Persistable>)toEntity:(RLMEntry *)entry;

- (NSString *)entryClass;

- (NSArray *)toEntries:(NSArray *)entities;

- (NSArray *)toEntities:(id <NSFastEnumeration>)entries;

- (RLMArray *)toRealmArray:(NSArray *)array;

@end
