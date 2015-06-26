//
//  NSNumber+Times
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import "NSNumber+Times.h"

@implementation NSNumber (Times)
-(void)times:(timesBlock)block {
    for (NSInteger index = 0; index < [self integerValue]; index++) {
        block(index);
    }
}
@end
