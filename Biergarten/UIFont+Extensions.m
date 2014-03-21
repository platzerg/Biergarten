//
//  UIFont+Extensions.m
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

#import "UIFont+Extensions.h"

@implementation UIFont (Extensions)

// -------------------------------------------------------------------------------------------------

+ (void) logAllFonts {
   //    -----------
   NSArray *aFamily = [[UIFont familyNames] 
                       sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
   for (NSString *sFamily in aFamily) {
      NSLog(@"Family: %@", sFamily);
      
      for (NSString *sFont in [UIFont fontNamesForFamilyName:sFamily] ){
         NSLog(@"   Name: %@", sFont);
      }
   }
}

// -------------------------------------------------------------------------------------------------

@end
