//
//  Device
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  @return Is this device an iPhone?
 */
extern BOOL isIPHONE();

/**
 *  @return Is this device an iPad?
 */
extern BOOL isIPAD();

/**
 *  Returns a value based on the current device
 *
 *  @param iPhone Value when run on an iPhone
 *  @param iPad   Value when run on an iPad
 *
 *  @return The device specific value
 */
extern NSObject * deviceValue(NSObject *iPhone, NSObject *iPad);

/**
 *  @return The platform code for the current device
 */
extern NSString * platformCode();

/**
 *  Returns a value based on the current platform (Device/Simulator)
 *
 *  @param device    Value when run on device
 *  @param simulator Value when run in simulator
 *
 *  @return The platform specific value
 */
extern NSObject * platformValue(NSObject *device, NSObject *simulator);

/**
 *  @return Is this running in simulator?
 */
extern BOOL isSimulator();
