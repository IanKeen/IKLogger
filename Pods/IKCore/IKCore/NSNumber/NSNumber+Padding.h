//
//  NSNumber+Padding
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (Padding)
/**
 *  Returns the receiver as a string of totalStringLength length, left padding the excess spaces with zeros
 *  e.g.:
 *  30 with a totalStringLength of 5 would result in: '   30'
 *  NOTE: if the receiver is longer than the totalStringLength then the receiver is returned 'as-is' as a string
 *
 *  @param totalStringLength Total length of the output string
 *
 *  @return NSString
 */
-(NSString *)paddedStringWithZeros:(NSInteger)totalStringLength;
@end
