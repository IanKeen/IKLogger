//
//  NSArray+All
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef BOOL (^allFunction)(id item);

@interface NSArray (All)
/**
 *  Performs a predicate based on each item in the array
 *
 *  @param function A predicate test to perform on each item in the array
 *
 *  @return Returns YES if all predicates pass, otherwise NO
 */
-(BOOL)all:(allFunction)function;
@end
