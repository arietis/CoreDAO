//
//  ManagedObject.h
//  CoreDAO
//
//  Created by Egor Taflanidi on 30/10/15.
//  Copyright © 2015 RedMadRobot LLC. All rights reserved.
//

#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface ManagedObject : NSManagedObject

- (NSManagedObject *)initWithClass:(Class)klass
                         inContext:(NSManagedObjectContext *)context;

+ (NSManagedObject *)objectOfClass:(Class)klass
                         inContext:(NSManagedObjectContext *)context;

@end

NS_ASSUME_NONNULL_END
