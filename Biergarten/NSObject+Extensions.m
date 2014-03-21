//
//  NSObject+Extensions.h
//
//  MobileTech Conference 2014
//  Copyright (c) 2014 Ivo Wessel. All rights reserved.
//  Fragen zum Quellcode? Unterstützung bei iOS-Projekten? Melden Sie sich bei mir...
//
//  Ivo Wessel
//  Lehrter Str. 57, Haus 2
//  D-10557 Berlin
//  Phone : +49-(0)30-89 62 64 77
//  Mobile: +49-(0)177-4 86 93 77
//  Skype : ivo.wessel
//  E-Mail: email@ivo-wessel.de
//  Web   : www.we-make-apps.com
//
// -------------------------------------------------------------------------------------------------

#import "NSObject+Extensions.h"
#import <objc/runtime.h>

@implementation NSObject (Extensions)

// -------------------------------------------------------------------------------------------------

static const char *bagKey = "bag";

// =================================================================================================
#pragma mark -
#pragma mark Bag methods
// =================================================================================================

@dynamic bag;

- (id) bag {
   //  ---
   return objc_getAssociatedObject(self, bagKey);
}

// -------------------------------------------------------------------------------------------------

- (void) setBag:(id) oBag {
   //    ------
   objc_setAssociatedObject(self, bagKey, oBag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// =================================================================================================
#pragma mark -
#pragma mark Property methods
// =================================================================================================

+ (NSArray *) properties {
   //         ----------
   NSMutableArray *aProperty = [[NSMutableArray alloc] init];
   
   unsigned int nCount;
   objc_property_t *properties = class_copyPropertyList([self class], &nCount);
   
   for (int i = 0; i < nCount; i++) {
      objc_property_t property = properties[i];
      [aProperty addObject:@(property_getName(property))];
   }
   
   NSArray *aReturn = [NSArray arrayWithArray:aProperty];
   
   // [aProperty release];
   
   return aReturn;
}

// -------------------------------------------------------------------------------------------------

+ (BOOL) hasProperty:(NSString *) sProperty {
   //    -----------
   return class_getProperty([self class], [sProperty UTF8String]) != NULL;
}

// -------------------------------------------------------------------------------------------------

- (NSArray *) properties {
   //         ----------
   NSMutableArray *aProperty = [[NSMutableArray alloc] init];
   
   unsigned int nCount;
   objc_property_t *properties = class_copyPropertyList([self class], &nCount);
   
   for (int i = 0; i < nCount; i++) {
      objc_property_t property = properties[i];
      [aProperty addObject:@(property_getName(property))];
   }
   
   NSArray *aReturn = [NSArray arrayWithArray:aProperty];
   
   // [aProperty release];
   
   return aReturn;
}

// -------------------------------------------------------------------------------------------------

- (BOOL) hasProperty:(NSString *) sProperty {
   //    -----------
   return class_getProperty([self class], [sProperty UTF8String]) != NULL ||
      [self respondsToSelector:NSSelectorFromString(sProperty)];
}

// -------------------------------------------------------------------------------------------------

- (void) performSelector:(SEL) oSelector 
              afterDelay:(float) nDelay {
   //    ---------------
   [self performSelector:oSelector withObject:nil afterDelay:nDelay];
}

// -------------------------------------------------------------------------------------------------

@end