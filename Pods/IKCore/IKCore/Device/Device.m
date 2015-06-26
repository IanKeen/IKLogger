//
//  Device
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import "Device.h"
#import <sys/types.h>
#import <sys/sysctl.h>

BOOL isIPHONE() {
    return ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone);
}
BOOL isIPAD() {
    return ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad);
}

NSObject * deviceValue(NSObject *iPhone, NSObject *iPad) {
    return (isIPAD() ? iPad : iPhone);
}

NSString * platformCode() {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:[NSString defaultCStringEncoding]];
    free(machine);
    return platform;
}

NSObject * platformValue(NSObject *device, NSObject *simulator) {
#if TARGET_IPHONE_SIMULATOR
    return simulator;
#else
    return device;
#endif
}

BOOL isSimulator() {
#if TARGET_IPHONE_SIMULATOR
    return YES;
#else
    return NO;
#endif
}
