//
//  DataStore
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KCMutableDictionary.h"

/**
 *  Objects should conform to this protocol to be able to back DataStore
 */
@protocol KeyValueStore <NSObject>
-(void)setObject:(id)anObject forKey:(NSString *)key;
-(id)objectForKey:(NSString *)key;
-(void)removeObjectForKey:(NSString *)key;
@end


/**
 Provides a common interface to key value data storage
 that allows thread safe operations and easy resetting of data
 */
@interface DataStore : NSObject <KeyValueStore>
/**
 *  Create an new instance
 *
 *  @param store Underlying key value store that will hold the data
 *  @param named A friendly name the represent the dataset
 *
 *  @return A new instance
 */
-(instancetype)initWithKeyValueStore:(id<KeyValueStore>)store named:(NSString *)named;

/**
 *  Inserts default values into the store, if the key already exists the value is not stored
 *
 *  @param defaultKeyValues A NSDictionary representing the default key/values
 */
-(void)registerDefaults:(NSDictionary *)defaultKeyValues;

/**
 *  @return An NSDictionary of the current data
 */
-(NSDictionary *)currentData;

/**
 *  Clear all the data from the store
 */
-(void)reset;
@end


/*
 *  Out of the box support for different data structures to back DataStore with
 */

@interface NSMutableDictionary (KeyValueStore) <KeyValueStore>
@end
@interface KCMutableDictionary (KeyValueStore) <KeyValueStore>
@end
@interface NSUserDefaults (KeyValueStore) <KeyValueStore>
@end