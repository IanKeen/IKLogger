#import <Foundation/Foundation.h>
#import "IKLog.h"
#import "IKLogEntry.h"

@interface IKLogger : NSObject
+(instancetype)sharedInstance;
-(instancetype)initWithHandlers:(NSArray *)handlers;
-(void)reset;
@property (nonatomic, strong, readonly) IKLog *log;
@end

#define IKLog(TEXT, ...) IKLogWithDetails(nil, IKLogEntryLevelNormal, NSStringFromClass([self class]), TEXT, ##__VA_ARGS__)
#define IKLogWithData(DATA, TEXT, ...) IKLogWithDetails(DATA, IKLogEntryLevelNormal, NSStringFromClass([self class]), TEXT, ##__VA_ARGS__)

#define IKLogError(TEXT, ...) IKLogWithDetails(nil, IKLogEntryLevelError, NSStringFromClass([self class]), TEXT, ##__VA_ARGS__)
#define IKLogErrorWithData(DATA, TEXT, ...) IKLogWithDetails(DATA, IKLogEntryLevelError, NSStringFromClass([self class]), TEXT, ##__VA_ARGS__)

#define IKLogWithDetails(DATA, LEVEL, PREFIX, TEXT, ...) do { \
    IKLogEntry *entry = [[IKLogEntry alloc] initWithLevel:LEVEL data:DATA prefix:PREFIX text:TEXT, ##__VA_ARGS__]; \
    entry.function = @(__FUNCTION__); \
    entry.file = @(__FILE__); \
    entry.line = __LINE__; \
    [[IKLogger sharedInstance].log addEntry:entry]; \
} while(0)
