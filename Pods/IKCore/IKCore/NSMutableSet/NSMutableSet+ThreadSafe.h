//
//  NSMutableSet+ThreadSafe
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import <Foundation/Foundation.h>


//TODO: add tests


/**
 *  Adds an additional parameter to the standard data access selectors to
 *  route them through the supplied serial queue to ensure thread safe access
 */
@interface NSMutableSet (ThreadSafe)
-(void)addObject:(id)object serialQueue:(dispatch_queue_t)queue;
-(void)removeObject:(id)object serialQueue:(dispatch_queue_t)queue;
-(void)removeAllObjectsUsingSerialQueue:(dispatch_queue_t)queue;
-(NSUInteger)countUsingSerialQueue:(dispatch_queue_t)queue;
-(NSArray *)allObjectsUsingSerialQueue:(dispatch_queue_t)queue;
@end