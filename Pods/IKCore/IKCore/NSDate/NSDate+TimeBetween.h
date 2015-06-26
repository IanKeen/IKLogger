//
//  NSDate+TimeBetween
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (TimeBetween)
/**
 *  Returns a relative time string representing the time between two dates
 *  The order of the dates is not important.
 *
 *  The string will contain (where possible) the 2 highest units available, i.e.:
 *  1y 2mo
 *  3wk 16d
 *  0s
 *
 *  @param reference The other date
 *
 *  @return A relative string representation of the duration between the dates
 */
-(NSString *)timeBetween:(NSDate *)reference;
@end
