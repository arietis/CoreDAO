//
//  CoreDAO.h
//  CoreDAO
//
//  Created by Egor Taflanidi on 28/07/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for CoreDAO.
FOUNDATION_EXPORT double CoreDAOVersionNumber;

//! Project version string for CoreDAO.
FOUNDATION_EXPORT const unsigned char CoreDAOVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <CoreDAO/PublicHeader.h>

#import <CoreDAO/DAO.h>

#import <CoreDAO/Persistable.h>
#import <CoreDAO/Subordinate.h>
#import <CoreDAO/CascadeDelete.h>

#import <CoreDAO/RealmDAO.h>
#import <CoreDAO/TidyRealmDAO.h>
#import <CoreDAO/RealmTranslator.h>
#import <CoreDAO/RLMEntry.h>
#import <CoreDAO/RLMString.h>
#import <CoreDAO/RealmPredicateBuilder.h>

#import <CoreDAO/CoreDataDAO.h>
#import <CoreDAO/CoreDataTranslator.h>

#import <CoreDAO/FetchRequest.h>
#import <CoreDAO/ManagedObject.h>
#import <CoreDAO/RealmDAO+Protected.h>
#import <CoreDAO/StoreCoordinator.h>
