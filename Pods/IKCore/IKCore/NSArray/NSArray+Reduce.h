//
//  NSArray+Reduce
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id (^reduceFunction)(id accumulator, id item);

@interface NSArray (Reduce)
/**
 *  Returns a single value accumulated from the result of calling function on each value in the array
 *
 *  @param initial  The initial value to start with
 *  @param function A function that takes the current accumulated value, the value of the current element and returns a new accumulated value
 *
 *  @return The final accumulated value
 */
-(id)reduce:(id)initial function:(reduceFunction)function;
@end