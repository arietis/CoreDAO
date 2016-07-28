//
//  TidyRealmDAO.h
//  CoreDAO
//
//  Created by Egor Taflanidi on 27/10/15.
//  Copyright © 2015 RedMadRobot LLC. All rights reserved.
//

#import <CoreDAO/CoreDAO.h>

/**
 Режимы очистки.
 */
typedef NS_ENUM(NSUInteger, DAOCleanupMode) {
    /**
     Значение по умолчанию.
     Никогда не проводить очистку.
     */
    DAOCleanupModeNever,
    
    /**
     Проводить очистку при каждом вызове -read, -readAll, -readAllPredicated: etc.
     */
    DAOCleanupModeEveryRead,
    
    /**
     Проводить очистку при каждом вызове -persist: и -persistAll:
     */
    DAOCleanupModeEveryWrite
};

/**
 ORM Realm DAO, дополнительно производящий периодическую очистку таблицы.
 @see DAOCleanupMode
 */
@interface TidyRealmDAO : RealmDAO

/**
 Конструктор.
 При создании DAO требует преобразователь доменных сущностей и режим, следуя которому будет 
 производиться очистка таблицы.
 
 @param translator - преобразователь сущностей базы данных в модельные объекты и обратно;
 @param cleanupMode - режим очистки таблицы.
 
 @return Возвращает инициированный объект DAO.
 */
- (instancetype)initWithTranslator:(RealmTranslator *)translator
                       cleanupMode:(DAOCleanupMode)cleanupMode;

/**
 Конструктор.
 При создании DAO требует преобразователь доменных сущностей и режим, следуя которому будет 
 производиться очистка таблицы.
 
 @param translator - преобразователь сущностей базы данных в модельные объекты и обратно;
 @param cleanupMode - режим очистки таблицы.
 
 @return Возвращает инициированный объект DAO.
 */
+ (instancetype)daoWithTranslator:(RealmTranslator *)translator 
                      cleanupMode:(DAOCleanupMode)cleanupMode;

/**
 Метод для запуска механизма очистки.
 */
- (void)cleanup;

@end
