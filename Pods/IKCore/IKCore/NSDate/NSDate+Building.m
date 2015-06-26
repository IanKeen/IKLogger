//
//  NSDate+Building
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import "NSDate+Building.h"

@implementation NSDate (Building)
+(NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second inTimezone:(NSTimeZone *)timeZone {
    NSDateComponents * components = [NSDateComponents new];
    components.year = year;
    components.month = month;
    components.day = day;
    components.hour = hour;
    components.minute = minute;
    components.second = second;
    components.timeZone = timeZone;
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

+(NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second {
    return [self dateWithYear:year month:month day:day hour:hour minute:minute second:second inTimezone:nil];
}
+(NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day inTimezone:(NSTimeZone *)timeZone {
    return [self dateWithYear:year month:month day:day hour:0 minute:0 second:0 inTimezone:nil];
}
+(NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    return [self dateWithYear:year month:month day:day inTimezone:[NSTimeZone defaultTimeZone]];
}
@end
