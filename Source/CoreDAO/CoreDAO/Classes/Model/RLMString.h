//
//  RLMString.h
//  AlfaStrah
//
//  Created by Egor Taflanidi on 04/06/27 H.
//  Copyright (c) 27 Heisei RedMadRobot. All rights reserved.
//

#import <Realm/Realm.h>

/**
 Репрезентация строки для сохранения массивов строк.
 */
@interface RLMString : RLMObject

@property NSString *string;

+ (instancetype)stringWithString:(NSString *)string;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<RLMString>
RLM_ARRAY_TYPE(RLMString)
