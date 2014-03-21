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

#import "NSMutableString+Extensions.h"

@implementation NSMutableString (Extensions)

// -------------------------------------------------------------------------------------------------

- (void) appendAndString:(NSString *) sText {
   //    ---------------
   if (![self empty] && ![self hasSuffix:@" && "]) {
      [self appendString:@" && "];
   }
   
   [self appendString:sText];
}

// -------------------------------------------------------------------------------------------------

- (void) appendAndFormat:(NSString *) sFormat, ... {
   //    ---------------
   if (![self empty] && ![self hasSuffix:@" && "]) {
      [self appendString:@" && "];
   }
   
   va_list x;
   va_start(x, sFormat);
   
   NSString *sText = [[NSString alloc] initWithFormat:sFormat arguments:x];
   
   va_end(x);
   
   [self appendString:sText];
}

// -------------------------------------------------------------------------------------------------

- (void) appendOrString:(NSString *) sText {
   //    --------------
   if (![self empty] && ![self hasSuffix:@" || "]) {
      [self appendString:@" || "];
   }
   
   [self appendString:sText];
}

// -------------------------------------------------------------------------------------------------

- (void) appendOrFormat:(NSString *) sFormat, ... {
   //    --------------
   if (![self empty] && ![self hasSuffix:@" || "]) {
      [self appendString:@" || "];
   }
   
   va_list x;
   va_start(x, sFormat);
   
   NSString *sText = [[NSString alloc] initWithFormat:sFormat arguments:x];
   
   va_end(x);
   
   [self appendString:sText];
}

// -------------------------------------------------------------------------------------------------

- (void) removeFirstCharacters:(int) nLength {
   //    ---------------------
   if ([self length] > nLength) {
      [self deleteCharactersInRange:NSMakeRange(0, nLength)];
   }
}

// -------------------------------------------------------------------------------------------------

- (void) removeLastCharacters:(int) nLength {
   //    --------------------
   if ([self length] > nLength) {
      [self deleteCharactersInRange:NSMakeRange([self length] - nLength, nLength)];
   }
}

// =================================================================================================
#pragma mark -
#pragma mark Item methods
// =================================================================================================

- (void) appendItem:(NSString *) sItem {
   //    ----------
   if ([sItem hasSuffix:@"|"]) {
      [self appendString:sItem];
   } else {
      [self appendFormat:@"%@|", sItem];
   }
}

// -------------------------------------------------------------------------------------------------

- (void) appendLabel:(NSString *) sLabel
        withProperty:(NSString *) sProperty {
   //   ------------
   [self appendItem:[NSString stringWithFormat:@"%@,%@", sLabel, sProperty]];
}

// -------------------------------------------------------------------------------------------------

- (void) appendImage:(NSData *) oImage {
   //   ------------
   [self appendItem:@"**"];
   self.bag = oImage;
}

// -------------------------------------------------------------------------------------------------

- (void) appendSingleSpacing {
   //    -------------------
   [self appendItem:@"-"];
}

// -------------------------------------------------------------------------------------------------

- (void) appendDoubleSpacing {
   //    -------------------
   [self appendItem:@"="];
}

// -------------------------------------------------------------------------------------------------

- (void) appendLine {
   //    ----------
   [self appendItem:@"_"];
}

// -------------------------------------------------------------------------------------------------

- (void) appendFullLine {
   //    --------------
   [self appendItem:@"__"];
}

// -------------------------------------------------------------------------------------------------

- (void) appendLabelLine {
   //    ---------------
   [self appendItem:@"_,"];
}

// -------------------------------------------------------------------------------------------------

- (void) appendValueLine {
   //    ---------------
   [self appendItem:@",_"];
}

// -------------------------------------------------------------------------------------------------
   
@end
