//
//  NSJSONSerialization+String
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import "NSJSONSerialization+String.h"
#import "NSObject+Null.h"

@implementation NSJSONSerialization (String)
+(NSString *)stringWithJSONObject:(id)obj options:(NSJSONWritingOptions)opt error:(NSError *__autoreleasing *)error {
    if (obj == nil) { return nil; }
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:obj options:opt error:error];
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return string;
}
@end
