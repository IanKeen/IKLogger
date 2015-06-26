//
//  NSArray+Group
//
//  Created by Ian Keen on 12/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import "NSArray+Group.h"

@implementation NSArray (Group)
-(NSDictionary *)groupBy:(groupFunction)function {
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        id key = function(obj);
        if (key) {
            NSArray *items = result[key] ?: [NSArray array];
            result[key] = [items arrayByAddingObject:obj];
        }
    }];
    return result;
}
@end
