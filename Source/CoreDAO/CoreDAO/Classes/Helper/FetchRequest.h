//
//  FetchRequest.h
//  CoreDAO
//
//  Created by Egor Taflanidi on 30/10/15.
//  Copyright © 2015 RedMadRobot LLC. All rights reserved.
//

#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface FetchRequest : NSFetchRequest

- (instancetype)initWithEntryClass:(Class)entryClass;

- (instancetype)initWithEntryClass:(Class)entryClass
                         predicate:(NSPredicate *)predicate;

- (instancetype)initWithEntryClass:(Class)entryClass
                         predicate:(NSPredicate *)predicate
                   sortDescriptors:(NSArray <NSSortDescriptor *> *)descriptors;

+ (instancetype)fetchRequestWithEntryClass:(Class)entryClass;

+ (instancetype)fetchRequestWithEntryClass:(Class)entryClass
                                 predicate:(NSPredicate *)predicate;

+ (instancetype)fetchRequestWithEntryClass:(Class)entryClass
                                 predicate:(NSPredicate *)predicate
                           sortDescriptors:(NSArray <NSSortDescriptor *> *)descriptors;

@end

NS_ASSUME_NONNULL_END
