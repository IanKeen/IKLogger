//
//  NSObject+Map
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id (^mapValueFunction)(id value);

@interface NSObject (Map)
/**
 *  Maps the current value of the receiver into the value returned by the block
 */
@property (nonatomic, strong, readonly) NSObject * (^map)(mapValueFunction function);

/**
 *  Maps the current value of the receiver into the value returned by the selector
 */
@property (nonatomic, strong, readonly) NSObject * (^mapSelector)(id object, SEL selector);
@end
