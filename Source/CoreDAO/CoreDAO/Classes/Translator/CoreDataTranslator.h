//
//  CoreDataTranslator.h
//  CoreDAO
//
//  Created by Egor Taflanidi on 17/08/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@protocol Persistable;

/**
 Сущность для преобразования модельных объектов в объекты базы данных и обратно.
 */
@interface CoreDataTranslator : NSObject

+ (instancetype)translator;

- (Class)entityClass;

- (Class)entryClass;

- (BOOL)fillEntity:(id <Persistable>)entity
         withEntry:(NSManagedObject *)entry;

- (BOOL)fillEntry:(NSManagedObject *)entry
       withEntity:(id <Persistable>)entity
        inContext:(NSManagedObjectContext *)context;

@end
