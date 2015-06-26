//
//  NSArray+Variadic
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import "NSArray+Variadic.h"
#import "NSObject+Null.h"

@implementation NSArray (Variadic)
+(instancetype)arraySized:(NSInteger)size values:(id)firstObject, ... {
    NSMutableArray *result = [NSMutableArray array];
    
    if (size > 0) {
        [result addObject:[self valueOrNSNull:firstObject]];
    }
    
    va_list argumentList;
    va_start(argumentList, firstObject);
    for (NSInteger index = 1; index < size; index++) {
        id object = [self valueOrNSNull:va_arg(argumentList, id)];
        [result addObject:object];
    }
    va_end(argumentList);
    
    return result;
}
+(id)valueOrNSNull:(id)value {
    return (value ?: [NSNull null]);
}
@end
