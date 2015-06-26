#import "Reachability.h"
#import <arpa/inet.h>
#import <netinet/in.h>

#ifdef IKEVENTS
#import <IKEvents/IKEvent.h>
#endif

@import SystemConfiguration;

NSString * ReachabilityChangedNotification = @"ReachabilityChangedNotification";

@interface Reachability ()
@property (nonatomic, assign) SCNetworkReachabilityRef reachabilityRef;

@property (nonatomic, strong) Reachability *reachabilityObject;
@property (nonatomic, assign) SCNetworkReachabilityFlags previousReachabilityFlags;
@property (nonatomic, strong) dispatch_source_t dispatch_timer;
@property (nonatomic, strong) dispatch_queue_t timer_queue;

@end

@implementation Reachability
#pragma mark - Lifecycle
-(instancetype)initWithHostname:(NSString *)hostname {
    SCNetworkReachabilityRef ref = SCNetworkReachabilityCreateWithName(kCFAllocatorDefault, hostname.UTF8String);
    return [self initWithReachabilityRef:ref];
}
-(instancetype)initWithReachabilityRef:(SCNetworkReachabilityRef)reachabilityRef {
    if (!(self = [super init])) { return nil; }
    
    #ifdef IKEVENTS
    _didBecomeReachable = [IKEvent new];
    _didBecomeUnreachable = [IKEvent new];
    #endif
    
    self.reachabilityRef = reachabilityRef;
    self.timer_queue = dispatch_queue_create("uk.co.joylordsystems.reachability_timer_queue", nil);
    return self;
}
+(instancetype)reachabilityForInternetConnection {
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef ref = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (struct sockaddr *)&zeroAddress);
    return [[Reachability alloc] initWithReachabilityRef:ref];
}
+(instancetype)reachabilityForLocalWiFi {
    struct sockaddr_in localWifiAddress;
    bzero(&localWifiAddress, sizeof(localWifiAddress));
    localWifiAddress.sin_len = sizeof(localWifiAddress);
    localWifiAddress.sin_family = AF_INET;
    
    // IN_LINKLOCALNETNUM is defined in <netinet/in.h> as 169.254.0.0
    localWifiAddress.sin_addr.s_addr = htonl(IN_LINKLOCALNETNUM);
    
    SCNetworkReachabilityRef ref = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (struct sockaddr *)&localWifiAddress);
    return [[Reachability alloc] initWithReachabilityRef:ref];
}
-(void)dealloc {
    [self stopNotifier];
    
    self.reachabilityRef = nil;
    self.whenReachable = nil;
    self.whenUnreachable = nil;
}

#pragma mark - Timer
-(BOOL)startNotifier {
    self.reachabilityObject = self;
    [self timerFired]; //send out an initial event
    
    self.previousReachabilityFlags = [self reachabilityFlags];
    self.dispatch_timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, self.timer_queue);
    if (self.dispatch_timer == nil) { return NO; }
    
    dispatch_source_set_timer(self.dispatch_timer, dispatch_walltime(nil, 0), 500 * NSEC_PER_MSEC, 100 * NSEC_PER_MSEC);
    dispatch_source_set_event_handler(self.dispatch_timer, ^{
        [self timerFired];
    });
    dispatch_resume(self.dispatch_timer);
    return YES;
}
-(void)stopNotifier {
    self.reachabilityObject = nil;
    if (self.dispatch_timer) {
        dispatch_source_cancel(self.dispatch_timer);
        self.dispatch_timer = nil;
    }
}
-(void)timerFired {
    SCNetworkReachabilityFlags currentReachabilityFlags = [self reachabilityFlags];
    if (currentReachabilityFlags != self.previousReachabilityFlags) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self reachabilityChanged:currentReachabilityFlags];
            self.previousReachabilityFlags = currentReachabilityFlags;
        });
    }
}

#pragma mark - Public Properties
-(NetworkStatus)currentReachabilityStatus {
    if ([self isReachable]) {
        if ([self isReachableViaWiFi]) {
            return NetworkStatusReachableViaWiFi;
        }
        if ([self isRunningOnDevice]) {
            return NetworkStatusReachableViaWWAN;
        }
    }
    
    return NetworkStatusNotReachable;
}
-(NSString *)currentReachabilityString {
    return [self stringFromNetworkStatus:[self currentReachabilityStatus]];
}
-(BOOL)isReachable {
    return [self isReachableWithTest:^BOOL(SCNetworkReachabilityFlags flags) {
        return [self isReachableWithFlags:flags];
    }];
}
-(BOOL)isReachableViaWWAN {
    return [self isReachableWithTest:^BOOL(SCNetworkReachabilityFlags flags) {
        // Check we're REACHABLE
        if ([self isReachable:flags]) {
            // Now, check we're on WWAN
            if ([self isOnWWAN:flags]) {
                return YES;
            }
        }
        return NO;
    }];
    return NO;
}
-(BOOL)isReachableViaWiFi {
    return [self isReachableWithTest:^BOOL(SCNetworkReachabilityFlags flags) {
        // Check we're REACHABLE
        if ([self isReachable:flags]) {
            // Now, check we're NOT on WWAN
            if ([self isOnWWAN:flags]) {
                return NO;
            }
        }
        return YES;
    }];
    return NO;
}

#pragma mark - Private
-(NSString *)stringFromNetworkStatus:(NetworkStatus)status {
    NSDictionary *mapping =
      @{@(NetworkStatusNotReachable): @"No Connection",
      @(NetworkStatusReachableViaWiFi): @"WiFi",
      @(NetworkStatusReachableViaWWAN): @"Cellular"};
    
    return mapping[@(status)];
}
-(SCNetworkReachabilityFlags)reachabilityFlags {
    SCNetworkReachabilityFlags flags = 0;
    if (SCNetworkReachabilityGetFlags(self.reachabilityRef, &flags) != 0) {
        return flags;
    }
    return 0;
}

-(void)reachabilityChanged:(SCNetworkReachabilityFlags)flags {
    if ([self isReachableWithFlags:flags]) {
        #ifdef IKEVENTS
        notify(self.didBecomeReachable);
        #endif
        if (self.whenReachable) { self.whenReachable(self); }

    } else {
        #ifdef IKEVENTS
        notify(self.didBecomeUnreachable);
        #endif
        if (self.whenUnreachable) { self.whenUnreachable(self); }
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ReachabilityChangedNotification object:self];
}
-(BOOL)isReachableWithFlags:(SCNetworkReachabilityFlags)flags {
    if (![self isReachable:flags]) {
        return NO;
    }
    
    if ([self isConnectionRequiredOrTransient:flags]) {
        return NO;
    }
    
    if ([self isRunningOnDevice]) {
        if ([self isOnWWAN:flags] && ![self reachableOnWWAN]) {
            // We don't want to connect when on 3G.
            return NO;
        }
    }
    
    return YES;
}
-(BOOL)isReachableWithTest:(BOOL(^)(SCNetworkReachabilityFlags flags))test {
    SCNetworkReachabilityFlags flags = 0;
    if (SCNetworkReachabilityGetFlags(self.reachabilityRef, &flags) != 0) {
        return test(flags);
    }
    return NO;
}

#pragma mark - Private State
-(BOOL)isOnWWAN:(SCNetworkReachabilityFlags)flags {
    return (flags & kSCNetworkReachabilityFlagsIsWWAN) != 0;
}
-(BOOL)isReachable:(SCNetworkReachabilityFlags)flags {
    return (flags & kSCNetworkReachabilityFlagsReachable) != 0;
}
-(BOOL)isConnectionRequired:(SCNetworkReachabilityFlags)flags {
    return (flags & kSCNetworkReachabilityFlagsConnectionRequired) != 0;
}
-(BOOL)isInterventionRequired:(SCNetworkReachabilityFlags)flags {
    return (flags & kSCNetworkReachabilityFlagsInterventionRequired) != 0;
}
-(BOOL)isConnectionOnTraffic:(SCNetworkReachabilityFlags)flags {
    return (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0;
}
-(BOOL)isConnectionOnDemand:(SCNetworkReachabilityFlags)flags {
    return (flags & kSCNetworkReachabilityFlagsConnectionOnDemand) != 0;
}
-(BOOL)isConnectionOnTrafficOrDemand:(SCNetworkReachabilityFlags)flags {
    return (flags & (kSCNetworkReachabilityFlagsConnectionOnTraffic | kSCNetworkReachabilityFlagsConnectionOnDemand)) != 0;
}
-(BOOL)isTransientConnection:(SCNetworkReachabilityFlags)flags {
    return (flags & kSCNetworkReachabilityFlagsTransientConnection) != 0;
}
-(BOOL)isLocalAddress:(SCNetworkReachabilityFlags)flags {
    return (flags & kSCNetworkReachabilityFlagsIsLocalAddress) != 0;
}
-(BOOL)isDirect:(SCNetworkReachabilityFlags)flags {
    return (flags & kSCNetworkReachabilityFlagsIsDirect) != 0;
}
-(BOOL)isConnectionRequiredOrTransient:(SCNetworkReachabilityFlags)flags {
    SCNetworkReachabilityFlags testcase = (kSCNetworkReachabilityFlagsConnectionRequired | kSCNetworkReachabilityFlagsTransientConnection);
    return (flags & testcase) == testcase;
}
-(BOOL)isRunningOnDevice {
#if TARGET_IPHONE_SIMULATOR
    return NO;
#else
    return YES;
#endif
}

// WWAN may be available, but not active until a connection has been established.
// WiFi may require a connection for VPN on Demand.
-(BOOL)isConnectionRequired {
    return [self connectionRequired];
}
-(BOOL)connectionRequired {
    return [self isReachableWithTest:^BOOL(SCNetworkReachabilityFlags flags) {
        return [self isConnectionRequired:flags];
    }];
}

// Dynamic, on demand connection?
-(BOOL)isConnectionOnDemand {
    return [self isReachableWithTest:^BOOL(SCNetworkReachabilityFlags flags) {
        return [self isConnectionRequired:flags] && [self isConnectionOnTrafficOrDemand:flags];
    }];
}

// Is user intervention required?
-(BOOL)isInterventionRequired {
    return [self isReachableWithTest:^BOOL(SCNetworkReachabilityFlags flags) {
        return [self isConnectionRequired:flags] && [self isInterventionRequired:flags];
    }];
}


-(NSString *)description {
    NSString *W = @"X";
    if ([self isRunningOnDevice]) {
        W = ([self isOnWWAN:[self reachabilityFlags]] ? @"W" : @"-");
    }
    NSString * R = ([self isReachable:[self reachabilityFlags]] ? @"R" : @"-");
    NSString * c = ([self isConnectionRequired:[self reachabilityFlags]] ? @"c" : @"-");
    NSString * t = ([self isTransientConnection:[self reachabilityFlags]] ? @"t" : @"-");
    NSString * i = ([self isInterventionRequired:[self reachabilityFlags]] ? @"i" : @"-");
    NSString * C = ([self isConnectionOnTraffic:[self reachabilityFlags]] ? @"C" : @"-");
    NSString * D = ([self isConnectionOnDemand:[self reachabilityFlags]] ? @"D" : @"-");
    NSString * l = ([self isLocalAddress:[self reachabilityFlags]] ? @"l" : @"-");
    NSString * d = ([self isDirect:[self reachabilityFlags]] ? @"d" : @"-");
    
    return [NSString stringWithFormat:@"%@%@ %@%@%@%@%@%@%@", W, R, c, t, i, C ,D ,l , d];
}
@end
