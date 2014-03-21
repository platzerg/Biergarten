//
//  UIView+Extensions.h
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

@interface UIImage (Extensions) 

// -------------------------------------------------------------------------------------------------

+ (int) cachedColumns;
+ (UIImage *) setCachedImage:(UIImage *) oImage
                      forKey:(NSString *) sKey;
+ (UIImage *) cachedImageForKey:(NSString *) sKey;
+ (UIImage *) mergeBundleImagesOfSize:(CGSize) oSize
                              columns:(NSUInteger) nColumns
                               retina:(BOOL) bRetina;
+ (UIImage *) mergeBundleImagesOfSize:(CGSize) oSize
                               retina:(BOOL) bRetina;
- (void) splitIntoImagesOfSize:(CGSize) oSize
                        retina:(BOOL) bRetina
                        format:(NSString *) sFormat;
- (UIImage *) imageAtColumn:(NSUInteger) nColumn
                     andRow:(NSUInteger) nRow
                     ofSize:(CGSize) oSize;
+ (UIImage *) imageAtColumn:(NSUInteger) nColumn
                     andRow:(NSUInteger) nRow
                  fromImage:(NSString *) sImage
                     ofSize:(CGSize) oSize;
+ (UIImage *) imageAtColumn:(NSUInteger) nColumn
                     andRow:(NSUInteger) nRow;
+ (UIImage *) imageAtPosition:(NSUInteger) nPosition;
- (void) writeToDocumentsDirectory:(NSString *) sImage;

+ (UIImage *) imageNamed:(NSString *) sName 
               withColor:(UIColor *) oColor;
- (UIImage *) imageWithColor:(UIColor *) oColor;
- (UIImage *) randomImageOfSize:(CGSize) oSize;
- (UIImage *) imageOfSize:(CGSize) oSize;
- (UIImage *) imageRotatedByDegrees:(CGFloat) nDegrees;
+ (UIImage *) imageFromBundle:(NSString *) sFile;
+ (UIImage *) imageFromPDF:(NSURL *) oURL
                  withSize:(CGSize ) oSize;
+ (UIImage *) imageOfColor:(UIColor *) oColor;

// -------------------------------------------------------------------------------------------------

@end
