#import "FileArchiver.h"
#import <IKCore/NSArray+Map.h>

static NSString *kCurrentLogs = @"CurrentLogs";
static NSString *kArchivedLogs = @"ArchivedLogs";

@implementation FileArchiver
#pragma mark - Lifecycle
-(instancetype)init {
    if (!(self = [super init])) { return nil; }
    
    self.activeLogPath = kCurrentLogs;
    self.archivedLogPath = kArchivedLogs;
    
    [self createDirectory:[self buildPath:[self homeDirectory] logType:self.archivedLogPath fileName:@""]];
    [self createDirectory:[self buildPath:[self homeDirectory] logType:self.activeLogPath fileName:@""]];
    
    return self;
}

#pragma mark - Public
-(void)rotateLogs {
    [[self obtainLogs:self.activeLogPath] enumerateObjectsUsingBlock:^(NSString *log, NSUInteger idx, BOOL *stop) {
        [self archiveLog:log];
    }];
        
//    IKLogEntry *initialEntry = [[IKLogEntry alloc] initWithLevel:IKLogEntryLevelNormal data:nil prefix:@"" text:@""];
//    [self addEntry:initialEntry];
}
-(NSArray *)archivedLogs {
    return [self obtainLogs:self.archivedLogPath];
}
-(NSString *)fullPathForLogDated:(NSDate *)date {
    static dispatch_once_t onceToken;
    static NSDateFormatter *formatter = nil;
    dispatch_once(&onceToken, ^{
        formatter = [NSDateFormatter new];
        formatter.dateFormat = @"yyyyMMdd-HHmmssSS";
    });
    NSString *path = [self buildPath:[self homeDirectory] logType:kCurrentLogs fileName:[formatter stringFromDate:date]];
    return [NSString stringWithFormat:@"%@.log", path];
}

#pragma mark - Private (Logs)
-(NSArray *)obtainLogs:(NSString *)logType {
    NSString *path = [self buildPath:[self homeDirectory] logType:logType fileName:@""];
    return [self filesInDirectory:path];
}

#pragma mark - Private - FileSystem
-(NSString *)homeDirectory {
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
}
-(NSString *)buildPath:(NSString *)home logType:(NSString *)logType fileName:(NSString *)fileName {
    return [[home stringByAppendingPathComponent:logType] stringByAppendingPathComponent:fileName];
}
-(BOOL)createDirectory:(NSString *)path {
    NSError *error = nil;
    BOOL result = [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
    if (error && self.didError) { self.didError(error); }
    return result;
}
-(NSArray *)filesInDirectory:(NSString *)path {
    NSError *error = nil;
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:&error];
    
    if (error) {
        if (self.didError) { self.didError(error); }
        return [NSArray array];
    }
    
    return [files map:^id(NSString *file) {
        return [path stringByAppendingPathComponent:file];
    }];
}
-(BOOL)archiveLog:(NSString *)path {
    NSError *error = nil;
    NSString *archivePath = [self buildPath:[self homeDirectory] logType:self.archivedLogPath fileName:[path lastPathComponent]];
    if ([[NSFileManager defaultManager] moveItemAtPath:path toPath:archivePath error:&error]) {
        if (self.didArchive) { self.didArchive(archivePath); }
        return YES;
    }
    if (error && self.didError) { self.didError(error); }
    return NO;
}

#pragma mark - Rotation
-(NSString *)rotationMessage {
    NSString *appBuildString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    NSString *appVersionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *versionBuildString = [NSString stringWithFormat:@"Version: %@ (%@)", appVersionString, appBuildString];
    
    return [NSString stringWithFormat:@"Rotated Logs (App Version: %@", versionBuildString];
}

@end
