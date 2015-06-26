#import "IKLogger.h"
#import "IKLogHandler.h"

static IKLogger *sharedLogger = nil;

@interface IKLogger ()
@property (nonatomic, strong) NSArray *handlers;
@end

@implementation IKLogger
#pragma mark - Lifecycle
+(instancetype)sharedInstance {
    if (sharedLogger) { return sharedLogger; }
    
    @throw [NSException exceptionWithName:@"Logger" reason:@"There is not a shared instance" userInfo:nil];
}
-(instancetype)initWithHandlers:(NSArray *)handlers {
    if (!(self = [super init])) { return nil; }
    self.handlers = [NSArray arrayWithArray:handlers];
    [self reset];
    if (sharedLogger == nil) { sharedLogger = self; }
    
    return self;
}

#pragma mark - Public
-(void)reset {
    _log = [[IKLog alloc] initWithUpdated:[self updatedBlock]];
}

#pragma mark - Private
+(dispatch_queue_t)handlerQueue {
    static dispatch_once_t onceToken;
    static dispatch_queue_t queue = nil;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("Logger.Output.Queue", DISPATCH_QUEUE_SERIAL);
    });
    return queue;
}
-(logUpdatedBlock)updatedBlock {
    return ^(IKLog *log, IKLogEntry *entry) {
        dispatch_async([IKLogger handlerQueue], ^{
            [self.handlers enumerateObjectsUsingBlock:^(id<IKLogHandler> handler, NSUInteger idx, BOOL *stop) {
                [handler logUpdated:log entry:entry];
            }];
        });
    };
}
@end




