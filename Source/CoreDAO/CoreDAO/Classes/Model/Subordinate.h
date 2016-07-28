// 
// Subordinate.h
// AppCode
// 
// Created by Egor Taflanidi on 27/10/15.
// Copyright (c) 2015 RedMadRobot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Протокол для вложенных объектов.
 
 Следуя этому протоколу, объект обязан возвращать количество ссылок на себя.
 Если количество ссылок достигает нуля -- объект удаляется из базы данных.
 */
@protocol Subordinate <NSObject>
@required

/**
 Метод, возвращающий количество ссылок на объект.
 Для ORM Realm может быть задействована функция -linkingObjectsOfClass:forProperty:
 
 Пример:
 
 @interface Person : RLMEntry
 @property Dog *dog;
 @end
 
 @interface Dog : RLMEntry <Subordinate>
 @property NSString *name;
 @end
 
 @implementation Dog
 
 - (NSUInteger)referenceCount
 {
    return [self linkingObjectsOfClass:@"Person" forProperty:@"dog"].count;
 }
 
 @end
 
 @return Возвращает количество ссылок на объект.
 */
- (NSUInteger)referenceCount;

@end