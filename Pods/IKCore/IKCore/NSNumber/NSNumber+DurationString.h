//
//  NSNumber+DurationString
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (DurationString)
/**
 *  Treats the number as seconds and returns a relative time string representation
 *  The absolute version of the number is used
 *
 *  The string will contain (where possible) the 2 highest units available, i.e.:
 *  1y 2mo
 *  3wk 16d
 *  0s
 *
 *  @return NSString
 */
-(NSString *)duration;
@end
