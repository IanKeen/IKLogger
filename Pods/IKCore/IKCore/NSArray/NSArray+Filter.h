//
//  NSArray+Filter
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef BOOL (^filterFunction)(id item);

@interface NSArray (Filter)
/**
 *  Returns a subset of items who pass the provided predicate
 *
 *  @param function A predicate to test each item in the list with
 *
 *  @return NSArray subset of item whose predicate result was YES
 */
-(NSArray *)filter:(filterFunction)function;
@end