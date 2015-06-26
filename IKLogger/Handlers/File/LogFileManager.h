#import <Foundation/Foundation.h>
#import "FileArchiver.h"
#import "FileSizeWatcher.h"

typedef void(^logFileManagerDidError)(NSError *error);
typedef void(^logFileManagerDidArchive)(NSString *fullPath);

@interface LogFileManager : NSObject
-(instancetype)initWithArchiver:(FileArchiver *)archiver watcher:(FileSizeWatcher *)watcher;

-(void)updatedLogAt:(NSString *)fullPath;
-(NSString *)fullPathForLogDated:(NSDate *)date;

@property (nonatomic, copy) logFileManagerDidError didError;
@property (nonatomic, copy) logFileManagerDidArchive didArchive;
@end
