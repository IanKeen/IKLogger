//
//  NSSet+Map
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id (^setMapFunction)(id item);

@interface NSSet (Map)
/**
 *  Executes the supplied block on each element and returns a new NSSet with the returned values
 *  NOTE: The same NSSet rules apply, duplicates are removed.
 *          Blocks can also return nil to 'remove' themselves from the resulting NSSet
 *
 *  @param function Block to execute on each element
 *
 *  @return New NSSet containing the results of each block
 */
-(NSSet *)map:(setMapFunction)function;
@end
