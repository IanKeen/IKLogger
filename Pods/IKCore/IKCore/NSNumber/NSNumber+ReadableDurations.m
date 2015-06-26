//
//  NSNumber+ReadableDurations
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import "NSNumber+ReadableDurations.h"

@implementation NSNumber (ReadableDurations)
-(NSTimeInterval)second { return self.seconds; }
-(NSTimeInterval)seconds { return [self doubleValue]; }

-(NSTimeInterval)minute { return self.minutes; }
-(NSTimeInterval)minutes { return self.seconds * 60; }

-(NSTimeInterval)hour { return self.hours; }
-(NSTimeInterval)hours { return self.minute * 60; }

-(NSTimeInterval)day { return self.days; }
-(NSTimeInterval)days { return self.hour * 24; }

-(NSTimeInterval)week { return self.weeks; }
-(NSTimeInterval)weeks { return self.days * 7; }
@end
