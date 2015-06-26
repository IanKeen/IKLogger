//
//  NSArray+HeadTail
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (HeadTail)
/**
 *  @return Returns the first element of the array
 */
-(id)head;

/**
 *  @return NSArray containing all elements of the array except the first (head)
 */
-(NSArray *)tail;
@end