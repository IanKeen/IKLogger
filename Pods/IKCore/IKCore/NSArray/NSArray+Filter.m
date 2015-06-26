//
//  NSArray+Filter
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import "NSArray+Filter.h"

@implementation NSArray (Filter)
-(NSArray *)filter:(filterFunction)function {
    NSMutableArray *result = [NSMutableArray new];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (function(obj)) {
            [result addObject:obj];
        }
    }];
    return result;
}
@end