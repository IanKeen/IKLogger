#import "LogFileManager.h"

@interface LogFileManager ()
@property (nonatomic, strong) FileSizeWatcher *watcher;
@property (nonatomic, strong) FileArchiver *archiver;
@end

@implementation LogFileManager
#pragma mark - Lifecycle
-(instancetype)initWithArchiver:(FileArchiver *)archiver watcher:(FileSizeWatcher *)watcher {
    if (!(self = [super init])) { return nil; }
    self.watcher = watcher;
    self.archiver = archiver;
    
    [self bindToArchiver];
    [self bindToWatcher];
    return self;
}

#pragma mark - Public
-(void)updatedLogAt:(NSString *)fullPath {
    if ([self.watcher isLogTooLarge:fullPath]) {
        [self.archiver rotateLogs];
    }
}
-(NSString *)fullPathForLogDated:(NSDate *)date {
    return [self.archiver fullPathForLogDated:date];
}

#pragma mark - Private - Events
-(void)didError:(NSError *)error {
    if (self.didError) { self.didError(error); }
}
-(void)didArchive:(NSString *)fullPath {
    if (self.didArchive) { self.didArchive(fullPath); }
}

#pragma mark - Private - Bindings
-(void)bindToArchiver {
    __weak typeof(self) weakSelf = self;
    self.archiver.didError = ^(NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf didError:error];
    };
    self.archiver.didArchive = ^(NSString *fullPath) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf didArchive:fullPath];
    };
}
-(void)bindToWatcher {
    __weak typeof(self) weakSelf = self;
    self.watcher.didError = ^(NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf didError:error];
    };
}
@end
