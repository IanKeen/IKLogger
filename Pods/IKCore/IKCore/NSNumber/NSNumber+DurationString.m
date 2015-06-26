//
//  NSNumber+DurationString
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import "NSNumber+DurationString.h"
#import "NSDate+TimeBetween.h"

@implementation NSNumber (DurationString)
-(NSString *)duration {
    NSTimeInterval absoluteValue = fabs([self doubleValue]);
    NSDate *now = [NSDate date];
    /*
     Interesting note: using '-absoluteValue' rather than 'absoluteValue' provides more accurate output 
     */
    NSDate *temporaryDate = [now dateByAddingTimeInterval:-absoluteValue];
    return [now timeBetween:temporaryDate];
}
@end
