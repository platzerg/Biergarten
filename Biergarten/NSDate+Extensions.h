//
//  NSDate+Extensions.h
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

@interface NSDate (Extensions)
   //      ------

// -------------------------------------------------------------------------------------------------

- (NSString *) asStartString;
- (NSString *) asEndString;
+ (NSDate *) nilDate;
+ (BOOL) isNilDate:(NSDate *) dValue;
- (BOOL) isNilDate;
- (NSDate *) minimum;
- (NSDate *) maximum;
- (NSString *) time;
- (NSString *) shortDayTime;
- (NSString *) day;
- (NSString *) dayAndTime;
- (NSString *) dayAndMonth;
- (NSString *) asString;
- (NSString *) asFileTimeStamp;
- (NSString *) asStringWithTime;
- (NSString *) asStringWithDayAndTime;
- (NSString *) asStringWithDay;
- (NSString *) asShift;
- (BOOL) sameDayToDate:(NSDate *) dValue;
- (BOOL) equalToDate:(NSDate *) dValue;
- (BOOL) notEqualToDate:(NSDate *) dValue;
- (BOOL) lowerToDate:(NSDate *) dValue;
- (BOOL) lowerEqualToDate:(NSDate *) dValue;
- (BOOL) greaterToDate:(NSDate *) dValue;
- (BOOL) greaterEqualToDate:(NSDate *) dValue;

// -------------------------------------------------------------------------------------------------

@end
