#import "ConsoleLogHandler.h"

@implementation ConsoleLogHandler
-(void)logUpdated:(IKLog *)log entry:(IKLogEntry *)entry {
    printf("%s\n", [[entry description] UTF8String]);
}
@end
