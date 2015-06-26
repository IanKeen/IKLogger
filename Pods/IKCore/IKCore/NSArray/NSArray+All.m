//
//  NSArray+All
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import "NSArray+All.h"

@implementation NSArray (All)
-(BOOL)all:(allFunction)function {
    __block BOOL result = YES;
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (!function(obj)) {
            result = NO;
            *stop = YES;
        }
    }];
    return result;
}
@end
