//
//  DAO.h
//  CoreDAO
//
//  Created by Egor Taflanidi on 28/07/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreDAO/Persistable.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Абстрактный DAO.
 */
@protocol DAO <NSObject>
@required

#pragma mark - Вставка / обновление

/**
 Сохранить или обновить объект.
 
 @param entity - объект для сохранения; идентификатор объекта должен быть != nil. Если объект с 
 указанным идентификатором уже существует -- он будет переписан.
 
 @return Возвращает статус операции записи. YES -- если операция прошла успешно, иначе NO.
 */
- (BOOL)persist:(id <Persistable>)entity;

/**
 Сохранить коллекцию объектов.
 
 @param entities - объекты для сохранения; идентификатор каждого объекта должен быть != nil. Если 
 объект с указанным идентификатором уже существует -- он будет переписан.
 
 @return Возвращает статус операции записи. YES -- если операция прошла успешно, иначе NO.
 */
- (BOOL)persistAll:(NSArray<id <Persistable>> *)entities;

#pragma mark - Чтение

/**
 Метод для получения объекта по идентификатору.
 
 @param entryId - идентификатор объекта.
 
 @return Возвращает объект с заданным идентификатором. Если такого не существует -- возвращает nil.
 */
- (id <Persistable>)read:(id)entityId;

/**
 Метод для получения всех объектов из таблицы, обрабатываемой этим DAO.
 
 @return Возвращает коллекцию объектов из таблицы, обрабатываемой этим DAO. Коллекция может быть 
 пустой и не может быть nil.
 */
- (NSArray<id <Persistable>> *)readAll;

/**
 Метод для получения всех объектов из таблицы, обрабатываемой этим DAO. 
 Выборка фильтруется согласно предикату.
 
 @param predicate - предикат для фильтрации.
 
 @return Возвращает коллекцию объектов из таблицы, обрабатываемой этим DAO. Коллекция может быть 
 пустой и не может быть nil.
 */
- (NSArray<id <Persistable>> *)readAllPredicated:(nullable NSPredicate *)predicate;

/**
 Метод для получения всех объектов из таблицы, обрабатываемой этим DAO. 
 Выборка сортируется по полю модельного объекта.
 
 @param field - название поля, по которому сортируется выборка;
 @param ascending - возрастание или убывание значения.
 
 @return Возвращает отсортированную коллекцию объектов из таблицы, обрабатываемой этим DAO. 
 Коллекция может быть пустой и не может быть nil.
 */
- (NSArray<id <Persistable>> *)readAllOrderBy:(nullable NSString *)field
                                    ascending:(BOOL)ascending;

/**
 Метод для получения всех объектов из таблицы, обрабатываемой этим DAO. 
 Выборка фильтруется согласно предикату и сортируется по полю модельного объекта.
 
 @param predicate - предикат для фильтрации;
 @param field - название поля, по которому сортируется выборка;
 @param ascending - возрастание или убывание значения.
 
 @return Возвращает отсортированную коллекцию объектов из таблицы, обрабатываемой этим DAO. 
 Коллекция может быть пустой и не может быть nil.
 */
- (NSArray<id <Persistable>> *)readAllPredicated:(nullable NSPredicate *)predicate
                                         orderBy:(nullable NSString *)field
                                       ascending:(BOOL)ascending;

#pragma mark - Удаление

/**
 Удалить все сущности типа, обрабатываемого этим DAO.
 */
- (void)erase;

/**
 Удалить объект по идентификатору.
 
 Если объект по указанному идентификатору не существует -- исключения не случается.
 
 @param entryId - идентификатор объекта.
 */
- (void)erase:(id)entityId;

@end

NS_ASSUME_NONNULL_END
