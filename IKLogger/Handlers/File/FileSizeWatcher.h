#import <Foundation/Foundation.h>

typedef void(^fileSizeWatcherDidError)(NSError *error);

@interface FileSizeWatcher : NSObject
-(BOOL)isLogTooLarge:(NSString *)fullPath;

@property (nonatomic) NSInteger maxLogSize;
@property (nonatomic, copy) fileSizeWatcherDidError didError;
@end
