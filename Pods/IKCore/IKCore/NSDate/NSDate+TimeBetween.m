//
//  NSDate+TimeBetween
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import "NSDate+TimeBetween.h"

#define TIMESTRING(property, string) \
    if (comp.property > 0) { \
        BOOL first = ([when length] == 0); \
        [when appendFormat:@"%i%s ", (int)comp.property, #string]; \
        if (!first) { break; } \
    }

@implementation NSDate (TimeBetween)
-(NSString *)timeBetween:(NSDate *)reference {
    NSDate *earliest = [self earlierDate:reference];
    NSDate *latest = [self laterDate:reference];
    
    NSTimeInterval seconds = [latest timeIntervalSinceDate:earliest];
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekOfYear | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:earliest toDate:latest options:0];
    
    NSMutableString *when = [NSMutableString string];
    if (seconds > 0) {
        while (YES) {
            TIMESTRING(year, y)
            TIMESTRING(month, mo)
            TIMESTRING(weekOfYear, wk)
            TIMESTRING(day, d)
            TIMESTRING(hour, h)
            TIMESTRING(minute, min)
            TIMESTRING(second, s)
            break;
        }
    } else { [when appendString:@"0s "]; }
    return [when substringToIndex:when.length - 1];
}
@end
