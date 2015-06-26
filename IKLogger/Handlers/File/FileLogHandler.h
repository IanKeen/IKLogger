#import <Foundation/Foundation.h>
#import "IKLogHandler.h"

@class LogFileManager;
typedef void(^fileLogHandlerDidArchive)(NSString *fullPath);

@interface FileLogHandler : NSObject <IKLogHandler>
-(instancetype)initWithLogFileManager:(LogFileManager *)manager;
@property (nonatomic, copy) fileLogHandlerDidArchive didArchive;
@end
