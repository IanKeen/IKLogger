//
//  NSDate+StringFormatting
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (StringFormatting)

-(NSString *)toStringWithTimeStyle:(NSDateFormatterStyle)style;

/**
 *  Returns a string representation of the current dates time in the provided style, in the provided timezone
 *
 *  @param style    NSDateFormatterStyle time style
 *  @param timezone NSTimeZone
 *
 *  @return NSString
 */
-(NSString *)toStringWithTimeStyle:(NSDateFormatterStyle)style timezone:(NSTimeZone *)timezone;

-(NSString *)toStringWithDateStyle:(NSDateFormatterStyle)style;

/**
 *  Returns a string representation of the current date in the provided style, in the provided timezone
 *
 *  @param style    NSDateFormatterStyle date style
 *  @param timezone NSTimeZone
 *
 *  @return NSString
 */
-(NSString *)toStringWithDateStyle:(NSDateFormatterStyle)style timezone:(NSTimeZone *)timezone;

-(NSString *)toStringWithFormat:(NSString *)format;

/**
 *  Returns a string representation of the current dates in a custom style, in the provided timezone
 *
 *  @param format   Custom date format
 *  @param timezone NSTimeZone
 *
 *  @return NSString
 */
-(NSString *)toStringWithFormat:(NSString *)format timezone:(NSTimeZone *)timezone;
@end
