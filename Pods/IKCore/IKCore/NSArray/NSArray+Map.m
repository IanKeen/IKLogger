//
//  NSArray+Map
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import "NSArray+Map.h"

@implementation NSArray (Map)
-(NSArray *)mapWithIndex:(mapWithIndexFunction)function {
    NSMutableArray *result = [NSMutableArray new];
    [self enumerateObjectsUsingBlock:^(id item, NSUInteger idx, BOOL *stop) {
        id value = function(idx, item);
        if (value != nil) {
            [result addObject:value];
        }
    }];
    return result;
}
-(NSArray *)map:(mapFunction)function {
    return [self mapWithIndex:^id(NSInteger index, id item) {
        return function(item);
    }];
}
-(NSArray *)flatMap:(flatMapFunction)function {
    NSMutableArray *result = [NSMutableArray new];
    [self enumerateObjectsUsingBlock:^(id item, NSUInteger idx, BOOL *stop) {
        NSArray *values = [NSArray arrayWithArray:function(item)];
        if (values.count > 0) {
            [result addObjectsFromArray:values];
        }
    }];
    return result;
}
@end