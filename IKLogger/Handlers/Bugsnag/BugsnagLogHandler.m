#import "BugsnagLogHandler.h"
#import <Bugsnag/Bugsnag.h>

@interface BugsnagLogHandler ()
@property (nonatomic, copy) bugsnagCommonData commonData;
@end

@implementation BugsnagLogHandler
-(instancetype)initWithCommonData:(bugsnagCommonData)commonData {
    if (!(self = [super init])) { return nil; }
    self.commonData = commonData;
    return self;
}

-(void)logUpdated:(IKLog *)log entry:(IKLogEntry *)entry {
#ifndef DEBUG
    if (entry.level == IKLogEntryLevelError) {
        [self updateCommonData];
        [Bugsnag notify:[NSException exceptionWithName:entry.prefix reason:[entry description] userInfo:nil]
               withData:entry.data];
    }
#endif
}

-(void)updateCommonData {
    if (self.commonData == nil) { return; }
    
    static NSString *tabName = @"Common Data";
    [Bugsnag clearTabWithName:tabName];
    
    NSDictionary *data = [NSDictionary dictionaryWithDictionary:self.commonData()];
    [data enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
        [Bugsnag addAttribute:key withValue:obj toTabWithName:tabName];
    }];
}
@end
