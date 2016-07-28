//
//  RealmDAO+Protected.h
//  CoreDAO
//
//  Created by Egor Taflanidi on 27/10/15.
//  Copyright © 2015 RedMadRobot LLC. All rights reserved.
//

#import <CoreDAO/CoreDAO.h>

/**
 Protected-методы.
 */
@interface RealmDAO (Protected)
- (RLMResults *)readAllEntriesPredicated:(NSPredicate *)predicate;
- (void)deleteEntriesTransaction:(id)entries;
@end
