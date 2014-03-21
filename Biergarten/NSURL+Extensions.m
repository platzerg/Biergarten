//
//  NSString+Extensions.m
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

#include <sys/xattr.h>
#import "NSURL+Extensions.h"

// -------------------------------------------------------------------------------------------------

@implementation NSURL (Extensions)

// -------------------------------------------------------------------------------------------------

- (BOOL) addSkipBackupAttribute {
   //    ----------------------
   const char *filePath = [[self path] fileSystemRepresentation];
   const char *attrName = "com.apple.MobileBackup";
   
   if (&NSURLIsExcludedFromBackupKey == nil) { // iOS 5.0.1 and lower
      u_int8_t attrValue = 1;
      int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
      
      return result == 0;
      
   } else {
      // First try and remove the extended attribute if it is present
      int result = getxattr(filePath, attrName, NULL, sizeof(u_int8_t), 0, 0);
      
      if (result != -1) {
         // The attribute exists, we need to remove it
         int removeResult = removexattr(filePath, attrName, 0);
         
         if (removeResult == 0) {
            NSLog(@"Removed extended attribute on file %@", self);
         }
      }
      
      // Set the new key
      NSError *error = nil;
      [self setResourceValue:[NSNumber numberWithBool:true] 
                      forKey:NSURLIsExcludedFromBackupKey 
                       error:&error];
      return error == nil;
   }
}

// -------------------------------------------------------------------------------------------------

@end
