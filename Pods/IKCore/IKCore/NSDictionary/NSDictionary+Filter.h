//
//  NSDictionary+Filter
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef BOOL (^dictionaryFilterFunction)(id key, id value);

@interface NSDictionary (Filter)
/**
 *  Returns a new NSDictionary containing the key/value pairs that pass the given predicate
 *
 *  @param function Predicate a key/value pair should pass to be in the output
 *
 *  @return New NSDictionary
 */
-(NSDictionary *)filter:(dictionaryFilterFunction)function;
@end
