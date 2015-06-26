#import <Foundation/Foundation.h>
#import "IKLogHandler.h"

typedef NSDictionary * (^bugsnagCommonData)(void);

@interface BugsnagLogHandler : NSObject <IKLogHandler>
-(instancetype)initWithCommonData:(bugsnagCommonData)commonData;
@end
