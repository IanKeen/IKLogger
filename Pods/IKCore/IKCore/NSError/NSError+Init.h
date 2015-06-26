//
//  NSError+Init
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const MSErrorData;

@interface NSError (Shortcut)
/**
 *  Convenience constructor for NSErrors
 *
 *  @param domain      Domin
 *  @param description Description
 *
 *  @return NSError
 */
+(instancetype)errorWithDomain:(NSString *)domain description:(NSString *)description;

/**
 *  Convenience constructor for NSErrors
 *
 *  @param domain      Domin
 *  @param description Description
 *  @param data        Data
 *
 *  @return NSError
 */
+(instancetype)errorWithDomain:(NSString *)domain description:(NSString *)description data:(NSDictionary *)data;

/**
 *  Convenience constructor for NSErrors
 *
 *  @param domain      Domin
 *  @param description Description
 *  @param error       Underlying NSError
 *
 *  @return NSError
 */
+(instancetype)errorWithDomain:(NSString *)domain description:(NSString *)description underlyingError:(NSError *)error;

/**
 *  Convenience constructor for NSErrors
 *
 *  @param domain      Domin
 *  @param description Description
 *  @param error       Underlying NSError
 *  @param data        Data
 *
 *  @return NSError
 */
+(instancetype)errorWithDomain:(NSString *)domain description:(NSString *)description underlyingError:(NSError *)error data:(NSDictionary *)data;
@end
