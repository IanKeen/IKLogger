//
//  NSArray+Reduce
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import "NSArray+Reduce.h"

@implementation NSArray (Reduce)
-(id)reduce:(id)initial function:(reduceFunction)function {
    __block id value = initial;
    [self enumerateObjectsUsingBlock:^(id item, NSUInteger idx, BOOL *stop) {
        value = function(value, item);
    }];
    return value;
}
@end