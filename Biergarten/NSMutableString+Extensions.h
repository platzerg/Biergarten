//
//  NSMutableString.h
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

@interface NSMutableString (Extensions)

// -------------------------------------------------------------------------------------------------

- (void) appendAndString:(NSString *) sFormat;
- (void) appendAndFormat:(NSString *) sFormat, ...;
- (void) appendOrString:(NSString *) sFormat;
- (void) appendOrFormat:(NSString *) sFormat, ...;
- (void) removeFirstCharacters:(int) nLength;
- (void) removeLastCharacters:(int) nLength;
- (void) appendItem:(NSString *) sItem;
- (void) appendLabel:(NSString *) sLabel
        withProperty:(NSString *) sProperty;
- (void) appendImage:(NSData *) oImage;
- (void) appendSingleSpacing;
- (void) appendDoubleSpacing;
- (void) appendLine;
- (void) appendFullLine;
- (void) appendLabelLine;
- (void) appendValueLine;

// -------------------------------------------------------------------------------------------------

@end
