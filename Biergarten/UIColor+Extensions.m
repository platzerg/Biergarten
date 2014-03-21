//
//  UIColor+Extensions.h
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

@implementation UIColor (Extensions)

// -------------------------------------------------------------------------------------------------

- (float) red {
   //     ---
   const CGFloat *aColor = CGColorGetComponents(self.CGColor);
   return aColor[0];
}

// -------------------------------------------------------------------------------------------------

- (float) green {
   //     -----
   const CGFloat *aColor = CGColorGetComponents(self.CGColor);
   return aColor[1];
}

// -------------------------------------------------------------------------------------------------

- (float) blue {
   //     ----
   const CGFloat *aColor = CGColorGetComponents(self.CGColor);
   return aColor[2];
}

// -------------------------------------------------------------------------------------------------

- (float) alpha {
   //     -----
   return CGColorGetAlpha(self.CGColor);
}

// -------------------------------------------------------------------------------------------------

- (NSString *) cacheKey {
   //          --------
   NSString *sKey = [NSString stringWithFormat:@"%.3f,%.3f,%.3f,%.3f",
                     [self red], [self green], [self blue], [self alpha]];
   return sKey;
}

// -------------------------------------------------------------------------------------------------

+ (UIColor *) colorWithRed:(int) nRed 
                     green:(int) nGreen 
                      blue:(int) nBlue {
   //         ------------
   return [UIColor colorWithRed:nRed / 255.0f
                          green:nGreen / 255.0f
                           blue:nBlue / 255.0f
                          alpha:1.0f];
}

// -------------------------------------------------------------------------------------------------

+ (UIColor *) randomColor {
   //         -----------
   float nRed = arc4random() % 255;
   float nGreen = arc4random() % 255;
   float nBlue = arc4random() % 255;
   
   return [UIColor colorWithRed:nRed
                          green:nGreen
                           blue:nBlue];
}

// -------------------------------------------------------------------------------------------------

@end