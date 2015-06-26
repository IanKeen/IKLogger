#import "IKLog.h"
#import "IKLogEntry.h"

@implementation IKLog
#pragma mark - Lifecycle
-(instancetype)initWithUpdated:(logUpdatedBlock)updated {
    if (!(self = [super init])) { return nil; }
    _timestamp = [NSDate date];
    _entries = [NSArray array];
    _updated = updated;
    return self;
}

#pragma mark - Public
-(void)addEntry:(IKLogEntry *)entry {
    _entries = [_entries arrayByAddingObject:entry];
    if (self.updated) { self.updated(self, entry); }
}
@end
