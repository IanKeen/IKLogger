#import "FileSizeWatcher.h"

static NSInteger kDefaultLogSize = 1048576;
static NSInteger kMinLogSize = (1048576 / 2);

@implementation FileSizeWatcher
#pragma mark - Lifecycle
-(instancetype)init {
    if (!(self = [super init])) { return nil; }
    self.maxLogSize = kDefaultLogSize;
    return self;
}

#pragma mark - Public
-(BOOL)isLogTooLarge:(NSString *)fullPath {
    NSError *error = nil;
    NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:fullPath error:&error];
    NSInteger fileSize = ([attributes[NSFileSize] integerValue] ?: 0);
    
    if (error && self.didError) { self.didError(error); }
    return (fileSize > self.maxLogSize);
}

#pragma mark - Properties
-(void)setMaxLogSize:(NSInteger)maxLogSize {
    _maxLogSize = MAX(kMinLogSize, maxLogSize);
}
@end
