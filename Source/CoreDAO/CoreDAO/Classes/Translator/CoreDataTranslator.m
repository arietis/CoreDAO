//
//  CoreDataTranslator.m
//  CoreDAO
//
//  Created by Egor Taflanidi on 17/08/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import "CoreDataTranslator.h"

@implementation CoreDataTranslator

+ (instancetype)translator
{
    return [[[self class] alloc] init];
}

- (Class)entityClass
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"Abstract method"
                                 userInfo:nil];
}

- (Class)entryClass
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"Abstract method"
                                 userInfo:nil];
}

- (BOOL)fillEntity:(id <Persistable>)entity
         withEntry:(NSManagedObject *)entry
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"Abstract method"
                                 userInfo:nil];
}

- (BOOL)fillEntry:(NSManagedObject *)entry
       withEntity:(id <Persistable>)entity
        inContext:(NSManagedObjectContext *)context
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"Abstract method"
                                 userInfo:nil];
}
@end
