//
//  NSJSONSerialization+String
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSJSONSerialization (String)
/**
 *  Converts the provided object to JSON and returns an NSString representation
 *
 *  @param obj   The object to convert to json
 *  @param opt   The options to parse to the json serializer
 *  @param error NSError pointer
 *
 *  @return NSString
 */
+(NSString *)stringWithJSONObject:(id)obj
                        options:(NSJSONWritingOptions)opt
                          error:(NSError * __autoreleasing *)error;
@end
