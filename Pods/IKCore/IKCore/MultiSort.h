//
//  MultiSort
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Defines.h"

/**
 *  Allows for sorting on multiple elements and returning the result of the first that is not NSSortedSame
 *  Items should be added from left to right in order of priority
 */
OVERLOADABLE NSComparisonResult sort(NSComparisonResult first, NSComparisonResult second, NSComparisonResult third, NSComparisonResult forth);

/**
 *  Allows for sorting on multiple elements and returning the result of the first that is not NSSortedSame
 *  Items should be added from left to right in order of priority
 */
OVERLOADABLE NSComparisonResult sort(NSComparisonResult first, NSComparisonResult second, NSComparisonResult third);

/**
 *  Allows for sorting on multiple elements and returning the result of the first that is not NSSortedSame
 *  Items should be added from left to right in order of priority
 */
OVERLOADABLE NSComparisonResult sort(NSComparisonResult first, NSComparisonResult second);
