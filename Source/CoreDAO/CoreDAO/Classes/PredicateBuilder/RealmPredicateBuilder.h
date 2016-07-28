//
//  RealmPredicateBuilder.h
//  CoreDAO
//
//  Created by Egor Taflanidi on 27/10/15.
//  Copyright © 2015 RedMadRobot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Построитель предикатов для ORM Realm.
 */
@interface RealmPredicateBuilder : NSObject

/**
 Конструктор.
 
 @return Возвращает инициированный объект RealmPredicateBuilder.
 */
+ (instancetype)builder;

/**
 Создать предикат.
 
 @return Конструирует предикат.
 */
- (NSPredicate *)create;

/**
 field == value
    
 @param field - название поля;
 @param value - значение.
 */
- (instancetype)field:(NSString *)field
               equals:(id)value;

/**
 field != value
 
 @param field - название поля;
 @param value - значение.
 */
- (instancetype)field:(NSString *)field
            notEquals:(id)value;

/**
 field CONTAINS string
 
 Метод не чувствителен к регистру.
 
 @param field - название поля;
 @param string - строка, которая должна в поле содержаться.
 */
- (instancetype)field:(NSString *)field
             contains:(NSString *)string;

/**
 field CONTAINS[???] string
 
 @param field - название поля;
 @param string - строка, которая должна в поле содержаться;
 @param caseSensitive - чувствительность к регистру.
 */
- (instancetype)field:(NSString *)field
             contains:(NSString *)string
        caseSensitive:(BOOL)caseSensitive;

/**
 field > value
 
 @param field - название поля;
 @param value - значение.
 */
- (instancetype)field:(NSString *)field
          greaterThan:(NSNumber *)value;

/**
 field >= value
 
 @param field - название поля;
 @param value - значение.
 */
- (instancetype)field:(NSString *)field
      greaterOrEquals:(NSNumber *)value;

/**
 field < value
 
 @param field - название поля;
 @param value - значение.
 */
- (instancetype)field:(NSString *)field
          smallerThan:(NSNumber *)value;

/**
 field <= value
 
 @param field - название поля;
 @param value - значение.
 */
- (instancetype)field:(NSString *)field
      smallerOrEquals:(NSNumber *)value;

/**
 left <= field <= right
 
 @param field - название поля;
 @param left - левая граница;
 @param right - правая граница.
 */
- (instancetype)field:(NSString *)field
              between:(NSNumber *)left
                  and:(NSNumber *)right;

@end

NS_ASSUME_NONNULL_END
