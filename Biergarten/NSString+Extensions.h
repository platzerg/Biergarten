//
//  NSString+Extensions.h
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

@interface NSString (Extensions)

// -------------------------------------------------------------------------------------------------

typedef enum {
   NSTruncateStart,
   NSTruncateMiddle,
   NSTruncateEnd
}  Truncate;

// -------------------------------------------------------------------------------------------------

+ (NSString *) loremIpsumWithLength:(int) nLength;
+ (NSString *) loremIpsumWithMaxLength:(int) nLength;
+ (NSString *) loremIpsumWithWords:(int) nCount;
+ (NSString *) loremIpsumWithMaxWords:(int) nCount;
- (NSString *) randomHtmlFormat;

- (NSString *)substringFrom:(int) nFrom
                         to:(int) nTo;
- (int) indexOf:(NSString *) substring
           from:(int) nFrom;
- (NSString *) stringFromMD5;
- (NSString *) removeString:(NSString *) sValue;
- (NSString *) removeStrings:(NSString *) sValue;
- (BOOL) equalToString:(NSString *) sValue;
- (BOOL) notEqualToString:(NSString *) sValue;
- (BOOL) lowerToString:(NSString *) sValue;
- (BOOL) lowerEqualToString:(NSString *) sValue;
- (BOOL) greaterToString:(NSString *) sValue;
- (BOOL) greaterEqualToString:(NSString *) sValue;
- (NSString *) phoneNumber;
- (NSString *) streetWithoutNumber;
- (NSString *) repeat:(int) nRepeat;
- (NSString *) removeCheckbox:(NSString *) sText;
- (NSString *) addCheckbox:(NSString *) sText;
- (NSString *) addRadiobutton:(NSString *) sText;
- (CGSize) drawLinesInRect:(CGRect) oRect withFont:(UIFont *) oFont;
- (void) drawLineInRect:(CGRect) oRect withFont:(UIFont *) oFont;
- (NSDate *) asDateAndTime;
- (NSDate *) asDate;
- (NSString *) asDateString;
- (NSString *) asDateStringShort;
- (NSString *) asDateDiffString;
- (NSString *) asDateHeader;
- (NSString *) trim;
- (NSString *) noWhiteSpace;
- (NSString *) sortString;
- (BOOL) contains:(NSString *) sText;
- (NSString *) replace:(NSString *) sReplace
                  with:(NSString *) sWith;
- (NSString *) lastLetter;
- (NSString *) lastTwoLetters;
- (int) lastLetterAsInt;
- (int) lastTwoLettersAsInt;
- (NSString *) removeCharacters:(int) nCount;
- (BOOL) empty;
- (NSString *) firstLetter;
- (NSString *) boldString;
- (NSString *) unformattedString;
- (NSString *) reverse;
- (NSString *) fillWith:(NSString *) sFill
               toLength:(int) nLength;
- (int) ordAtIndex:(int) nPos;
+ (NSString *) fileFromBundle:(NSString *) sFile;
+ (NSString *) fileFromDocuments:(NSString *) sFile;

// -------------------------------------------------------------------------------------------------

@end
