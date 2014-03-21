//
//  AttributedStringParser.h
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

#import <CoreText/CoreText.h>
#import "AttributedStringParser.h"

@interface AttributedStringParser ()
   //      ----------------------
@property (nonatomic) NSMutableDictionary *attributes;
@property (nonatomic) NSMutableAttributedString *attributedText;

@end

@implementation AttributedStringParser

// -------------------------------------------------------------------------------------------------

+ (NSAttributedString *) attributedStringFromText:(NSString *) sText
                                             font:(UIFont *) oFont
                                  backgroundColor:(UIColor *) oBackgroundColor
                                        textColor:(UIColor *) oTextColor {
   //                    ------------------------
   AttributedStringParser *oParser = [[AttributedStringParser alloc] initWithText:sText
                                                                             font:oFont
                                                                  backgroundColor:oBackgroundColor
                                                                        textColor:oTextColor];
   return [oParser parse];
}

// -------------------------------------------------------------------------------------------------

+ (NSAttributedString *) attributedStringFromText:(NSString *) sText
                                             font:(UIFont *) oFont
                                        textColor:(UIColor *) oTextColor {
   //                    ------------------------
   return [AttributedStringParser attributedStringFromText:sText
                                                      font:oFont
                                           backgroundColor:nil
                                                 textColor:oTextColor];
}

// -------------------------------------------------------------------------------------------------

+ (NSAttributedString *) attributedStringFromText:(NSString *) sText
                                             font:(UIFont *) oFont {
   //                    ------------------------
   return [AttributedStringParser attributedStringFromText:sText
                                                      font:oFont
                                           backgroundColor:nil
                                                 textColor:nil];
}

// -------------------------------------------------------------------------------------------------

- (instancetype)   initWithText:(NSString *) sText
                           font:(UIFont *) oFont
                backgroundColor:(UIColor *) oBackgroundColor
                      textColor:(UIColor *) oTextColor {
   //           ---------------
   self = [super init];
   
   if (self) {
      self.font = oFont;
      self.backgroundColor = oBackgroundColor ?: [UIColor whiteColor];
      self.textColor = oTextColor ?: [UIColor blackColor];
   
      // Basis-Attribute
      NSDictionary *oAttributes = @{NSForegroundColorAttributeName:self.textColor,
                                    NSFontAttributeName:self.font};
      self.attributedText = [[NSMutableAttributedString alloc] initWithString:sText
                                                                   attributes:oAttributes];
   }
   
   return self;
}

// -------------------------------------------------------------------------------------------------

- (NSAttributedString *) parse {
   //                    -----
   // NSDate *x = [NSDate date];
   NSString *sText = self.attributedText.string;
   
   if ([sText contains:@"--"]) {
      [self replaceRegEx:@"(-{2})(.+?)(-{2})"
          withAttributes:@{NSFontAttributeName:self.attributes[@"tiny"]}];
   }
   
   if ([sText contains:@"<<"]) {
      [self replaceRegEx:@"(<{2})(.+?)(<{2})"
          withAttributes:@{NSFontAttributeName:self.attributes[@"small"],
                           NSForegroundColorAttributeName:[UIColor redColor]}];
   }
   
   if ([sText contains:@"**"]) {
      [self replaceRegEx:@"(\\*{2})(.+?)(\\*{2})"
          withAttributes:@{NSFontAttributeName:self.attributes[@"bold"]}];
   }
   
   if ([sText contains:@"//"]) {
      [self replaceRegEx:@"(/{2})(.+?)(/{2})"
          withAttributes:@{NSFontAttributeName:self.attributes[@"italic"]}];
   }
      
   if ([sText contains:@"__"]) {
      [self replaceRegEx:@"(_{2})(.+?)(_{2})"
          withAttributes:@{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle)}];
   }

   if ([sText contains:@"||"]) {
      [self replaceRegEx:@"(\\|{2})(.+?)(\\|{2})"
          withAttributes:@{NSBackgroundColorAttributeName:self.textColor,
                           NSForegroundColorAttributeName:self.backgroundColor}];
   }

   if ([sText contains:@"''"]) {
      [self replaceRegEx:@"('{2})(.+?)('{2})"
          withAttributes:@{NSFontAttributeName:self.attributes[@"monospace"]}];
   }
   
   if ([sText contains:@">>"]) {
      [self replaceRegEx:@"(>{2})(.+?)(>{2})"
          withAttributes:@{NSFontAttributeName:self.attributes[@"big"]}];
      //NSForegroundColorAttributeName:[Setup sharedSetup].tintColor}];
      //NSStrokeWidthAttributeName:@3.0}];
   }
   
   /*
   if ([sText contains:@"[[shift]]"]) {
      [self replaceRegEx:@"(\\[{2}shift\\]{2})"
          withAttributes:@{NSFontAttributeName:self.attributes[@"keycaps"]} // shift
                andValue:@":"];
   }

   if ([sText contains:@"[[ctrl]]"]) {
      [self replaceRegEx:@"(\\[{2}ctrl\\]{2})"
          withAttributes:@{NSFontAttributeName:self.attributes[@"keycaps"]} // ctrl
                andValue:@"D"];
   }

   if ([sText contains:@"[[alt]]"]) {
      [self replaceRegEx:@"(\\[{2}alt\\]{2})"
          withAttributes:@{NSFontAttributeName:self.attributes[@"keycaps"]} // alt
                andValue:@"K"];
   }

   if ([sText contains:@"[[cmd]]"]) {
      [self replaceRegEx:@"(\\[{2}cmd\\]{2})"
          withAttributes:@{NSFontAttributeName:self.attributes[@"keycaps"]} // cmd
                andValue:@"B"];
   }
   
   if ([sText contains:@"[[foo]]"]) {
      [self replaceRegEx:@"(\\[{2}foo\\]{2})"
          withAttributes:@{NSFontAttributeName:self.attributes[@"keycaps"],
                           NSForegroundColorAttributeName:self.backgroundColor} // foo
                andValue:@"    "];
   }
   
   if ([sText contains:@"[["]) {
      [self replaceRegEx:@"(\\[{2})(.+?)(\\]{2})"
          withAttributes:@{NSFontAttributeName:self.attributes[@"keycaps"]}];
   }
   */

   // NSLog(@"%@", [self.attributedText attributedSubstringFromRange:
   //    NSMakeRange(0, [self.attributedText length])]);
   
   // NSLog(@"%f", [x timeIntervalSinceNow]);
   
   return self.attributedText;
}

// -------------------------------------------------------------------------------------------------

- (void)   replaceRegEx:(NSString *) sRegEx
         withAttributes:(NSDictionary *) oAttributes
               andValue:(NSString *) sValue {
   //    --------------
   NSRegularExpression *oRegex = [NSRegularExpression regularExpressionWithPattern:sRegEx
                                                                           options:0
                                                                             error:nil];
   __block int nPos = 0;
   NSString *sResult = [self.attributedText.string copy];
   
   [oRegex enumerateMatchesInString:sResult
                            options:0
                              range:(NSRange){0, [sResult length]}
                         usingBlock:
    ^(NSTextCheckingResult *oMatches, NSMatchingFlags nFlags, BOOL *bStop) {
       for (NSUInteger i = 0; i < oMatches.numberOfRanges - 1; i++) {
          NSRange oRange = [oMatches rangeAtIndex:i + 1];
          oRange.location -= nPos;
          // NSLog(@"vorher %i, %@, %@, %i, %i", i, self.attributedText.string, oAttributes,
          //       oRange.location, oRange.length);
          
          if (i == 1) {     // ">>Titel>>" -> Content-Text "Titel" mit "title"-Attribut versehen
             [self.attributedText addAttributes:oAttributes range:oRange];
             
          } else {          // ">>Titel>>" -> Attribut-Tag ">>" löschen
             nPos += oRange.length;
             [self.attributedText deleteCharactersInRange:oRange];
             
             if (sValue) {
                NSAttributedString *sInsert = [[NSAttributedString alloc] initWithString:sValue
                                                                              attributes:oAttributes];
                [self.attributedText insertAttributedString:sInsert atIndex:oRange.location];
                nPos -= [sInsert length];
             }
          }
          
          // NSLog(@"nachher %i, %@, %@, %i, %i", i, self.attributedText.string, oAttributes,
          //       oRange.location, oRange.length);
       }
    }];
}

// -------------------------------------------------------------------------------------------------

- (void)   replaceRegEx:(NSString *) sRegEx
         withAttributes:(NSDictionary *) oAttributes {
   //    --------------
   [self replaceRegEx:sRegEx withAttributes:oAttributes andValue:nil];
}

// -------------------------------------------------------------------------------------------------

- (void) setFont:(UIFont *) oFont {
   //    -------
   _font = oFont;

   static NSMutableDictionary *oAttributes;
   static NSUInteger nFontSize;
   
   if (!oAttributes || nFontSize != [Setup sharedSetup].fontSize || [Setup sharedSetup].fontRefresh) {
      nFontSize = [Setup sharedSetup].fontSize;
      oAttributes = [[NSMutableDictionary alloc] init];
      
      // Base Font
      CGFloat nSize = oFont.pointSize;
      NSString *sNormalFont = oFont.fontName;
      CFStringRef sName = (__bridge CFStringRef)sNormalFont;
      CTFontRef refBaseFont = CTFontCreateWithName(sName, nSize, NULL);
      oAttributes[@"big"] = [UIFont fontWithName:sNormalFont size:(int)(nSize * 1.2)] ?: oFont;
      oAttributes[@"small"] = [UIFont fontWithName:sNormalFont size:(int)(nSize * 0.8)] ?: oFont;
      oAttributes[@"tiny"] = [UIFont fontWithName:sNormalFont size:(int)(nSize * 0.4)] ?: oFont;

      // Bold Font
      CTFontRef refBoldFont =
      CTFontCreateCopyWithSymbolicTraits(refBaseFont, 0, NULL, kCTFontBoldTrait, kCTFontBoldTrait);
      NSString *sBoldFont = (__bridge NSString *)CTFontCopyName(refBoldFont, kCTFontPostScriptNameKey);
      oAttributes[@"bold"] = [UIFont fontWithName:sBoldFont size:nSize] ?: oFont;

      // Italic Font
      CTFontRef refItalicFont =
      CTFontCreateCopyWithSymbolicTraits(refBaseFont, 0, NULL, kCTFontItalicTrait, kCTFontItalicTrait);
      NSString *sItalicFont = (__bridge NSString *)CTFontCopyName(refItalicFont, kCTFontPostScriptNameKey);
      oAttributes[@"italic"] = [UIFont fontWithName:sItalicFont size:nSize] ?: oFont;

      // Liefert "HelveticaNeue" -> "HelveticaNeue-Italic" und "HelveticaNeue-Bold"
      // Liefert für "TimesNewRomanPSMT" -> "TimesNewRomanPS-ItalicMT, "TimesNewRomanPS-BoldMT"
      // NSLog(@"%@, %@", sItalicFont, sBoldFont);

      // Monospace Font
      oAttributes[@"monospace"] = [UIFont fontWithName:@"Courier" size:nSize];
      
      // Keycaps Font
      // oAttributes[@"keycaps"] = [UIFont fontWithName:@"MacKeyCaps" size:nSize];
   }
   
   self.attributes = oAttributes;
}

// -------------------------------------------------------------------------------------------------

@end
