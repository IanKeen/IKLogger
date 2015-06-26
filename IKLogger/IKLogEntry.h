#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, IKLogEntryLevel) {
    IKLogEntryLevelNormal,
    IKLogEntryLevelError,
};

@interface IKLogEntry : NSObject
-(instancetype)initWithLevel:(IKLogEntryLevel)level data:(NSDictionary *)data prefix:(NSString *)prefix text:(NSString *)text, ...;

@property (nonatomic, strong, readonly) NSDate *timestamp;
@property (nonatomic, strong, readonly) NSString *prefix;
@property (nonatomic, strong, readonly) NSString *text;
@property (nonatomic, strong, readonly) NSDictionary *data;
@property (nonatomic, readonly) IKLogEntryLevel level;

@property (nonatomic, strong) NSString *file;
@property (nonatomic, strong) NSString *function;
@property (nonatomic) NSInteger line;
@end
