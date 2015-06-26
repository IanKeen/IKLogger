//
//  NSDictionary+Filter
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import "NSDictionary+Filter.h"

@implementation NSDictionary (Filter)
-(NSDictionary *)filter:(dictionaryFilterFunction)function {
    NSMutableDictionary *result = [NSMutableDictionary new];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (function(key, obj)) { result[key] = obj; }
    }];
    return result;
}
@end
