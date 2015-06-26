//
//  NSObject+Introspection
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Introspection)
/**
 *  Determine if the receiving class has a property that is decorated with a specific protocol
 *
 *  @param name     Property name to check
 *  @param protocol Protocol to test for
 *
 *  @return YES if property is marked with protocol otherwise NO
 */
+(BOOL)property:(NSString *)name decoratedWith:(Protocol *)protocol;

/**
 *  Gather a list of all properties in a class decorated with a specific protocol
 *
 *  @param protocol Protocol to look for
 *
 *  @return NSArray of NSStrings representing any properties marked with the protocol
 */
+(NSArray *)propertiesDecoratedWith:(Protocol *)protocol;
@end
