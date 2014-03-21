//
//  Setup.m
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

#import "Setup.h"

@implementation Setup

// =================================================================================================
#pragma mark - Singleton methods
// =================================================================================================

+ (Setup *) sharedSetup {
   //       -----------
   // Singleton
   static Setup *oSetup = nil;
   static dispatch_once_t predicate;
   
   dispatch_once(&predicate, ^{
      oSetup = [[Setup alloc] init];
   });
   
   return oSetup;
}

// =================================================================================================
#pragma mark - UserDefaults methods
// =================================================================================================

- (void) loadFromUserDefaults {
   //    --------------------
   // User-Setup-Werte einlesen
   NSUserDefaults *oUserDefaults = [NSUserDefaults standardUserDefaults];
   NSString *sLanguage = [oUserDefaults objectForKey:@"language"];
   
   if (sLanguage) {
      self.language = sLanguage;
      
   } else {
      NSLocale *oLocale = [NSLocale currentLocale];
      NSString *sIdentifier = [oLocale localeIdentifier];
      // NSString *sDisplayName = [oLocale displayNameForKey:NSLocaleIdentifier
      //                                               value:sIdentifier];
      // NSLog(@"%@, %@", sIdentifier, sDisplayName);
      
      if ([sIdentifier length] > 1) {
         self.language = [sIdentifier substringToIndex:2];
      } else {
         self.language = @"en";
      }
   }
   
   self.enableLeftMenu = [oUserDefaults boolForKey:@"enableLeftMenu"];
   self.enablePresenter = [oUserDefaults boolForKey:@"enablePresenter"];
   self.fontSize = [oUserDefaults integerForKey:@"fontSize"];
   self.fontName = [oUserDefaults objectForKey:@"fontName"];
}

// -------------------------------------------------------------------------------------------------

- (void) setLanguage:(NSString *) sLanguage {
   //    -----------
   // Erlaubt das Auslesen lokalisierter Localizable.strings auch OHNE Umschalten der Sprache
   // in den Einstellungen! Siehe auch ls() in HR-Prefix.pch. sLanguage ist @"de", @"en" etc.
   _language = sLanguage;
   
   NSString *sPath = [[NSBundle mainBundle] pathForResource:sLanguage
                                                     ofType:@"lproj"];
   self.bundle = [NSBundle bundleWithPath:sPath];
}

// -------------------------------------------------------------------------------------------------

- (void) saveToUserDefaults {
   //    ------------------
   // User-Setup-Werte wegschreiben
   NSUserDefaults *oUserDefaults = [NSUserDefaults standardUserDefaults];
   
   [oUserDefaults setObject:self.language forKey:@"language"];
   [oUserDefaults setBool:self.enableLeftMenu forKey:@"enableLeftMenu"];
   [oUserDefaults setBool:self.enablePresenter forKey:@"enablePresenter"];
   [oUserDefaults setInteger:self.fontSize forKey:@"fontSize"];
   [oUserDefaults setObject:self.fontName forKey:@"fontName"];
}

// =================================================================================================
#pragma mark - Constructor methods
// =================================================================================================

- (instancetype) init {
   //            ----
   self = [super init];
   
   self.fontSize = -1;
   self.selectedColor = [UIColor colorWithWhite:0.8 alpha:1.0];
   self.tintColor = [UIColor colorWithRed:242 green:147 blue:8];
   self.tagColor = [UIColor colorWithWhite:0.9 alpha:1.0];
   self.appId = @"645750840";
   self.appStore = @"http://itunes.apple.com/us/app/lempertz/id645750840?l=de&ls=1&mt=8";
   self.email = @"";
   self.webPath = @"http://www.ivo-wessel.de/os_x_produktiv/";
   self.enableLeftMenu = false;
   self.enablePresenter = false;
   
   // [self loadFromUserDefaults];
   [self loadFont];
   
   return self;
}

// -------------------------------------------------------------------------------------------------

- (void) loadFont {
   //    --------
   if (!self.fontName) {
      self.fontName = @"Helvetica";
   }

   NSString *sFont, *sFontBold;

   if ([self.fontName isEqualToString:@"Avenir"]) {
      sFont = @"AvenirNext-Regular";
      sFontBold = @"AvenirNext-Bold";
   } else if ([self.fontName isEqualToString:@"Baskerville"]) {
      sFont = @"Baskerville";
      sFontBold = @"Baskerville-Bold";
   } else if ([self.fontName isEqualToString:@"Bodoni"]) {
      sFont = @"BodoniSvtyTwoOSITCTT-Book";
      sFontBold = @"BodoniSvtyTwoOSITCTT-Bold";
   } else if ([self.fontName isEqualToString:@"Georgia"]) {
      sFont = @"Georgia";
      sFontBold = @"Georgia-Bold";
   } else if ([self.fontName isEqualToString:@"Gill"]) {
      sFont = @"GillSans";
      sFontBold = @"GillSans-Bold";
   } else if ([self.fontName isEqualToString:@"Helvetica"]) {
      sFont = @"HelveticaNeue";
      sFontBold = @"HelveticaNeue-Bold";
   } else if ([self.fontName isEqualToString:@"Hoefler"]) {
      sFont = @"HoeflerText-Regular";
      sFontBold = @"HoeflerText-Black";
   } else if ([self.fontName isEqualToString:@"Optima"]) {
      sFont = @"Optima-Regular";
      sFontBold = @"Optima-Bold";
   } else if ([self.fontName isEqualToString:@"Palatino"]) {
      sFont = @"Palatino-Roman";
      sFontBold = @"Palatino-Bold";
   } else if ([self.fontName isEqualToString:@"Times"]) {
      sFont = @"TimesNewRomanPSMT";
      sFontBold = @"TimesNewRomanPS-BoldMT";
   } else if ([self.fontName isEqualToString:@"Trebuchet"]) {
      sFont = @"TrebuchetMS";
      sFontBold = @"TrebuchetMS-Bold";
   } else if ([self.fontName isEqualToString:@"Verdana"]) {
      sFont = @"Verdana";
      sFontBold = @"Verdana-Bold";
   }

   self.normalFont = [UIFont fontWithName:sFont size:17];
   self.boldFont = [UIFont fontWithName:sFontBold size:17];
   
   if (!self.normalFont || !self.boldFont) {
      NSLog(@"Font %@ oder %@ unbekannt", sFont, sFontBold);
      
      sFont = @"HelveticaNeue";
      sFontBold = @"HelveticaNeue-Bold";
      
      self.normalFont = [UIFont fontWithName:sFont size:17];
      self.boldFont = [UIFont fontWithName:sFontBold size:17];
   }
   
   self.smallFont = [UIFont fontWithName:sFont size:15];
   self.iconFont = [UIFont fontWithName:sFont size:13];
   self.largeFont = [UIFont fontWithName:sFont size:21];
   self.fontRefresh = true;
   
   [[UINavigationBar appearance] setTitleTextAttributes:
    @{NSFontAttributeName: self.largeFont,
      NSForegroundColorAttributeName: [UIColor whiteColor]}];
}

// -------------------------------------------------------------------------------------------------

- (NSInteger) fontSizeInPoints {
   //         ----------------
   int nSize = 17;
   
   switch (self.fontSize) {
      case -1:
         nSize = 14;
         break;
      case 0:
         nSize = 17;
         break;
      case 1:
         nSize = 20;
         break;
   }
   
   return ([UIDevice isPad] ? nSize : nSize - 2);
}

// -------------------------------------------------------------------------------------------------

- (UIFont *) textFont {
   //        --------
   // return (self.enableSmallFont ? self.smallFont : self.normalFont);
   UIFont *oFont = [UIFont fontWithName:self.normalFont.fontName
                                   size:self.fontSizeInPoints];
   return oFont;
}

// -------------------------------------------------------------------------------------------------

- (UIFont *) textBoldFont {
   //        ------------
   // return (self.enableSmallFont ? self.smallFont : self.normalFont);
   UIFont *oFont = [UIFont fontWithName:self.boldFont.fontName
                                   size:self.fontSizeInPoints * 1.2];
   return oFont;
}

// -------------------------------------------------------------------------------------------------

- (UIFont *) tagFont {
   //        --------
   return (self.fontSize < 0 ? self.iconFont : self.smallFont);
}

// -------------------------------------------------------------------------------------------------

@end
