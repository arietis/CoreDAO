//
//  CascadeDelete.h
//  CoreDAO
//
//  Created by Egor Taflanidi on 14.12.15.
//  Copyright © 2015 RedMadRobot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Объект, поддерживающий каскадное удаление.
 */
@protocol CascadeDelete <NSObject>
@required

/**
 Список полей, содержащих объекты, подлежащие каскадному удалению.
 @return Возвращает массив названий полей (NSString *). Может быть пустым, не может быть nil.
 */
- (NSArray<NSString *> *)cascadeDeleteProperties;

@end
