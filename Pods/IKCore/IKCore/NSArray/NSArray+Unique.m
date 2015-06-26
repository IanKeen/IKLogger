//
//  NSArray+Unique
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import "NSArray+Unique.h"
#import "NSArray+Reduce.h"

@implementation NSArray (Unique)
-(NSArray *)unique {
    NSOrderedSet *set = [NSOrderedSet orderedSetWithArray:self];
    return [NSArray arrayWithArray:set.array];
}
@end
