//
//  NSObject+Introspection
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import "NSObject+Introspection.h"
#import <objc/runtime.h>
#import "NSArray+Filter.h"

@implementation NSObject (Introspection)
+(BOOL)property:(NSString *)name decoratedWith:(Protocol *)protocol {
    return [[self propertiesDecoratedWith:protocol] containsObject:name];
}
+(NSArray *)propertiesDecoratedWith:(Protocol *)protocol {
    NSMutableArray *results = [NSMutableArray new];
    
    unsigned int propertyCount;
    objc_property_t *properties = class_copyPropertyList([self class], &propertyCount);
    
    for (unsigned int index = 0; index < propertyCount; index++) {
        objc_property_t property = properties[index];
        
        const char *attrs = property_getAttributes(property);
        NSString *propertyAttributes = @(attrs);
        NSArray *attributeItems = [propertyAttributes componentsSeparatedByString:@","];
        
        BOOL conforms = ([attributeItems filter:^BOOL(NSString *item) {
            return ([item rangeOfString:[NSString stringWithFormat:@"<%@>", NSStringFromProtocol(protocol)]].location != NSNotFound);
        }].count > 0);
        
        if (conforms) {
            const char *propertyName = property_getName(property);
            [results addObject:@(propertyName)];
        }
    }
    
    return results;
}
@end
