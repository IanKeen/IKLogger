//
//  NSSet+Map
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import "NSSet+Map.h"

@implementation NSSet (Map)
-(NSSet *)map:(setMapFunction)function {
    NSMutableSet *result = [NSMutableSet new];
    [self enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        id value = function(obj);
        if (value != nil) {
            [result addObject:value];
        }
    }];
    return result;
}
@end
