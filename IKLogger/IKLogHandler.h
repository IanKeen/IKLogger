#import "IKLog.h"
#import "IKLogEntry.h"

@protocol IKLogHandler <NSObject>
-(void)logUpdated:(IKLog *)log entry:(IKLogEntry *)entry;
@end