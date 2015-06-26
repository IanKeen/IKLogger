//
//  NSNumber+Padding
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import "NSNumber+Padding.h"

@implementation NSNumber (Padding)
-(NSString *)paddedStringWithZeros:(NSInteger)totalStringLength {
    return [NSString stringWithFormat:@"%0*d", (int)totalStringLength, [self intValue]];
}
@end
