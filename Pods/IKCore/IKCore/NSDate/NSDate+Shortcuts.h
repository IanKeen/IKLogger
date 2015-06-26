//
//  NSDate+Shortcuts
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Shortcuts)
/**
 *  Creates an NSDate with its time set to the start of the day
 *
 *  @return NSDate
 */
-(NSDate *)startOfDay;

/**
 *  Creates an NSDate with its time set to the start of the day in the parsed NSTimeZone
 *
 *  @param timeZone The timezone to use for the start of the day
 *
 *  @return NSDate
 */
-(NSDate *)startOfDay:(NSTimeZone *)timeZone;

/**
 *  Creates an NSDate with its time set to the end of the day
 *
 *  @return NSDate
 */
-(NSDate *)endOfDay;

/**
 *  Creates an NSDate with its time set to the end of the day in the parsed NSTimeZone
 *
 *  @param timeZone The timezone to use for the end of the day
 *
 *  @return NSDate
 */
-(NSDate *)endOfDay:(NSTimeZone *)timeZone;

/**
 *  Creates an NSDate with its time set to the start of the week
 *
 *  @return NSDate
 */
-(NSDate *)startOfWeek;

/**
 *  Creates an NSDate with its time set to the start of the week in the parsed NSTimeZone
 *
 *  @param timeZone The timezone to use for the end of the week
 *
 *  @return NSDate
 */
-(NSDate *)startOfWeek:(NSTimeZone *)timeZone;

/**
 *  Creates an NSDate with its time set to the end of the week
 *
 *  @return NSDate
 */
-(NSDate *)endOfWeek;

/**
 *  Creates an NSDate with its time set to the end of the week in the parsed NSTimeZone
 *
 *  @param timeZone The timezone to use for the end of the week
 *
 *  @return NSDate
 */
-(NSDate *)endOfWeek:(NSTimeZone *)timeZone;

/**
 *  Creates an NSDate with its time set to the start of the month
 *
 *  @return NSDate
 */
-(NSDate *)startOfMonth;

/**
 *  Creates an NSDate with its time set to the start of the month in the parsed NSTimeZone
 *
 *  @param timeZone The timezone to use for the start of the month
 *
 *  @return NSDate
 */
-(NSDate *)startOfMonth:(NSTimeZone *)timeZone;

/**
 *  Creates an NSDate with its time set to the end of the month
 *
 *  @return NSDate
 */
-(NSDate *)endOfMonth;

/**
 *  Creates an NSDate with its time set to the end of the month in the parsed NSTimeZone
 *
 *  @param timeZone The timezone to use for the end of the month
 *
 *  @return NSDate
 */
-(NSDate *)endOfMonth:(NSTimeZone *)timeZone;

/**
 *  Check if this date and the parsed date are part of the same day
 *
 *  @param date The NSDate to compare with
 *
 *  @return NSDate
 */
-(BOOL)sameDay:(NSDate *)date;

/**
 *  Check if this date and the parsed date are part of the same month
 *
 *  @param date The NSDate to compare with
 *
 *  @return NSDate
 */
-(BOOL)sameMonth:(NSDate *)date;

/**
 *  Check if this date and the parsed date are part of the same year
 *
 *  @param date The NSDate to compare with
 *
 *  @return NSDate
 */
-(BOOL)sameYear:(NSDate *)date;

/**
 *  Adds days to this NSDate (can be negative)
 *
 *  @param days Number of days to add / subtract
 *
 *  @return NSDate
 */
-(NSDate *)dateByAddingDays:(NSInteger)days;

/**
 *  Adds weeks to this NSDate (can be negative)
 *
 *  @param weeks Number of weeks to add / subtract
 *
 *  @return NSDate
 */
-(NSDate *)dateByAddingWeeks:(NSInteger)weeks;

/**
 *  Adds months to this NSDate (can be negative)
 *
 *  @param months Number of months to add / subtract
 *
 *  @return NSDate
 */
-(NSDate *)dateByAddingMonths:(NSInteger)months;

/**
 *  Adds years to this NSDate (can be negative)
 *
 *  @param years Number of months to add / subtract
 *
 *  @return NSDate
 */
-(NSDate *)dateByAddingYears:(NSInteger)years;

/**
 *  Returns a new NSDate that has the year/month/day unit values from this instance
 *  and the hour/minute/second unit values from the provided instance
 *
 *  @param date NSDate to take the time units from
 *
 *  @return NSDate
 */
-(NSDate *)dateByTakingTimeFrom:(NSDate *)date;
@end
