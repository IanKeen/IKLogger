//
//  NSDate+Building
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Building)
/**
 *  Constructs an NSDate
 *
 *  @param year     Year
 *  @param month    Month
 *  @param day      Day
 *  @param hour     Hour (24 Hour)
 *  @param minute   Minute
 *  @param second   Second
 *  @param timeZone NSTimeZone
 *
 *  @return An NSDate with the specified unit values
 */
+(NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second inTimezone:(NSTimeZone *)timeZone;

/**
 *  Constructs an NSDate
 *
 *  @param year     Year
 *  @param month    Month
 *  @param day      Day
 *  @param hour     Hour (24 Hour)
 *  @param minute   Minute
 *  @param second   Second
 *
 *  @return An NSDate with the specified unit values
 */
+(NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;

/**
 *  Constructs an NSDate
 *
 *  @param year     Year
 *  @param month    Month
 *  @param day      Day
 *  @param timeZone NSTimeZone
 *
 *  @return An NSDate with the specified unit values
 */
+(NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day inTimezone:(NSTimeZone *)timeZone;

/**
 *  Constructs an NSDate
 *
 *  @param year     Year
 *  @param month    Month
 *  @param day      Day
 *
 *  @return An NSDate with the specified unit values
 */
+(NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
@end
