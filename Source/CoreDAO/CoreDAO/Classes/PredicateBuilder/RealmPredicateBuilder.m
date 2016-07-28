//
//  RealmPredicateBuilder.m
//  CoreDAO
//
//  Created by Egor Taflanidi on 27/10/15.
//  Copyright © 2015 RedMadRobot LLC. All rights reserved.
//

#import "RealmPredicateBuilder.h"

@interface RealmPredicateBuilder ()
@property (nonatomic, strong) NSMutableString *format;
@end

@implementation RealmPredicateBuilder

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.format = [[NSMutableString alloc] init];
    }

    return self;
}

+ (instancetype)builder
{
    return [[self alloc] init];
}

- (NSPredicate *)create
{
    return [NSPredicate predicateWithFormat:[NSString stringWithString:self.format]];
}

- (instancetype)field:(NSString *)field
               equals:(id)value
{
    NSString *condition = [NSString stringWithFormat:@"%@ == %@", field, value];
    [self appendFormatWithCondition:condition];
    return self;
}

- (instancetype)field:(NSString *)field
            notEquals:(id)value
{
    NSString *condition = [NSString stringWithFormat:@"%@ != %@", field, value];
    [self appendFormatWithCondition:condition];
    return self;
}

- (instancetype)field:(NSString *)field
             contains:(NSString *)string
{
    return [self field:field
              contains:string
         caseSensitive:NO];
}

- (instancetype)field:(NSString *)field
             contains:(NSString *)string
        caseSensitive:(BOOL)caseSensitive
{
    NSString *condition;
    if (caseSensitive) {
        condition = [NSString stringWithFormat:@"%@ CONTAINS '%@'", field, string];
    } else {
        condition = [NSString stringWithFormat:@"%@ CONTAINS[c] '%@'", field, string];
    }

    [self appendFormatWithCondition:condition];
    return self;
}

- (instancetype)field:(NSString *)field
          greaterThan:(NSNumber *)value
{
    NSString *condition = [NSString stringWithFormat:@"%@ > %@", field, value];
    [self appendFormatWithCondition:condition];
    return self;
}

- (instancetype)field:(NSString *)field
      greaterOrEquals:(NSNumber *)value
{
    NSString *condition = [NSString stringWithFormat:@"%@ >= %@", field, value];
    [self appendFormatWithCondition:condition];
    return self;
}

- (instancetype)field:(NSString *)field
          smallerThan:(NSNumber *)value
{
    NSString *condition = [NSString stringWithFormat:@"%@ < %@", field, value];
    [self appendFormatWithCondition:condition];
    return self;
}

- (instancetype)field:(NSString *)field
      smallerOrEquals:(NSNumber *)value
{
    NSString *condition = [NSString stringWithFormat:@"%@ <= %@", field, value];
    [self appendFormatWithCondition:condition];
    return self;
}

- (instancetype)field:(NSString *)field
              between:(NSNumber *)left
                  and:(NSNumber *)right
{
    NSString *condition = [NSString stringWithFormat:@"%@ BETWEEN {%@,%@}", field, left, right];
    [self appendFormatWithCondition:condition];
    return self;
}

- (void)appendFormatWithCondition:(NSString *)condition
{
    if (self.format.length) {
        [self.format appendFormat:@" AND %@", condition];
    } else {
        [self.format appendString:condition];
    }
}

@end
