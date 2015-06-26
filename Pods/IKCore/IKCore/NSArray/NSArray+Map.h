//
//  NSArray+Map
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id (^mapFunction)(id item);
typedef id (^mapWithIndexFunction)(NSInteger index, id item);
typedef NSArray * (^flatMapFunction)(id item);

@interface NSArray (Map)
/**
 *  Maps each element of the array, transforming them to a new value
 *  Nil values are stripped from the result
 *
 *  @param function A function that takes an array element and returns a new value
 *
 *  @return A new NSArray with the results of function
 */
-(NSArray *)map:(mapFunction)function;

/**
 *  Maps each element of the array, transforming them to a new value
 *  Nil values are stripped from the result
 *
 *  @param function A function that takes an array element and its index within the array and returns a new value
 *
 *  @return A new NSArray with the results of function
 */
-(NSArray *)mapWithIndex:(mapWithIndexFunction)function;

/**
 *  Returns a new array containing the concatenated results of executing function on each element
 *
 *  @param function A function that takes an array element and returns 
 *
 *  @return A flat (single dimensional) NSArray containing all the results of each execution of function
 */
-(NSArray *)flatMap:(flatMapFunction)function;
@end