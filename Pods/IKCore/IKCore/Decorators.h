//
//  Decorators
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

/*
 Convenience protocols simply used to add readability to the Result/Event/etc. classes.
 
 Simply add one to your declarations to let others know what type of data to expect
 i.e.:

 .h
 -(Result<NSString>)getResult:(NSNumber *)someInput;
 
 You can see from the return type that you can expect a NSString when successful
 NOTE: This does not add any compile/run time checks, these are simply decoration
 to add readability since objective-c does not have any form of generics
 
 You can add more by adding `DECORATOR(*className*)` anywhere gloablly in your code
 */

#define DECORATOR(__className)\
@protocol __className <NSObject> @end\
@interface NSObject (__className) <__className> @end

DECORATOR(Void)
DECORATOR(NSError)
DECORATOR(NSString)
DECORATOR(NSNumber)
DECORATOR(NSArray)
DECORATOR(NSDictionary)
DECORATOR(NSManagedObject)
DECORATOR(BOOL)
DECORATOR(UIViewController)
DECORATOR(UINavigationController)
DECORATOR(NSURLRequest)
DECORATOR(NSHTTPURLResponse)
DECORATOR(CGFloat)
DECORATOR(NSURL)
