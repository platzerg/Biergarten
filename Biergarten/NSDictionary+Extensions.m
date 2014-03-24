//
//  NSDictionary+Extensions.m
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

#import "NSDictionary+Extensions.h"

// -------------------------------------------------------------------------------------------------

@implementation NSDictionary (Extensions)

// -------------------------------------------------------------------------------------------------

+(NSDictionary*)dictionaryWithContentsOfJSONURLString:(NSString*)urlAddress
{
    NSData* data = [NSData dataWithContentsOfURL: [NSURL URLWithString: urlAddress] ];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

-(NSData*)toJSON
{
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

- (NSString *) stringForKey:(NSString *) sKey {
   //          ------------
   NSString *sValue;
   NSObject *oValue = self[sKey];
   
   if (oValue == [NSNull null]) {
      sValue = @"";
   } else {
      sValue = (NSString *)oValue;
   }
   
   return [sValue trim];
}

// -------------------------------------------------------------------------------------------------

- (NSString *) textForKey:(NSString *) sKey {
   //          ----------
   NSString *sValue;
   NSDictionary *oValues = self[sKey];
   
   if (oValues) {
      sValue = oValues[@"text"];
   } else {
      sValue = @"";
   }
   
   return sValue;
}

// -------------------------------------------------------------------------------------------------

- (NSArray *) arrayForKey:(NSString *) sKey
              inParentKey:(NSString *) sParentKey {
   //         -----------
   NSDictionary *oValues = self[sParentKey];
   
   if (oValues) {
      NSArray *aValue = oValues[sKey];
      return aValue;
   } else {
      return nil;
   }
}

// -------------------------------------------------------------------------------------------------

@end
