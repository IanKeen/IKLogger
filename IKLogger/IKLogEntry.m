#import "IKLogEntry.h"
#import <IKCore/NSJSONSerialization+String.h>
#import <IKCore/NSObject+Null.h>

@implementation IKLogEntry
#pragma mark - Lifecycle
-(instancetype)initWithLevel:(IKLogEntryLevel)level data:(NSDictionary *)data prefix:(NSString *)prefix text:(NSString *)text, ... {
    if (!(self = [super init])) { return nil; }
    _file = nil;
    _function = nil;
    _line = 0;
    
    _timestamp = [NSDate date];
    _level = level;
    _data = data;
    _prefix = prefix;
    
    va_list args;
    va_start(args, text);
    _text = [[NSString alloc] initWithFormat:text arguments:args];
    va_end(args);
    return self;
}

#pragma mark - Overrides
-(NSString *)description {
    NSString *timestampString = [[[self class] dateFormatter] stringFromDate:self.timestamp];
    NSString *dataString = [NSString stringWithFormat:@"%@", (self.data != nil ? [NSString stringWithFormat:@"\n%@", [NSJSONSerialization stringWithJSONObject:self.data options:NSJSONWritingPrettyPrinted error:nil]] : @"")];
    NSString *levelString = (self.level == IKLogEntryLevelNormal ? @"Normal" : @"Error");
    
    if (nilOrEmpty(self.file) || nilOrEmpty(self.function) || self.line == 0) {
        return [NSString stringWithFormat:@"[%@]: %@:%@: %@%@", timestampString, levelString, self.prefix, self.text, dataString];
    } else {
        return [NSString stringWithFormat:@"[%@][%@:%@@%ld]: %@:%@: %@%@", timestampString, [self.file lastPathComponent], self.function, (long)self.line, levelString, self.prefix, self.text, dataString];
    }
}

#pragma mark - Private
+(NSDateFormatter *)dateFormatter {
    static dispatch_once_t onceToken;
    static NSDateFormatter *formatter = nil;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    });
    return formatter;
}
@end
