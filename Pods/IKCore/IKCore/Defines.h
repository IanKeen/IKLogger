//
//  Defines
//
//  Created by Ian Keen on 2/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#ifndef IKCore_Defines_h
#define IKCore_Defines_h

#define IKCORE

/* MISC HELPERS */
#define __NARGS(unused, _1, _2, _3, _4, _5, VAL, ...) VAL
#define NARGS(...) __NARGS(unused, ## __VA_ARGS__, 5, 4, 3, 2, 1, 0)

/* OVERLOADABLE C FUNCTIONS */
#define OVERLOADABLE __attribute__((overloadable))

/* KEYPATH COMPILE TIME CHECKING */
#define keyPath(...) _keyPath(NARGS(__VA_ARGS__), __VA_ARGS__)
#define _keyPath(ARGC, ARGS...) __keyPath(ARGC, ARGS)
#define __keyPath(ARGC, ARGS...) keyPath_ ## ARGC (ARGS)
#define keyPath_1(property) keyPath_2(self, property)
#define keyPath_2(object, property) ({if(NO){ (void)object.property; }; @#property; })

//TODO: keyPathClass.. needs a better name.. the purpose of the method is to validate the keyPath on an INSTANCE of the parsed class..
//                      but I want to keep the name short.., I don't think theres a way to determin wether the first argument is
//                      a Class or an instance.. if there was I could simply rewrite the macro to handle it and just have 'keyPath'
#define keyPathClass(...) _keyPathClass(NARGS(__VA_ARGS__), __VA_ARGS__)
#define _keyPathClass(ARGC, ARGS...) __keyPathClass(ARGC, ARGS)
#define __keyPathClass(ARGC, ARGS...) keyPathClass_ ## ARGC (ARGS)
#define keyPathClass_1(property) keyPath_2(self, property)
#define keyPathClass_2(class, property) ({if(NO){ class *object = nil; (void)object.property; }; @#property; })

/* COMPILER ERROR SILENCING */
#define PERFORM_SELECTOR(code) _Pragma("clang diagnostic push") _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") code; _Pragma("clang diagnostic pop")

#endif
