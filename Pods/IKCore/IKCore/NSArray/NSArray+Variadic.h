//
//  NSArray+Variadic
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Variadic)
/**
 *  Returns an NSArray with a size of 'size' containing the elements from the variadic parameters
 *  'nil' is replaced with instances of NSNull
 *
 *  NOTE: The vadiadic parameter list does not need to be nil terminated
 *
 *  @param size        <#size description#>
 *  @param firstObject <#firstObject description#>
 *
 *  @return <#return value description#>
 */
+(instancetype)arraySized:(NSInteger)size values:(id)firstObject, ...;
@end
