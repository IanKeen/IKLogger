#import <Foundation/Foundation.h>

/*
 Copyright (c) 2014, Ashley Mills
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 1. Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 2. Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
 LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 */


/*
 
 
 IKEEN:
 Ported from Swift to Obj-C; added events
 
 
 */

#ifdef IKEVENTS
@class IKEvent;
#endif

extern NSString * ReachabilityChangedNotification;

@class Reachability;
typedef void(^NetworkReachable)(Reachability *reachability);
typedef void(^NetworkUneachable)(Reachability *reachability);

typedef NS_ENUM(NSUInteger, NetworkStatus) {
    NetworkStatusNotReachable,
    NetworkStatusReachableViaWiFi,
    NetworkStatusReachableViaWWAN,
};

@interface Reachability : NSObject
+(instancetype)reachabilityForInternetConnection;
+(instancetype)reachabilityForLocalWiFi;
-(instancetype)initWithHostname:(NSString *)hostname;

-(BOOL)startNotifier;
-(void)stopNotifier;

-(NetworkStatus)currentReachabilityStatus;
-(NSString *)currentReachabilityString;
-(BOOL)isReachable;
-(BOOL)isReachableViaWWAN;
-(BOOL)isReachableViaWiFi;

@property (nonatomic, copy) NetworkReachable whenReachable;
@property (nonatomic, copy) NetworkUneachable whenUnreachable;
@property (nonatomic, readonly) BOOL reachableOnWWAN;
@property (nonatomic, readonly) NetworkStatus currentReachabilityStatus;
@property (nonatomic, readonly) NSString *currentReachabilityString;

#ifdef IKEVENTS
@property (nonatomic, strong, readonly) IKEvent *didBecomeReachable;
@property (nonatomic, strong, readonly) IKEvent *didBecomeUnreachable;
#endif
@end
