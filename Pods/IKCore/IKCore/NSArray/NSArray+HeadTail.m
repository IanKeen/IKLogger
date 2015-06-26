//
//  NSArray+HeadTail
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import "NSArray+HeadTail.h"

@implementation NSArray (HeadTail)
-(id)head { return [self firstObject]; }
-(NSArray *)tail {
    NSMutableArray *copy = [NSMutableArray arrayWithArray:[self copy]];
    if (copy.count > 0) { [copy removeObjectAtIndex:0]; }
    return copy;
}
@end