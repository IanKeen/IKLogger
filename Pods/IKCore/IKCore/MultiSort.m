//
//  MultiSort
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import "MultiSort.h"

OVERLOADABLE NSComparisonResult sort(NSComparisonResult first, NSComparisonResult second, NSComparisonResult third, NSComparisonResult forth) {
    return (first == NSOrderedSame ? (second == NSOrderedSame ? (third == NSOrderedSame ? forth : third) : second) : first);
}
OVERLOADABLE NSComparisonResult sort(NSComparisonResult first, NSComparisonResult second, NSComparisonResult third) {
    return (first == NSOrderedSame ? (second == NSOrderedSame ? third : second) : first);
}
OVERLOADABLE NSComparisonResult sort(NSComparisonResult first, NSComparisonResult second) {
    return (first == NSOrderedSame ? second : first);
}
