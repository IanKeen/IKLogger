//
//  NSObject+Null
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Determine not only if an object is nil, but also if it is empty
 *  i.e.:
 *  NSArray/NSDictionary/NSSet with no items
 *  NSString with a length of 0
 *  any NSNull
 *
 *  @param object Object to test;
 *
 *  @return YES if the object is nil/emtpy otherwise NO
 */
extern BOOL nilOrEmpty(id object);

@interface NSObject (NilOrEmpty)
/**
 *  Determine not only if an object is nil, but also if it is empty
 *  i.e.:
 *  NSArray/NSDictionary/NSSet with no items
 *  NSString with a length of 0
 *  any NSNull
 *
 *  @param object Object to test;
 *
 *  @return YES if the object is nil/emtpy otherwise NO
 */
+(BOOL)nilOrEmpty:(id)object;
@end