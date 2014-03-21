//
//  NSDate+Extensions.m
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

#import "NSDate+Extensions.h"

@implementation NSDate (Extensions)

// -------------------------------------------------------------------------------------------------

- (NSString *) description {
   //          -----------
   // Fixes bug in 4.1
   return [self asStringWithTime];
}

// -------------------------------------------------------------------------------------------------

+ (NSDate *) nilDate {
   //        -------
   static NSDateFormatter *oDateFormatter = nil;
   
   if (oDateFormatter == nil) {
      oDateFormatter = [[NSDateFormatter alloc] init];
      oDateFormatter.dateFormat = @"01/01/0001 00:00:00";
   }
   
   NSDate *dValue = [oDateFormatter dateFromString:@"01/01/0001 00:00:00"];
   
   return dValue;
}

// -------------------------------------------------------------------------------------------------

+ (BOOL) isNilDate:(NSDate *) dValue {
   //    ---------
   return [dValue sameDayToDate:[NSDate nilDate]];
}

// -------------------------------------------------------------------------------------------------

- (BOOL) isNilDate {
   //    ---------
   return [self sameDayToDate:[NSDate nilDate]];
}

// -------------------------------------------------------------------------------------------------

- (NSDate *) minimum {
   //        -------
   static NSDateFormatter *oDateFormatter = nil;
   
   if (oDateFormatter == nil) {
      oDateFormatter = [[NSDateFormatter alloc] init];
      oDateFormatter.dateFormat = @"yyyy-MM-dd 00:00:00";
   }
   
   NSString *sValue = [oDateFormatter stringFromDate:self];
   NSDate *dValue = [oDateFormatter dateFromString:sValue];
   
   return dValue;
}

// -------------------------------------------------------------------------------------------------

- (NSDate *) maximum {
   //        -------
   static NSDateFormatter *oDateFormatter = nil;
   
   if (oDateFormatter == nil) {
      NSLocale *oLocale = [[NSLocale alloc] init];
      oDateFormatter = [[NSDateFormatter alloc] init];
      oDateFormatter.locale = oLocale;
      oDateFormatter.dateFormat = @"yyyy-MM-dd";
   }
   
   NSString *sValue = [[oDateFormatter stringFromDate:self] stringByAppendingString:@" 23:59"];
   oDateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
   
   NSDate *dValue = [oDateFormatter dateFromString:sValue];
   
   return dValue;
}

// -------------------------------------------------------------------------------------------------

- (BOOL) sameDayToDate:(NSDate *) dValue {
   //    -------------
   return [[self.description substringToIndex:10] isEqualToString:[dValue.description substringToIndex:10]];
}

// -------------------------------------------------------------------------------------------------

- (NSString *) time {
   //          ----
   // "2008-12-31 14:00:39 +0100"
   // YYYY-MM-DD HH:MM -> Datum
   // siehe http://unicode.org/reports/tr35/tr35-6.html#Date%5FFormat%5FPatterns
   static NSDateFormatter *oDateFormatter = nil;
   
   if (oDateFormatter == nil) {
      NSLocale *oLocale = [[NSLocale alloc] init];
      oDateFormatter = [[NSDateFormatter alloc] init];
      oDateFormatter.locale = oLocale;
      oDateFormatter.dateFormat = @"HH:mm";
   }
   
   NSString *sValue = [oDateFormatter stringFromDate:self];
   
   return sValue;
}

// -------------------------------------------------------------------------------------------------

- (NSString *) day {
   //          ---
   // "2008-12-31 14:00:39 +0100"
   NSString *sDay = [self.description substringToIndex:2];
   
   return sDay;
}

// -------------------------------------------------------------------------------------------------

- (NSString *) dayAndTime {
   //          ----------
   // YYYY-MM-DD HH:MM -> Datum
   // siehe http://unicode.org/reports/tr35/tr35-6.html#Date%5FFormat%5FPatterns
   static NSDateFormatter *oDateFormatter = nil;
   
   if (oDateFormatter == nil) {
      NSLocale *oLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"de_DE"];
      oDateFormatter = [[NSDateFormatter alloc] init];
      oDateFormatter.locale = oLocale;
      oDateFormatter.dateFormat = @"EEEE, HH:mm";
   }
   
   NSString *sValue = [oDateFormatter stringFromDate:self];
   
   return sValue;
}

// -------------------------------------------------------------------------------------------------

- (NSString *) dayAndMonth {
   //          -----------
   // "2008-12-31 14:00:39 +0100"
   NSString *sDay = [self.description substringToIndex:6];
   
   return sDay;
}

// -------------------------------------------------------------------------------------------------

- (NSString *) shortDayTime {
   //          ------------
   return [NSString stringWithFormat:@"%@ %@", [self.description substringToIndex:6], self.time];
}

// -------------------------------------------------------------------------------------------------

- (NSString *) asString {
   //          --------
   // YYYY-MM-DD HH:MM -> Datum
   // siehe http://unicode.org/reports/tr35/tr35-6.html#Date%5FFormat%5FPatterns
   static NSDateFormatter *oDateFormatter;
   
   if (oDateFormatter == nil) {
      oDateFormatter = [[NSDateFormatter alloc] init];
      // oDateFormatter.dateFormat = @"yyyy-MM-dd";
      oDateFormatter.dateStyle = kCFDateFormatterShortStyle;
   }
   
   NSString *sValue = [oDateFormatter stringFromDate:self];
   
   return sValue;
}

// -------------------------------------------------------------------------------------------------

- (NSString *) asFileTimeStamp {
   //          ---------------
   // YYYY-MM-DD HH:MM -> Datum
   // siehe http://unicode.org/reports/tr35/tr35-6.html#Date%5FFormat%5FPatterns
   static NSDateFormatter *oDateFormatter = nil;
   
   if (oDateFormatter == nil) {
      NSLocale *oLocale = [[NSLocale alloc] init];
      oDateFormatter = [[NSDateFormatter alloc] init];
      oDateFormatter.locale = oLocale;
      oDateFormatter.dateFormat = @"yyyy-MM-dd--HH-mm-ss'.png'";
   }
   
   NSString *sValue = [oDateFormatter stringFromDate:self];
   
   return sValue;
}

// -------------------------------------------------------------------------------------------------

- (NSString *) asStringWithTime {
   //          ----------------
   // YYYY-MM-DD HH:MM -> Datum
   // siehe http://unicode.org/reports/tr35/tr35-6.html#Date%5FFormat%5FPatterns
   static NSDateFormatter *oDateFormatter = nil;
   
   if (oDateFormatter == nil) {
      NSLocale *oLocale = [[NSLocale alloc] init];
      oDateFormatter = [[NSDateFormatter alloc] init];
      oDateFormatter.locale = oLocale;
      oDateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
   }
   
   NSString *sValue = [oDateFormatter stringFromDate:self];
   
   return sValue;
}

// -------------------------------------------------------------------------------------------------

- (NSString *) asStringWithDay {
   //          ---------------
   // YYYY-MM-DD HH:MM -> Datum
   // siehe http://unicode.org/reports/tr35/tr35-6.html#Date%5FFormat%5FPatterns
   static NSDateFormatter *oDateFormatter = nil;
   
   if (oDateFormatter == nil) {
      NSLocale *oLocale = [[NSLocale alloc] init];
      oDateFormatter = [[NSDateFormatter alloc] init];
      oDateFormatter.locale = oLocale;
      oDateFormatter.dateFormat = @"EE, dd.MM.yyyy";
   }
   
   NSString *sValue = [oDateFormatter stringFromDate:self];
   
   return sValue;
}

// -------------------------------------------------------------------------------------------------

- (NSString *) asStringWithDayAndTime {
   //          ----------------------
   // YYYY-MM-DD HH:MM -> Datum
   // siehe http://unicode.org/reports/tr35/tr35-6.html#Date%5FFormat%5FPatterns
   static NSDateFormatter *oDateFormatter = nil;
   
   if (oDateFormatter == nil) {
      NSLocale *oLocale = [[NSLocale alloc] init];
      oDateFormatter = [[NSDateFormatter alloc] init];
      oDateFormatter.locale = oLocale;
      oDateFormatter.dateFormat = @"EEEE, dd.MM.yyyy HH:mm";
   }
   
   NSString *sValue = [oDateFormatter stringFromDate:self];
   
   return sValue;
}

// -------------------------------------------------------------------------------------------------

- (NSString *) asShift {
   //          -------
   NSString *sValue;
   
   static NSDateFormatter *oDateFormatter = nil;
   
   if (oDateFormatter == nil) {
      NSLocale *oLocale = [[NSLocale alloc] init];
      oDateFormatter = [[NSDateFormatter alloc] init];
      oDateFormatter.locale = oLocale;
      oDateFormatter.dateFormat = @"HH";
   }
   
   int nHour = [[oDateFormatter stringFromDate:self] intValue];
   
   if (nHour <= 6) {
      sValue = @"Morgens";
   } else if (nHour <= 14) {
      sValue = @"Mittags";
   } else {
      sValue = @"Abends";
   }
   
   return sValue;
}

// -------------------------------------------------------------------------------------------------

- (NSString *) asStartString {
   //          -------------
   static NSDateFormatter *oDateFormatter = nil;
   
   if (oDateFormatter == nil) {
      NSLocale *oLocale = [[NSLocale alloc] init];
      oDateFormatter = [[NSDateFormatter alloc] init];
      oDateFormatter.locale = oLocale;
      oDateFormatter.dateFormat = @"EEEE, HH:mm";
   }
   
   NSString *sValue = [oDateFormatter stringFromDate:self];
   
   return sValue;
}

// -------------------------------------------------------------------------------------------------

- (NSString *) asEndString {
   //          -----------
   return [self time];
}

// -------------------------------------------------------------------------------------------------

- (BOOL) equalToDate:(NSDate *) dValue {
   //    -----------
   return [self compare:dValue] == NSOrderedSame;
}

// -------------------------------------------------------------------------------------------------

- (BOOL) notEqualToDate:(NSDate *) dValue {
   //    --------------
   return [self compare:dValue] != NSOrderedSame;
}

// -------------------------------------------------------------------------------------------------

- (BOOL) lowerToDate:(NSDate *) dValue {
   //    -----------
   return [self compare:dValue] == NSOrderedAscending;
}

// -------------------------------------------------------------------------------------------------

- (BOOL) lowerEqualToDate:(NSDate *) dValue {
   //    ----------------
   return [self compare:dValue] != NSOrderedDescending;
}

// -------------------------------------------------------------------------------------------------

- (BOOL) greaterToDate:(NSDate *) dValue {
   //    -------------
   return [self compare:dValue] == NSOrderedDescending;
}

// -------------------------------------------------------------------------------------------------

- (BOOL) greaterEqualToDate:(NSDate *) dValue {
   //    ------------------
   return [self compare:dValue] != NSOrderedAscending;
}

// -------------------------------------------------------------------------------------------------

@end
