//
//  NSNumber+ReadableDurations
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Allows for durations to be written in a more readable format.
 *
 *  i.e.:
 *  Instead of (60 * 60 * 24) you can write @(1).day
 *
 */
@interface NSNumber (ReadableDurations)
@property (nonatomic, readonly) NSTimeInterval second;
@property (nonatomic, readonly) NSTimeInterval seconds;

@property (nonatomic, readonly) NSTimeInterval minute;
@property (nonatomic, readonly) NSTimeInterval minutes;

@property (nonatomic, readonly) NSTimeInterval hour;
@property (nonatomic, readonly) NSTimeInterval hours;

@property (nonatomic, readonly) NSTimeInterval day;
@property (nonatomic, readonly) NSTimeInterval days;

@property (nonatomic, readonly) NSTimeInterval week;
@property (nonatomic, readonly) NSTimeInterval weeks;
@end
