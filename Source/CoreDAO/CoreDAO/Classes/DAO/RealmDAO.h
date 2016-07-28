//
//  RealmDAO.h
//  CoreDAO
//
//  Created by Egor Taflanidi on 28/07/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreDAO/DAO.h>

@class RealmTranslator;

NS_ASSUME_NONNULL_BEGIN

/**
 DAO для ORM Realm.
 */
@interface RealmDAO : NSObject <DAO>

- (instancetype)init NS_UNAVAILABLE;

/**
 Конструктор.
 При создании DAO требует преобразователь доменных сущностей.
 
 @param translator - преобразователь сущностей базы данных в модельные объекты и обратно.
 
 @return Возвращает инициированный объект DAO.
 */
- (instancetype)initWithTranslator:(RealmTranslator *)translator;

/**
 Конструктор.
 При создании DAO требует преобразователь доменных сущностей.
 
 @param translator - преобразователь сущностей базы данных в модельные объекты и обратно.
 
 @return Возвращает инициированный объект DAO.
 */
+ (instancetype)daoWithTranslator:(RealmTranslator *)translator;

/**
 Получить текущее название файла базы данных.
 По умолчанию "Database.realm"
 
 @return Возвращает название файла базы данных.
 */
+ (NSString *)databaseFilename;

/**
 Присвоить название файла базы данных.
 Задавать абсолютный путь не требуется, только название файла.
 
 @param newFilename - название файла базы данных.
 */
+ (void)assignDatabaseFilename:(NSString *)newFilename;

/**
 Получить используемую версию базы данных.
 По умолчанию 1.
 
 @return Возвращает версию базы данных (версию схемы объектов).
 */
+ (NSUInteger)databaseVersion;

/**
 Задать используемую версию базы данных.
 
 @param newVersion - версия базы данных (версия схемы объектов).
 */
+ (void)assignDatabaseVersion:(NSUInteger)newVersion;

@end

NS_ASSUME_NONNULL_END
