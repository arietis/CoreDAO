//
//  ManagedObject.m
//  CoreDAO
//
//  Created by Egor Taflanidi on 30/10/15.
//  Copyright © 2015 RedMadRobot LLC. All rights reserved.
//

#import "ManagedObject.h"

@implementation ManagedObject

- (NSManagedObject *)initWithClass:(Class)klass
                         inContext:(NSManagedObjectContext *)context
{
    return [self initWithEntity:[self entityWithClass:klass context:context]
 insertIntoManagedObjectContext:context];
}

+ (NSManagedObject *)objectOfClass:(Class)klass
                         inContext:(NSManagedObjectContext *)context
{
    return [[self alloc] initWithClass:klass
                             inContext:context];
}

- (NSEntityDescription *)entityWithClass:(Class)klass
                                 context:(NSManagedObjectContext *)context
{
    return [NSEntityDescription entityForName:[self nameForClass:klass]
                       inManagedObjectContext:context];
}

- (NSString *)nameForClass:(Class)klass
{
    return [NSStringFromClass(klass) componentsSeparatedByString:@"."].lastObject;
}

@end
