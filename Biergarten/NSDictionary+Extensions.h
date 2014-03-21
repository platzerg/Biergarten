//
//  NSDictionary+Extensions.h
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

@interface NSDictionary (Extensions)

// -------------------------------------------------------------------------------------------------

- (NSString *) stringForKey:(NSString *) sKey;
- (NSString *) textForKey:(NSString *) sKey;
- (NSArray *) arrayForKey:(NSString *) sKey
              inParentKey:(NSString *) sParentKey;

// -------------------------------------------------------------------------------------------------

@end
