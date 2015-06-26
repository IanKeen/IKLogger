//
//  NSObject+Map
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import "NSObject+Map.h"

@implementation NSObject (Map)
-(NSObject *(^)(id, SEL))mapSelector {
    __weak typeof(self) weakSelf = self;
    return ^NSObject *(id object, SEL selector) {
        if ([object respondsToSelector:selector]) {
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            id functionResult = [object performSelector:selector withObject:weakSelf];
            #pragma clang diagnostic pop
            
            return functionResult;
        } else { @throw [NSException exceptionWithName:@"NSObject::Map" reason:@"Object does not respond to provided selector" userInfo:nil]; }
    };
}
-(NSObject *(^)(mapValueFunction))map {
    __weak typeof(self) weakSelf = self;
    return ^NSObject *(mapValueFunction function) {
        return function(weakSelf);
    };
}
@end