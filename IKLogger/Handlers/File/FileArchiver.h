#import <Foundation/Foundation.h>

typedef void(^fileArchiverDidError)(NSError *error);
typedef void(^fileArchiverDidArchive)(NSString *fullPath);

@interface FileArchiver : NSObject
-(void)rotateLogs;
-(NSArray *)archivedLogs;
-(NSString *)fullPathForLogDated:(NSDate *)date;

@property (nonatomic, copy) NSString *activeLogPath;
@property (nonatomic, copy) NSString *archivedLogPath;
@property (nonatomic, copy) fileArchiverDidArchive didArchive;
@property (nonatomic, copy) fileArchiverDidError didError;
@end
