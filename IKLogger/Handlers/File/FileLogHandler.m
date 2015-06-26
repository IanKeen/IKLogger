#import "FileLogHandler.h"
#import "LogFileManager.h"

@interface FileLogHandler ()
@property (nonatomic, strong) LogFileManager *manager;
@end

@implementation FileLogHandler
#pragma mark - Lifecycle
-(instancetype)initWithLogFileManager:(LogFileManager *)manager {
    if (!(self = [super init])) { return nil; }
    self.manager = manager;
    return self;
}

#pragma mark - Delegate Methods
-(void)logUpdated:(IKLog *)log entry:(IKLogEntry *)entry {
    NSString *fullPath = [self fullPathForLog:log];
    [self writeEntry:entry fullPath:fullPath];
    [self.manager updatedLogAt:fullPath];
}

#pragma mark - Private - Manager Binding
-(void)bindToManager {
    self.manager.didError = ^(NSError *error) {
        
    };
    
    __weak typeof(self) weakSelf = self;
    self.manager.didArchive = ^(NSString *fullPath) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf.didArchive) { strongSelf.didArchive(fullPath); }
    };
}

#pragma mark - Private
-(NSString *)fullPathForLog:(IKLog *)log {
    return [self.manager fullPathForLogDated:log.timestamp];
}
-(void)writeEntry:(IKLogEntry *)entry fullPath:(NSString *)fullPath {
    NSData *data = [[entry description] dataUsingEncoding:NSUTF8StringEncoding];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:fullPath]) {
        NSFileHandle *handle = [NSFileHandle fileHandleForWritingAtPath:fullPath];
        [handle seekToEndOfFile];
        [handle writeData:data];
        [handle closeFile];
        
    } else {
        [data writeToFile:fullPath atomically:YES];
    }
}

@end
