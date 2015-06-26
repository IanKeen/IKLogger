//
//  NSDate+Shortcuts
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import "NSDate+Shortcuts.h"

@implementation NSDate (Shortcuts)
+(NSCalendar *)calendar:(NSTimeZone *)timeZone {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [calendar setTimeZone:timeZone];
    return calendar;
}

-(NSDate *)startOfDay {
    return [self startOfDay:[NSTimeZone defaultTimeZone]];
}
-(NSDate *)startOfDay:(NSTimeZone *)timeZone {
    NSCalendar *calendar = [[self class] calendar:timeZone];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:self];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [calendar dateFromComponents:components];
}

-(NSDate *)endOfDay {
    return [self endOfDay:[NSTimeZone defaultTimeZone]];
}
-(NSDate *)endOfDay:(NSTimeZone *)timeZone {
    NSCalendar *calendar = [[self class] calendar:timeZone];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:self];
    components.hour = 23;
    components.minute = 59;
    components.second = 59;
    return [calendar dateFromComponents:components];
}

-(NSDate *)startOfWeek {
    return [self startOfWeek:[NSTimeZone defaultTimeZone]];
}
-(NSDate *)startOfWeek:(NSTimeZone *)timeZone {
    NSCalendar *calendar = [[self class] calendar:timeZone];
    NSDate *startOfTheWeek;
    NSTimeInterval interval;
    [calendar rangeOfUnit:NSCalendarUnitWeekOfYear startDate:&startOfTheWeek interval:&interval forDate:self];
    //startOfWeek holds now the first day of the week, according to locale (monday vs. sunday)
    return startOfTheWeek;
}

-(NSDate *)endOfWeek {
    return [self endOfWeek:[NSTimeZone defaultTimeZone]];
}
-(NSDate *)endOfWeek:(NSTimeZone *)timeZone {
    NSCalendar *calendar = [[self class] calendar:timeZone];
    NSDate *startOfTheWeek;
    NSDate *endOfWeek;
    NSTimeInterval interval;
    [calendar rangeOfUnit:NSCalendarUnitWeekOfYear startDate:&startOfTheWeek interval:&interval forDate:self];
    //startOfWeek holds now the first day of the week, according to locale (monday vs. sunday)
    endOfWeek = [startOfTheWeek dateByAddingTimeInterval:interval-1];
    // holds 23:59:59 of last day in week.
    return endOfWeek;
}

-(NSDate *)startOfMonth {
    return [self startOfMonth:[NSTimeZone defaultTimeZone]];
}
-(NSDate *)startOfMonth:(NSTimeZone *)timeZone {
    NSCalendar *calendar = [[self class] calendar:timeZone];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    components.day = 1;
    return [calendar dateFromComponents:components];
}

-(NSDate *)endOfMonth {
    return [self endOfMonth:[NSTimeZone defaultTimeZone]];
}
-(NSDate *)endOfMonth:(NSTimeZone *)timeZone {
    NSCalendar *calendar = [[self class] calendar:timeZone];
    NSRange monthRange = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    components.day = monthRange.length;
    return [calendar dateFromComponents:components];
}

-(BOOL)sameDay:(NSDate *)date {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:self];
    NSDateComponents *otherComponents = [[NSCalendar currentCalendar] components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:date];
    
    return (([components year] == [otherComponents year]) && ([components month] == [otherComponents month]) && ([components day] == [otherComponents day]));
}
-(BOOL)sameMonth:(NSDate *)date {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:self];
    NSDateComponents *otherComponents = [[NSCalendar currentCalendar] components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:date];
    
    return (([components year] == [otherComponents year]) && ([components month] == [otherComponents month]));
}
-(BOOL)sameYear:(NSDate *)date {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:self];
    NSDateComponents *otherComponents = [[NSCalendar currentCalendar] components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:date];
    
    return ([components year] == [otherComponents year]);
}

-(NSDate *)dateByAddingDays:(NSInteger)days {
    NSDateComponents *components = [NSDateComponents new];
    components.day = days;
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}
-(NSDate *)dateByAddingWeeks:(NSInteger)weeks {
    NSDateComponents *components = [NSDateComponents new];
    components.weekOfYear = weeks;
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}
-(NSDate *)dateByAddingMonths:(NSInteger)months {
    NSDateComponents *newComp = [NSDateComponents new];
    newComp.month = months;
    NSDate *result = [[NSCalendar currentCalendar] dateByAddingComponents:newComp toDate:self options:0];
    return result;
}
-(NSDate *)dateByAddingYears:(NSInteger)years {
    NSDateComponents *newComp = [NSDateComponents new];
    newComp.year = years;
    NSDate *result = [[NSCalendar currentCalendar] dateByAddingComponents:newComp toDate:self options:0];
    return result;
}

-(NSDate *)dateByTakingTimeFrom:(NSDate *)date {
    NSDateComponents *timeComponents = [[NSCalendar currentCalendar] components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:date];
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    
    NSDateComponents *components = [NSDateComponents new];
    components.year = dateComponents.year;
    components.month = dateComponents.month;
    components.day = dateComponents.day;
    components.hour = timeComponents.hour;
    components.minute = timeComponents.minute;
    components.second = timeComponents.second;
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}
@end
