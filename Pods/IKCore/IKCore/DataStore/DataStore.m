//
//  DataStore
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import "DataStore.h"

@interface DataStore ()
@property (nonatomic, strong) id<KeyValueStore> store;
@property (nonatomic, strong) dispatch_queue_t dataQueue;
@property (nonatomic, strong) NSString *name;
@end

@implementation DataStore
#pragma mark - Lifecycle
-(instancetype)initWithKeyValueStore:(id)store named:(NSString *)name {
    if (!(self = [super init])) { return nil; }
    const char *queueName = [[NSString stringWithFormat:@"DataStore::%@", name] cStringUsingEncoding:NSUTF8StringEncoding];
    self.dataQueue = dispatch_queue_create(queueName, DISPATCH_QUEUE_SERIAL);
    self.name = name;
    self.store = store;
    return self;
}

#pragma mark - Public
-(void)registerDefaults:(NSDictionary *)defaultKeyValues {
    [defaultKeyValues enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
        if ([self objectForKey:key queue:self.dataQueue] == nil) {
            [self setObject:obj forKey:key];
        }
    }];
}
-(NSDictionary *)currentData {
    return [self nameSpacedStore];
}
-(void)reset {
    [self.store removeObjectForKey:self.name];
    [self saveUserDefaults];
}

#pragma mark - KeyValueStore
-(id)objectForKey:(NSString *)key {
    return [self objectForKey:key queue:self.dataQueue];
}
-(void)setObject:(id)value forKey:(NSString *)key {
    [self setObject:value forKey:key queue:self.dataQueue];
}
-(void)removeObjectForKey:(NSString *)key {
    [self removeObjectForKey:key queue:self.dataQueue];
}

#pragma mark - Synchronisation
-(id)objectForKey:(NSString *)key queue:(dispatch_queue_t)queue {
    __block id result = nil;
    dispatch_sync(queue, ^{
        result = [[self nameSpacedStore] objectForKey:key];
    });
    return result;
}
-(void)setObject:(id)value forKey:(NSString *)key queue:(dispatch_queue_t)queue {
    if (value == nil) {
        [self removeObjectForKey:key queue:queue];
        
    } else {
        dispatch_sync(queue, ^{
            NSMutableDictionary *data = [self nameSpacedStore];
            [data setObject:value forKey:key];
            [self.store setObject:data forKey:self.name];
            [self saveUserDefaults];
        });
    }
}
-(void)removeObjectForKey:(NSString *)key queue:(dispatch_queue_t)queue {
    dispatch_sync(queue, ^{
        NSMutableDictionary *data = [self nameSpacedStore];
        [data removeObjectForKey:key];
        [self.store setObject:data forKey:self.name];
        [self saveUserDefaults];
    });
}

#pragma mark - Namespacing
-(NSMutableDictionary *)nameSpacedStore {
    return [NSMutableDictionary dictionaryWithDictionary:[self.store objectForKey:self.name]];
}

#pragma mark - HAX
-(void)saveUserDefaults {
    //HAX: to seemlessly support NSUserDefaults when it is used
    if ([self.store isKindOfClass:[NSUserDefaults class]]) {
        [((NSUserDefaults *)self.store) synchronize];
    }
}
@end
