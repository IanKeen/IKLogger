//
//  NSError+Init
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import "NSError+Init.h"
#import "NSObject+Null.h"

NSString * const MSErrorData = @"MSErrorData";

@implementation NSError (Shortcut)
+(instancetype)errorWithDomain:(NSString *)domain description:(NSString *)description {
    return [NSError errorWithDomain:domain description:description underlyingError:nil data:nil];
}
+(instancetype)errorWithDomain:(NSString *)domain description:(NSString *)description data:(NSDictionary *)data {
    return [NSError errorWithDomain:domain description:description underlyingError:nil data:data];
}
+(instancetype)errorWithDomain:(NSString *)domain description:(NSString *)description underlyingError:(NSError *)error {
    return [NSError errorWithDomain:domain description:description underlyingError:error data:nil];
}
+(instancetype)errorWithDomain:(NSString *)domain description:(NSString *)description underlyingError:(NSError *)error data:(NSDictionary *)data {
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithObject:description forKey:NSLocalizedDescriptionKey];
    
    if (!nilOrEmpty(data)) { userInfo[MSErrorData] = data; }
    
    if (!nilOrEmpty(error)) { userInfo[NSUnderlyingErrorKey] = error; }
    
    NSError *instance = [NSError errorWithDomain:domain code:0 userInfo:userInfo];
    return instance;
}
@end
