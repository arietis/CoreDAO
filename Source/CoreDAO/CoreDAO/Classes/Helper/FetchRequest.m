//
//  FetchRequest.m
//  CoreDAO
//
//  Created by Egor Taflanidi on 30/10/15.
//  Copyright © 2015 RedMadRobot LLC. All rights reserved.
//

#import "FetchRequest.h"

@implementation FetchRequest

- (instancetype)initWithEntryClass:(Class)entryClass
{
    return [self initWithEntityName:[self nameWithClass:entryClass]];
}

- (instancetype)initWithEntryClass:(Class)entryClass
                         predicate:(NSPredicate *)predicate
{
    if (self = [self initWithEntityName:[self nameWithClass:entryClass]]) {
        self.predicate = predicate;
    }
    return self;
}

- (instancetype)initWithEntryClass:(Class)entryClass
                         predicate:(NSPredicate *)predicate
                   sortDescriptors:(NSArray <NSSortDescriptor *> *)descriptors
{
    if (self = [self initWithEntityName:[self nameWithClass:entryClass]]) {
        self.predicate = predicate;
        self.sortDescriptors = descriptors;
    }
    return nil;
}

+ (instancetype)fetchRequestWithEntryClass:(Class)entryClass
{
    return [[self alloc] initWithEntryClass:entryClass];
}

+ (instancetype)fetchRequestWithEntryClass:(Class)entryClass
                                 predicate:(NSPredicate *)predicate
{
    return [[self alloc] initWithEntryClass:entryClass
                                  predicate:predicate];
}

+ (instancetype)fetchRequestWithEntryClass:(Class)entryClass
                                 predicate:(NSPredicate *)predicate
                           sortDescriptors:(NSArray <NSSortDescriptor *> *)descriptors
{
    return [[self alloc] initWithEntryClass:entryClass
                                  predicate:predicate
                            sortDescriptors:descriptors];
}

- (NSString *)nameWithClass:(Class)klass
{
    return [NSStringFromClass(klass) componentsSeparatedByString:@"."].lastObject;
}

@end
