//
//  DatabaseEntry.h
//  CoreDAO
//
//  Created by Egor Taflanidi on 28/07/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import <Realm/Realm.h>

/**
 Сущность базы данных Realm.
 */
@interface RLMEntry : RLMObject

/**
 Фабричный метод для создания «нулевого» объекта.
 У «нулевого» объекта идентификатор равен нулю.
 */
+ (instancetype)nullEntry;

/**
 Идентификатор сущности.
 */
@property NSString *entryId;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<RLMEntry>
RLM_ARRAY_TYPE(RLMEntry)
