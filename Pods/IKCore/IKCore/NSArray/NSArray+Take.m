//
//  NSArray+Take
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import "NSArray+Take.h"

@implementation NSArray (Take)
-(NSArray *)take:(NSInteger)number {
    NSInteger arrayCount = self.count; //cast to NSInteger from NSUInteger to ensure MIN/MAX work correctly
    NSInteger count = MAX(MIN(number, arrayCount), 0); //MIN/MAX require the same data type to ensure accurate output
    
    NSMutableArray *result = [NSMutableArray array];
    if (count > 0) {
        [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [result addObject:obj];
            *stop = ((idx + 1) == count);
        }];
    }
    
    return result;
}
@end
