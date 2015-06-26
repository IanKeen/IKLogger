//
//  NSArray+Group
//
//  Created by Ian Keen on 12/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id(^groupFunction)(id item);

@interface NSArray (Group)
-(NSDictionary *)groupBy:(groupFunction)function;
@end
