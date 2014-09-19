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

#import <CommonCrypto/CommonDigest.h>
#import "NSString+Extensions.h"

// -------------------------------------------------------------------------------------------------

@implementation NSString (Extensions)

// =================================================================================================
#pragma mark - LoremIpsum methods
// =================================================================================================

typedef enum {
   LoremIpsumTypeLength,
   LoremIpsumTypeMaxLength,
   LoremIpsumTypeWords,
   LoremIpsumTypeMaxWords
} LoremIpsumType;

// -------------------------------------------------------------------------------------------------

+ (NSString *) loremIpsumWithValue:(int) nValue
                              type:(LoremIpsumType) nType {
   //          -------------------
   // LoremIpsumTypeLength, LoremIpsumTypeMaxLength, LoremIpsumTypeWords, LoremIpsumTypeMaxWords
   NSString *sValue;
   static NSString *sLoremIpsum =
   @"Lorem ipsum dolor sit amet, consectetur adipisici elit, sed eiusmod tempor incidunt ut "
   @"labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco "
   @"laboris nisi ut aliquid ex ea commodi consequat. Quis aute iure reprehenderit in voluptate "
   @"velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint obcaecat cupiditat non "
   @"proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
   
   if (nType == LoremIpsumTypeMaxLength || nType == LoremIpsumTypeMaxWords) {
      // Eine zufällige Zahl zwischen 1 (!) und dem Maximalwert nValue
      nValue = (arc4random() % nValue) + 1;
   }
   
   switch (nType) {
      case LoremIpsumTypeLength:
      case LoremIpsumTypeMaxLength:
         // Gewünschte Länge > vorhandene Länge -> sLoremIpsum wiederholen
         if (nValue > sLoremIpsum.length) {
            NSString *sTemp = [[sLoremIpsum stringByAppendingString:@" "]
                               repeat:(int)(nValue / [sLoremIpsum length] + 1)];
            sValue = [sTemp substringToIndex:nValue];
         } else {
            sValue = [sLoremIpsum substringToIndex:nValue];
         }
         break;
         
      case LoremIpsumTypeWords:
      case LoremIpsumTypeMaxWords: {
         NSMutableArray *aValue = [[NSMutableArray alloc] initWithCapacity:nValue];
         NSArray *aLoremIpsum = [sLoremIpsum componentsSeparatedByString:@" "];
         int nLoremIpsum = [aLoremIpsum count];
         
         for (int i = 0; i < nValue; i++) {
            // Modulo für den Fall Wunschanzahl > Wortanzahl
            [aValue addObject:aLoremIpsum[i % nLoremIpsum]];
         }
         
         sValue = [aValue componentsJoinedByString:@" "];
         break;
      }
   }
   
   return sValue;
}

// -------------------------------------------------------------------------------------------------

+ (NSString *) loremIpsumWithLength:(int) nLength {
   //          --------------------
   return [NSString loremIpsumWithValue:nLength
                                   type:LoremIpsumTypeLength];
}

// -------------------------------------------------------------------------------------------------

+ (NSString *) loremIpsumWithMaxLength:(int) nLength {
   //          -----------------------
   return [NSString loremIpsumWithValue:nLength
                                   type:LoremIpsumTypeMaxLength];
}

// -------------------------------------------------------------------------------------------------

+ (NSString *) loremIpsumWithWords:(int) nCount {
   //          -------------------
   return [NSString loremIpsumWithValue:nCount
                                   type:LoremIpsumTypeWords];
}

// -------------------------------------------------------------------------------------------------

+ (NSString *) loremIpsumWithMaxWords:(int) nCount {
   //          ----------------------
   return [NSString loremIpsumWithValue:nCount
                                   type:LoremIpsumTypeMaxWords];
}

// -------------------------------------------------------------------------------------------------

- (NSString *) randomHtmlFormat {
   //          ----------------
   // Fett ein/aus, Italic ein/aus, Ohne Format ein/aus
   NSArray *aFormat = @[@"<b>", @"</b>", @"<i>", @"</i>", @"", @""];
   NSArray *aWord = [self componentsSeparatedByString:@" "];
   NSMutableArray *aValue = [[NSMutableArray alloc] initWithCapacity:[aWord count]];
   NSString *sOpen, *sClose;
   int nFormat;
   
   for (NSString *sWord in aWord) {
      nFormat = arc4random() % 3 * 2; // 0, 2 oder 4
      sOpen = aFormat[nFormat];
      sClose = aFormat[nFormat + 1];
      [aValue addObject:[NSString stringWithFormat:@"%@%@%@", sOpen, sWord, sClose]];
   }
   
   NSString *sValue = [aValue componentsJoinedByString:@" "];
   
   return sValue;
}

// -------------------------------------------------------------------------------------------------

- (NSString *) substringFrom:(int) nFrom
                          to:(int) nTo {
   //          -------------
	NSRange oRange;
	oRange.location = nFrom;
	oRange.length = nTo - nFrom;
   
	return [self substringWithRange:oRange];
}

// -------------------------------------------------------------------------------------------------

- (int) indexOf:(NSString *) substring
           from:(int) nFrom {
   //   -------
	NSRange oRange;
	oRange.location = nFrom;
	oRange.length = [self length] - oRange.location;
	
	NSRange oIndex = [self rangeOfString:substring
                                options:NSLiteralSearch
                                  range:oRange];
	if (oIndex.location == NSNotFound) {
		return -1;
	} else {
      return oIndex.location + oIndex.length;
   }
}

// =================================================================================================
#pragma mark - uniqueIdentifier Ersatz
// =================================================================================================

- (NSString *) stringFromMD5 {
   //          -------------
   if ([self length] == 0) {
      return nil;
   }
   
   const char *value = [self UTF8String];
   unsigned char buffer[CC_MD5_DIGEST_LENGTH];
   CC_MD5(value, strlen(value), buffer);
   
   NSMutableString *sValue = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
   
   for (int i=0; i < CC_MD5_DIGEST_LENGTH; i++){
      [sValue appendFormat:@"%02x", buffer[i]];
   }
   
   return sValue;
}

// -------------------------------------------------------------------------------------------------

- (NSString *) removeString:(NSString *) sValue {
   //          ------------
   return [self stringByReplacingOccurrencesOfString:sValue
                                          withString:@""];
}

// -------------------------------------------------------------------------------------------------

- (NSString *) removeStrings:(NSString *) sValue {
   //          -------------
   int nLength = [sValue length];
   NSString *sReturn = self;
   
   for (int i = 0; i < nLength; i++) {
      sReturn = [sReturn stringByReplacingOccurrencesOfString:[sValue substringWithRange:NSMakeRange(i, 1)]
                                                   withString:@""];
   }
   
   return sReturn;
}

// -------------------------------------------------------------------------------------------------

- (BOOL) equalToString:(NSString *) sValue {
   //    -------------
   return [self compare:sValue] == NSOrderedSame;
}

// -------------------------------------------------------------------------------------------------

- (BOOL) notEqualToString:(NSString *) sValue {
   //    ----------------
   return [self compare:sValue] != NSOrderedSame;
}

// -------------------------------------------------------------------------------------------------

- (BOOL) lowerToString:(NSString *) sValue {
   //    -------------
   return [self compare:sValue] == NSOrderedAscending;
}

// -------------------------------------------------------------------------------------------------

- (BOOL) lowerEqualToString:(NSString *) sValue {
   //    ------------------
   return [self compare:sValue] != NSOrderedDescending;
}

// -------------------------------------------------------------------------------------------------

- (BOOL) greaterToString:(NSString *) sValue {
   //    ---------------
   return [self compare:sValue] == NSOrderedDescending;
}

// -------------------------------------------------------------------------------------------------

- (BOOL) greaterEqualToString:(NSString *) sValue {
   //    --------------------
   return [self compare:sValue] != NSOrderedAscending;
}

// -------------------------------------------------------------------------------------------------

- (NSString *) phoneNumber {
   //          -----------
   NSString *sPhone = [self removeString:@" "];
   sPhone = [sPhone removeString:@"(0)"];
   
   return [NSString stringWithFormat:@"tel://%@", sPhone];
}

// -------------------------------------------------------------------------------------------------

- (NSString *) streetWithoutNumber {
   //          -------------------
   // [@"1,3,5,6,7,8,9,10," contains:@"3,"] -> true
   NSRange oRange = [self rangeOfString:@" " options:NSBackwardsSearch];
   
   if (oRange.location == NSNotFound) {
      return self;
   } else {
      NSString *sNumber = [self substringWithRange:NSMakeRange(oRange.location + 1, 1)];
      
      if ([sNumber intValue] == 0)
         return self;
      else
         return [self substringToIndex:oRange.location];
   }
}

// -------------------------------------------------------------------------------------------------

- (NSString *) repeat:(int) nRepeat {
   //          ------
   NSMutableString *sText = [[NSMutableString alloc] initWithCapacity:nRepeat * [self length]];
   
   for (int i = 0; i < nRepeat; i++) {
      [sText appendString:self];
   }
   
   NSString *sReturn = [NSString stringWithString:sText];
   
   return sReturn;
}

// -------------------------------------------------------------------------------------------------

- (NSString *) removeCheckbox:(NSString *) sText {
   //          --------------
   NSString *sValue = [NSString stringWithFormat:@"%@|", sText];
   
   if ([self contains:sValue]) {
      NSString *sNew = [self removeString:sValue];
      return sNew;
   } else {
      return self;
   }
}

// -------------------------------------------------------------------------------------------------

- (NSString *) addCheckbox:(NSString *) sText {
   //          -----------
   NSString *sValue = [NSString stringWithFormat:@"%@|", sText];
   
   if (![self contains:sValue]) {
      NSString *sNew = [self stringByAppendingString:sValue];
      return sNew;
   } else {
      return self;
   }
}

// -------------------------------------------------------------------------------------------------

- (NSString *) addRadiobutton:(NSString *) sText {
   //          --------------
   if (![self contains:sText]) {
      NSString *sNew = [self stringByAppendingString:sText];
      return sNew;
   } else {
      return self;
   }
}

// -------------------------------------------------------------------------------------------------

- (CGSize) drawLinesInRect:(CGRect) oRect
                  withFont:(UIFont *) oFont {
   //      ---------------
   CGSize oSize = CGSizeMake(oRect.size.width, 999);
   oSize = [self sizeWithFont:oFont
            constrainedToSize:oSize
                lineBreakMode:NSLineBreakByWordWrapping];
   oRect.size.height = oSize.height;
   
   [self drawInRect:oRect
           withFont:oFont
      lineBreakMode:NSLineBreakByWordWrapping
          alignment:NSTextAlignmentLeft];
   
   return oSize;
}

// -------------------------------------------------------------------------------------------------

- (void) drawLineInRect:(CGRect) oRect
               withFont:(UIFont *) oFont {
   //    --------------
   [self drawInRect:oRect
           withFont:oFont
      lineBreakMode:NSLineBreakByTruncatingTail];
}

// -------------------------------------------------------------------------------------------------

- (NSDate *) asDateAndTime {
   //        -------------
   // YYYY-MM-DD HH:MM -> Datum
   // Wed, 23 Feb 11 10:42:00 +0100
   // siehe http://unicode.org/reports/tr35/tr35-6.html#Date%5FFormat%5FPatterns
   if (self.empty) {
      return [NSDate nilDate];
   }
   
   static NSDateFormatter *oDateFormatter = nil;
   
   if (!oDateFormatter) {
      NSLocale *oLocale = [NSLocale new];
      oDateFormatter = [[NSDateFormatter alloc] init];
      oDateFormatter.locale = oLocale;
   }
   
   oDateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
   
   NSDate *dValue = [oDateFormatter dateFromString:self];
   
#if TARGET_IPHONE_SIMULATOR // #####################################################################
   if (dValue == nil)
      NSLog(@"ERROR: Date String invalid: %@", self);
#endif
   
   return dValue;
}

// -------------------------------------------------------------------------------------------------

- (NSDate *) asDate {
   //        ------
   // YYYY-MM-DD -> Datum
   // Wed, 23 Feb 11 10:42:00 +0100
   // siehe http://unicode.org/reports/tr35/tr35-6.html#Date%5FFormat%5FPatterns
   static NSDateFormatter *oDateFormatter = nil;
   
   if (!oDateFormatter) {
      oDateFormatter = [[NSDateFormatter alloc] init];
   }
   
   oDateFormatter.dateFormat = @"yyyy-MM-dd";
   
   NSDate *dValue = [oDateFormatter dateFromString:self];
   
#if TARGET_IPHONE_SIMULATOR // #####################################################################
   if (dValue == nil)
      NSLog(@"ERROR: Date String invalid: %@", self);
#endif
   
   return dValue;
}

// -------------------------------------------------------------------------------------------------

- (NSString *) asDateString {
   //          ------------
   // "2009-11-27" -> "27 November 2009"
   static NSDateFormatter *oDateFormatter = nil;
   
   if (!oDateFormatter) {
      NSLocale *oLocale = [NSLocale new];
      oDateFormatter = [[NSDateFormatter alloc] init];
      oDateFormatter.locale = oLocale;
      oDateFormatter.dateFormat = @"d MMMM yyyy";
   }
   
   NSString *sText = [oDateFormatter stringFromDate:[self asDate]];
   
   return sText;
}

// -------------------------------------------------------------------------------------------------

- (NSString *) asDateStringShort {
   //          -----------------
   // "2009-11-27" -> "27. Nov 2009"
   static NSDateFormatter *oDateFormatter = nil;
   
   if (!oDateFormatter) {
      NSLocale *oLocale = [NSLocale new];
      oDateFormatter = [[NSDateFormatter alloc] init];
      oDateFormatter.locale = oLocale;
      oDateFormatter.dateFormat = @"d MMM yyyy";
   }
   
   NSString *sText = [oDateFormatter stringFromDate:[self asDate]];
   
   return sText;
}

// -------------------------------------------------------------------------------------------------

- (NSString *) asDateDiffString {
   //          ----------------
   // "2009-11-27" -> "27 November 2009 (in 11 days)"
   static NSDateFormatter *oDateFormatter = nil;
   
   if (!oDateFormatter) {
      NSLocale *oLocale = [NSLocale new];
      oDateFormatter = [[NSDateFormatter alloc] init];
      oDateFormatter.locale = oLocale;
      oDateFormatter.dateFormat = @"EEEE, d. MMMM";
   }
   
   NSDate *dValue = [self asDate];
	NSDate *dNow = [NSDate date];
   float	nDiff = [dValue.minimum timeIntervalSinceDate:[dNow minimum]] / 24 / 60 / 60;
   NSString *sText, *sValue;
   
   if (nDiff <= -2.0) {
      sValue = [NSString stringWithFormat:@"vor %0.f Tagen", -nDiff];
      sText = [NSString stringWithFormat:@"%@ %@", [oDateFormatter stringFromDate:dValue], sValue];
   } else if (nDiff <= -1.0) {
      sText = [NSString stringWithFormat:@"%@ %@",
               [oDateFormatter stringFromDate:dValue], @"Gestern"];
   } else if (nDiff <= 0.0) {
      sText = [NSString stringWithFormat:@"%@ %@",
               [oDateFormatter stringFromDate:dValue], @"Heute"];
   } else if (nDiff <= 1.0) {
      sText = [NSString stringWithFormat:@"%@ %@",
               [oDateFormatter stringFromDate:dValue], @"Morgen"];
   } else {
      sValue = [NSString stringWithFormat:@"in %0.f Tagen", nDiff];
      sText = [NSString stringWithFormat:@"%@ %@", [oDateFormatter stringFromDate:dValue], sValue];
   }
   
   return sText;
}

// -------------------------------------------------------------------------------------------------

- (NSString *) asDateHeader {
   //          ------------
   // "2009-11-27 09" -> "Montag, 27.11. ab 10:00"
   static NSDateFormatter *oDateFormatter = nil;
   
   if (!oDateFormatter) {
      NSLocale *oLocale = [NSLocale new];
      oDateFormatter = [[NSDateFormatter alloc] init];
      oDateFormatter.locale = oLocale;
      oDateFormatter.dateFormat = @"EEEE, d.MM.";
   }
   
   NSDate *dValue = [[self stringByAppendingString:@":00"] asDate];
   NSString *sText = [oDateFormatter stringFromDate:dValue];
   
   return [NSString stringWithFormat:@"%@ ab %i:00", sText, [self lastTwoLettersAsInt]];
}

// -------------------------------------------------------------------------------------------------

- (NSString *) trim {
   //          ----
   return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

// -------------------------------------------------------------------------------------------------

- (NSString *) noWhiteSpace {
   //          ------------
   return [[self stringByReplacingOccurrencesOfString:@"\"\"" withString:@"\""]
           stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

// -------------------------------------------------------------------------------------------------

- (NSString *) sortString {
   //          ----------
   // Die max. ersten 20 Zeichen.
   NSString *sText = [[self uppercaseString] trim];
   
   if ([sText length] >= 20)
      return [sText substringToIndex:20];
   else
      return sText;
}

// -------------------------------------------------------------------------------------------------

- (BOOL) contains:(NSString *) sText {
   //    --------
   // [@"1,3,5,6,7,8,9,10," contains:@"3,"] -> true
   NSRange oRange = [self rangeOfString:sText];
   
   return (oRange.location != NSNotFound);
}

// -------------------------------------------------------------------------------------------------

- (NSString *) replace:(NSString *) sReplace
                  with:(NSString *) sWith {
   //          -------
   return [self stringByReplacingOccurrencesOfString:sReplace withString:sWith];
}

// -------------------------------------------------------------------------------------------------

- (NSString *) lastLetter {
   //          ----------
   int nLength = [self length];
   
   if (nLength > 0) {
      return [self substringFromIndex:nLength - 1];
   } else {
      return @"";
   }
}

// -------------------------------------------------------------------------------------------------

- (NSString *) lastTwoLetters {
   //          --------------
   int nLength = [self length];
   
   if (nLength > 1) {
      return [self substringFromIndex:nLength - 2];
   } else {
      return @"";
   }
}

// -------------------------------------------------------------------------------------------------

- (int) lastLetterAsInt {
   //   ---------------
   return [[self lastLetter] intValue];
}

// -------------------------------------------------------------------------------------------------

- (int) lastTwoLettersAsInt {
   //   -------------------
   return [[self lastTwoLetters] intValue];
}

// -------------------------------------------------------------------------------------------------

- (NSString *) removeCharacters:(int) nCount {
   //          ----------------
   int nLength = [self length];
   
   if (nLength > nCount) {
      return [self substringToIndex:nLength - nCount];
   } else {
      return @"";
   }
}

// -------------------------------------------------------------------------------------------------

- (BOOL) empty {
   //    -----
   return ([[self trim] length] == 0 || [self isEqualToString:@"(null)"]);
}

// -------------------------------------------------------------------------------------------------

- (NSString *) firstLetter {
   //          -----------
   NSString *sLetter;
   
   if ([self length] > 0) {
      sLetter = [self substringToIndex:1];
   } else {
      sLetter = @"";
   }
   
   return sLetter;
}

// -------------------------------------------------------------------------------------------------

- (NSString *) boldString {
   //          ----------
   // "Dies ist ein <b>Wort</b> etc." -> liefert "Wort"
   // "Dies ist ein Wort etc." -> liefert "Dies ist ein Wort etc."
   int nStart = [self rangeOfString:@"<b>"].location;
   int nEnd = [self rangeOfString:@"</b>"].location;
   
   if (nEnd > 0 && nStart < nEnd)
      return [self substringWithRange:NSMakeRange(nStart + 3, nEnd - nStart - 3)];
   else
      return self;
}

// -------------------------------------------------------------------------------------------------

- (NSString *) unformattedString {
   //          -----------------
   // "Dies ist ein <b>Wort</b> etc." -> liefert "Dies ist ein Wort etc."
   return [[self stringByReplacingOccurrencesOfString:@"<b>" withString:@""]
           stringByReplacingOccurrencesOfString:@"</b>" withString:@""];
}

// -------------------------------------------------------------------------------------------------

- (NSString *) reverse {
   //          -------
   // String umdrehen
   int nLength = [self length];
   NSMutableString *sReverse = [[NSMutableString alloc] initWithCapacity:nLength];
   
   for (int i = nLength; i > 0; i--) {
      [sReverse appendString:[self substringWithRange:NSMakeRange(i - 1, 1)]];
   }
   
   NSString *sReturn = [NSString stringWithString:sReverse];
   
   return sReturn;
}

// -------------------------------------------------------------------------------------------------

- (NSString *) fillWith:(NSString *) sFill
               toLength:(int) nLength {
   //          --------
   // String links auffüllen mit sFill auf nLength Stellen
   NSMutableString *sFilled = [[NSMutableString alloc] initWithString:self];
   int nStart = [self length];
   
   for (int i = nStart; i < nLength; i++) {
      [sFilled insertString:sFill atIndex:0];
   }
   
   NSString *sReturn = [NSString stringWithString:sFilled];
   
   return sReturn;
}

// -------------------------------------------------------------------------------------------------

- (int) ordAtIndex:(int) nPos {
   //   ----------
   unichar cChar = [self characterAtIndex:nPos];
   int nOrd = (int)cChar;
   
   return nOrd;
}

// -------------------------------------------------------------------------------------------------

+ (NSString *) fileFromBundle:(NSString *) sFile {
   //          --------------
   NSString *sPath = [[NSBundle mainBundle] bundlePath];
   NSString *sFileWithPath = [sPath stringByAppendingPathComponent:sFile];
   
   return sFileWithPath;
}

// -------------------------------------------------------------------------------------------------

+ (NSString *) fileFromDocuments:(NSString *) sFile {
   //          -----------------
   NSString *sPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
   NSString *sFileWithPath = [sPath stringByAppendingPathComponent:sFile];
   
   return sFileWithPath;
}

// -------------------------------------------------------------------------------------------------

@end
