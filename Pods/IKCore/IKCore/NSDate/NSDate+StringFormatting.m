//
//  NSDate+StringFormatting
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import "NSDate+StringFormatting.h"

@implementation NSDate (StringFormatting)
+(NSDateFormatter *)formatter {
    static dispatch_once_t onceToken;
    static NSDateFormatter *formatter = nil;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
    });
    return formatter;
}
+(void)resetFormatter {
    self.formatter.timeZone = nil;
    self.formatter.dateStyle = NSDateFormatterNoStyle;
    self.formatter.timeStyle = NSDateFormatterNoStyle;
    self.formatter.dateFormat = nil;
}

-(NSString *)toStringWithTimeStyle:(NSDateFormatterStyle)style {
    [[self class] resetFormatter];
    [self class].formatter.timeStyle = style;
    return [[self class].formatter stringFromDate:self];
}
-(NSString *)toStringWithTimeStyle:(NSDateFormatterStyle)style timezone:(NSTimeZone *)timezone {
    [[self class] resetFormatter];
    [self class].formatter.timeZone = timezone;
    [self class].formatter.timeStyle = style;
    return [[self class].formatter stringFromDate:self];
}

-(NSString *)toStringWithDateStyle:(NSDateFormatterStyle)style {
    [[self class] resetFormatter];
    [self class].formatter.dateStyle = style;
    return [[self class].formatter stringFromDate:self];
}
-(NSString *)toStringWithDateStyle:(NSDateFormatterStyle)style timezone:(NSTimeZone *)timezone {
    [[self class] resetFormatter];
    [self class].formatter.timeZone = timezone;
    [self class].formatter.dateStyle = style;
    return [[self class].formatter stringFromDate:self];
}

-(NSString *)toStringWithFormat:(NSString *)format {
    [[self class] resetFormatter];
    [self class].formatter.dateFormat = format;
    return [[self class].formatter stringFromDate:self];
}
-(NSString *)toStringWithFormat:(NSString *)format timezone:(NSTimeZone *)timezone {
    [[self class] resetFormatter];
    [self class].formatter.timeZone = timezone;
    [self class].formatter.dateFormat = format;
    return [[self class].formatter stringFromDate:self];
}
@end
