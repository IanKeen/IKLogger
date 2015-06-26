//
//  NSNumber+Times
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^timesBlock)(NSInteger index);

@interface NSNumber (Times)
/**
 *  Using the receiver as the count, you can perform a block that many times
 *
 *  i.e.: To print the numbers: 1, 2, 3 simply write:
 *  [@(3) times:^(NSInteger index) {
 *      NSLog(@"%@", @(index + 1));
 *  }];
 *
 *  @param block Block of code to execute, an index is also available
 */
-(void)times:(timesBlock)block;
@end
