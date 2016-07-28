//
//  Persistable.h
//  CoreDAO
//
//  Created by Egor Taflanidi on 28/07/27 H.
//  Copyright (c) 27 Heisei RedMadRobot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Объект, который можно сохранить в базу данных.
 */
@protocol Persistable <NSObject>
@required

/**
 Идентификатор сущности.
 */
@property (nonatomic, copy) id entityId;

@end
