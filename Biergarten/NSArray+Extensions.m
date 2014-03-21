//
//  NSArray+Extensions.m
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

@implementation NSArray (Extensions)

// -------------------------------------------------------------------------------------------------

- (id) firstObject {
   //  -----------
   if ([self count] == 0) {
      return nil;
   } else {
      return self[0];
   }
}

// -------------------------------------------------------------------------------------------------

- (NSArray *) sortedWithKey:(NSString *) sKey 
                  ascending:(BOOL) bAscending {
   //         -------------
   // Beispiel für ein Array aus Client-Objekten:
   // NSLog(@"%@", [aClient sortedWithKey:@"lastname" ascending:true]);
   NSSortDescriptor *oSortDescriptor = [[NSSortDescriptor alloc] initWithKey:sKey ascending:bAscending];
   NSArray *aSortDescriptor = @[oSortDescriptor];
   
   NSArray *aReturn = [self sortedArrayUsingDescriptors:aSortDescriptor];
   
   return aReturn;
}

// -------------------------------------------------------------------------------------------------

- (NSArray *) sortedWithKeys:(NSString *) sKeys {
   //         --------------
   // Beispiel für ein Array aus Client-Objekten:
   // [aClient sortedWithKeys:@"lastname,firstname"], [aClient sortedWithKeys:@"lastname,firstname|0"]
   NSArray *aKey = [sKeys componentsSeparatedByString:@","];
   NSMutableArray *aSort = [[NSMutableArray alloc] init];
   
   for (NSString *sKey in aKey) {
      NSArray *aItem = [sKey componentsSeparatedByString:@"|"];
      BOOL bAscending = ([aItem count] == 1 || [aItem[1] isEqualToString:@"1"]);
      
      NSSortDescriptor *oSort = [[NSSortDescriptor alloc] initWithKey:aItem[0]
                                                            ascending:bAscending];
      [aSort addObject:oSort];
   }
   
   NSArray *aReturn = [self sortedArrayUsingDescriptors:[NSArray arrayWithArray:aSort]];
   
   return aReturn;
}

// -------------------------------------------------------------------------------------------------

- (NSArray *) sortedWithKey:(NSString *) sKey {
   //         -------------
   return [self sortedWithKey:sKey ascending:true];
}

// -------------------------------------------------------------------------------------------------

@end
