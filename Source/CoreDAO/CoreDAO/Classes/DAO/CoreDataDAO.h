//
//  CoreDataDAO.h
//  CoreDAO
//
//  Created by Egor Taflanidi on 30/07/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreDAO/DAO.h>
#import <CoreData/CoreData.h>

@class CoreDataTranslator;
@class StoreCoordinator;

NS_ASSUME_NONNULL_BEGIN

/**
 DAO для ORM Core Data.
 
 Название файла базы данных по умолчанию:
 Database.db
 */
@interface CoreDataDAO : NSObject <DAO>

- (instancetype)init NS_UNAVAILABLE;

/**
 Конструктор.
 При создании DAO требует преобразователь доменных сущностей.
 
 @param translator - преобразователь сущностей базы данных в модельные объекты и обратно.
 
 @return Возвращает инициированный объект DAO.
 */
- (instancetype)initWithTranslator:(CoreDataTranslator *)translator;

/**
 Конструктор.
 При создании DAO требует преобразователь доменных сущностей.
 Кроме того, можно задать название файла базы данных.
 
 @param translator - преобразователь сущностей базы данных в модельные объекты и обратно;
 @param storeName - имя файла базы данных.
 
 @return Возвращает инициированный объект DAO.
 */
- (instancetype)initWithTranslator:(CoreDataTranslator *)translator
                         storeName:(NSString *)storeName;

/**
 Конструктор.
 При создании DAO требует преобразователь доменных сущностей.
 
 @param translator - преобразователь сущностей базы данных в модельные объекты и обратно.
 
 @return Возвращает инициированный объект DAO.
 */
+ (instancetype)daoWithTranslator:(CoreDataTranslator *)translator;

/**
 Конструктор.
 При создании DAO требует преобразователь доменных сущностей.
 Кроме того, можно задать название файла базы данных.
 
 @param translator - преобразователь сущностей базы данных в модельные объекты и обратно;
 @param storeName - имя файла базы данных.
 
 @return Возвращает инициированный объект DAO.
 */
+ (instancetype)daoWithTranslator:(CoreDataTranslator *)translator
                        storeName:(NSString *)storeName;

@end

NS_ASSUME_NONNULL_END
