#import <Foundation/Foundation.h>

@class IKLog;
@class IKLogEntry;
typedef void(^logUpdatedBlock)(IKLog *log, IKLogEntry *entry);

@interface IKLog : NSObject
@property (nonatomic, strong, readonly) NSDate *timestamp;
@property (nonatomic, strong, readonly) NSArray *entries;
@property (nonatomic, copy) logUpdatedBlock updated;

-(instancetype)initWithUpdated:(logUpdatedBlock)updated;
-(void)addEntry:(IKLogEntry *)entry;
@end
