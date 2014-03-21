//
//  UIView+Extensions.m
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

#import <ImageIO/ImageIO.h> // Erfordert ImageIO-Framework!
#import "UIImage+Extensions.h"

@implementation UIImage (Extensions)

// =================================================================================================
#pragma mark - Cached Icon methods
// =================================================================================================

+ (int) cachedColumns {
   //   -------------
   return 20;
}

// -------------------------------------------------------------------------------------------------

+ (CGSize) imageSize {
   //      ---------
   float nScale = [UIScreen mainScreen].scale;
   return CGSizeMake(24 * nScale, 24 * nScale);
}

// -------------------------------------------------------------------------------------------------

+ (NSString *) fileName {
   //          --------
   float nScale = [UIScreen mainScreen].scale;
   NSString *sImage = (nScale == 1.0 ? @"Glyphs" : @"Glyphs@2x");
   
   return sImage;
}

// -------------------------------------------------------------------------------------------------

+ (CGSize) sizeOfImage:(NSString *) sPath {
   //      -----------
   float nWidth = 0;
   float nHeight = 0;
   NSURL *oURL = [NSURL fileURLWithPath:sPath];
   CGImageSourceRef oSource =
   CGImageSourceCreateWithURL((__bridge CFURLRef)oURL, NULL);
   
   if (oSource) {
      CFDictionaryRef oProperties = CGImageSourceCopyPropertiesAtIndex(oSource, 0, NULL);
      
      if (oProperties) {
         CFNumberRef oWidth  = CFDictionaryGetValue(oProperties, kCGImagePropertyPixelWidth);
         CFNumberGetValue(oWidth, kCFNumberFloatType, &nWidth);
         
         CFNumberRef oHeight = CFDictionaryGetValue(oProperties, kCGImagePropertyPixelHeight);
         CFNumberGetValue(oHeight, kCFNumberFloatType, &nHeight);
         
         CFRelease(oProperties);
      }
   }
   
   return CGSizeMake(nWidth, nHeight);
   // return [[UIImage alloc] initWithContentsOfFile:sPath].size;
}

// -------------------------------------------------------------------------------------------------

+ (UIImage *) setCachedImage:(UIImage *) oImage
                      forKey:(NSString *) sKey {
   //         --------------
   static NSCache *oCache;
   // static int nCount = 0;
   
   if (!oCache) {
      oCache = [[NSCache alloc] init];
   }
   
   if (oImage) {
      [oCache setObject:oImage
                 forKey:sKey];
      // NSLog(@"%@. %i Images in Cache", sKey, ++nCount);
   } else {
      oImage = [oCache objectForKey:sKey];
   }
   
   return oImage;
}

// -------------------------------------------------------------------------------------------------

+ (UIImage *) cachedImageForKey:(NSString *) sKey {
   //         -----------------
   return [UIImage setCachedImage:nil
                           forKey:sKey];
}

// -------------------------------------------------------------------------------------------------

+ (NSArray *) imagesFromBundleOfSize:(CGSize) oSize
                              retina:(BOOL) bRetina {
   //         ----------------------
   // Liefert alle oSize großen Bitmaps aus dem Bundle. @2x ist von bRetina abhängig. Sortiert
   // nach Name.
   NSMutableArray *aImage = [[NSMutableArray alloc] init];
   NSString *sPath = [[NSBundle mainBundle] bundlePath];
   NSError *oError = nil;
   NSArray *aFile = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:sPath
                                                                        error:&oError];
   float nWidth = (bRetina ? oSize.width * 2 : oSize.width);
   float nHeight = (bRetina ? oSize.height * 2 : oSize.height);
   
   for (NSString *sFile in aFile) {
      if ([sFile hasSuffix:@".png"]) {
         CGSize oFileSize = [UIImage sizeOfImage:[sPath stringByAppendingPathComponent:sFile]];
         
         // if (CGSizeEqualToSize(oFileSize, oSize)) {
         if (oFileSize.width == nWidth && oFileSize.height == nHeight) {
            [aImage addObject:sFile];
         }
      }
   }
   
   return [aImage sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

// -------------------------------------------------------------------------------------------------

+ (UIImage *) mergeBundleImagesOfSize:(CGSize) oSize
                              columns:(NSUInteger) nColumns
                               retina:(BOOL) bRetina {
   //         -----------------------
   // Fügt alle oSize großen Bitmaps zu einer großen Bitmap zusammen. @2x ist von bRetina abhängig.
   // Sortierung nach Name.
   // float nScale = [UIScreen mainScreen].scale;
   float nScale = bRetina ? 2.0 : 1.0;
   NSArray *aImage = [UIImage imagesFromBundleOfSize:oSize
                                              retina:bRetina];
   // NSLog(@"%@", aImage);
   NSString *sPath = [[NSBundle mainBundle] bundlePath];
   
   int nWidth = nColumns * oSize.width * nScale;
   int nHeight;
   
   if ([aImage count] % nColumns == 0) {
      nHeight = (int)(floorf([aImage count] / nColumns) * oSize.height * nScale);
   } else {
      nHeight = (int)(floorf([aImage count] / nColumns + 1) * oSize.height * nScale);
   }
   
   CGColorSpaceRef oColorSpace = CGColorSpaceCreateDeviceRGB();
   CGContextRef oContext = CGBitmapContextCreate(NULL, nWidth, nHeight, 8, 4 * nWidth,
                                                 oColorSpace,
                                                 (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
   CGColorSpaceRelease(oColorSpace);
   // CGRect oRect = CGRectMake(0, nHeight - oSize.height, oSize.width, oSize.height);
   UIImage *oImage;
   float nX = 0;
   float nY = nHeight - oSize.height * nScale;
   
   for (NSString *sImage in aImage) {
      NSString *sFile = [sPath stringByAppendingPathComponent:sImage];
      oImage = [[UIImage alloc] initWithContentsOfFile:sFile];
      CGRect oRect = CGRectMake(nX + (int)((oSize.width * nScale - oImage.size.width * nScale) * 0.5),
                                nY + (int)((oSize.height * nScale - oImage.size.height * nScale) * 0.5),
                                oImage.size.width * nScale, oImage.size.height * nScale);
      
      CGContextDrawImage(oContext, oRect, oImage.CGImage);
      
      if (oRect.origin.x + oSize.width * nScale >= nWidth) {
         nX = 0;
         nY -= oSize.height * nScale;
      } else {
         nX += oSize.width * nScale;
      }
   }
   
   CGImageRef oImageRef = CGBitmapContextCreateImage(oContext);
   oImage = [UIImage imageWithCGImage:oImageRef
                                scale:nScale
                          orientation:UIImageOrientationUp];
   CGContextRelease(oContext);
   CGImageRelease(oImageRef);
   
   return oImage;
}

// -------------------------------------------------------------------------------------------------

+ (UIImage *) mergeBundleImagesOfSize:(CGSize) oSize
                               retina:(BOOL) bRetina {
   //         -----------------------
   return [UIImage mergeBundleImagesOfSize:oSize
                                   columns:[UIImage cachedColumns]
                                    retina:bRetina];
}

// -------------------------------------------------------------------------------------------------

- (void) splitIntoImagesOfSize:(CGSize) oSize
                        retina:(BOOL) bRetina
                        format:(NSString *) sFormat {
   //    ---------------------
   // Zerschneidet die Bitmap in oSize große Stücke und speichert sie als xxx.png im Doc-Folder.
   // NSString *sFormat = bRetina ? @"%03i@2x.png" : @"%03i.png"; // 001@2x.png bzw. 001.png
   float nScale = bRetina ? 2.0 : 1.0;
   int nImageWidth = oSize.width * nScale;
   int nImageHeight = oSize.height * nScale;
   int nColumns = ceil(self.size.width / nImageWidth);
   int nRows = ceil(self.size.height / nImageHeight);
   CGRect oRect = CGRectMake(0, 0, nImageWidth, nImageHeight);
   UIImage *oImage;
   
   for (int nImage = 0; nImage < nColumns * nRows; nImage++) {
      CGImageRef oImageRef = CGImageCreateWithImageInRect(self.CGImage, oRect);
      oImage = [UIImage imageWithCGImage:oImageRef];
      CGImageRelease(oImageRef);
      
      [oImage writeToDocumentsDirectory:[NSString stringWithFormat:sFormat, nImage + 1]];
      
      if (oRect.origin.x + oRect.size.width >= self.size.width) {
         oRect.origin.x = 0;
         oRect.origin.y += oRect.size.height;
      } else {
         oRect.origin.x += oRect.size.width;
      }
   }
}

// -------------------------------------------------------------------------------------------------

- (UIImage *) imageAtColumn:(NSUInteger) nColumn
                     andRow:(NSUInteger) nRow
                     ofSize:(CGSize) oSize {
   //         -------------
   NSString *sKey = [NSString stringWithFormat:@"%lu-%lu", (long unsigned)nColumn, (long unsigned)nRow];
   UIImage *oImage = [UIImage cachedImageForKey:sKey];
   
   if (!oImage) {
      float nScale = [UIScreen mainScreen].scale;
      int nColumns =  ceil(self.size.width * nScale / oSize.width);
      int nRows = ceil(self.size.height * nScale / oSize.height);
      
      if (nColumn < nColumns && nRow < nRows) {
         CGRect oRect = CGRectMake(nColumn * oSize.width, nRow * oSize.height,
                                   oSize.width, oSize.height);
         CGImageRef oImageRef = CGImageCreateWithImageInRect(self.CGImage, oRect);
         oImage = [UIImage imageWithCGImage:oImageRef
                                      scale:nScale
                                orientation:UIImageOrientationUp];
         CGImageRelease(oImageRef);
         
         [UIImage setCachedImage:oImage
                          forKey:sKey];
      }
   }
   
   return oImage;
}

// -------------------------------------------------------------------------------------------------

+ (UIImage *) imageAtColumn:(NSUInteger) nColumn
                     andRow:(NSUInteger) nRow
                  fromImage:(NSString *) sImage
                     ofSize:(CGSize) oSize {
   //         -------------
   /*
    static NSCache *oCache;
    // static UIImage *oMaster;
    
    if (!oCache) {
    oCache = [[NSCache alloc] init];
    }
    */
   
   // Nicht besser:
   // UIImage *oMaster = [UIImage imageNamed:sImage];
   
   /*
    // 0.1 statt 0.15 bei 10.000 Durchläufen
    if (!oMaster) {
    oMaster  = [UIImage imageNamed:sImage];
    }
    */
   
   UIImage *oMaster = [UIImage cachedImageForKey:sImage];
   
   if (!oMaster) {
      NSString *sFullName;
      
      if ([sImage hasSuffix:@".png"]) {
         sFullName = sImage;
      } else {
         sFullName = [NSString stringWithFormat:@"%@.png", sImage];
      }
      
      NSString *sPath = [[NSBundle mainBundle] bundlePath];
      NSString *sFile = [sPath stringByAppendingPathComponent:sFullName];
      oMaster = [[UIImage alloc] initWithContentsOfFile:sFile];
      
      [UIImage setCachedImage:oMaster
                       forKey:sImage];
      // NSLog(@"%@, %@", sImage, sFile);
   }
   
   return [oMaster imageAtColumn:nColumn
                          andRow:nRow
                          ofSize:oSize];
}

// -------------------------------------------------------------------------------------------------

+ (UIImage *) imageAtColumn:(NSUInteger) nColumn
                     andRow:(NSUInteger) nRow {
   //         -------------
   // NSLog(@"%i, %i, %@", nColumn, nRow, sImage);
   return [UIImage imageAtColumn:nColumn
                          andRow:nRow
                       fromImage:[UIImage fileName]
                          ofSize:[UIImage imageSize]];
}

// -------------------------------------------------------------------------------------------------

+ (UIImage *) imageAtPosition:(NSUInteger) nPosition {
   //         ---------------
   int nColumns = [UIImage cachedColumns];
   
   return [UIImage imageAtColumn:(nPosition - 1) % nColumns
                          andRow:(int)((nPosition - 1) / nColumns)];
}

// -------------------------------------------------------------------------------------------------

- (void) writeToDocumentsDirectory:(NSString *) sImage {
   //    -------------------------
   // @"Glyphs.png" -> Schreibt Bitmaps in den Documents-Ordner
   if (![sImage hasSuffix:@".png"]) {
      sImage = [NSString stringWithFormat:@"%@.png", sImage];
   }
   
   NSString *sPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
   NSString *sFile = [sPath stringByAppendingPathComponent:sImage];
   
   [UIImagePNGRepresentation(self) writeToFile:sFile atomically:true];
}

// -------------------------------------------------------------------------------------------------

- (UIImage *) imageWithColor:(UIColor *) oColor {
   //         --------------
   CGRect oRect = CGRectMake(0, 0, self.size.width, self.size.height);
   
   // UIGraphicsBeginImageContext(oRect.size); // Nicht Retina-kompatibal
   UIGraphicsBeginImageContextWithOptions(oRect.size, false, [UIScreen mainScreen].scale);
   
   CGContextRef oContext = UIGraphicsGetCurrentContext();
   
   CGContextTranslateCTM(oContext, 0, oRect.size.height); // Spiegeln
   CGContextScaleCTM(oContext, 1.0, -1.0);
   
   CGContextSetFillColorWithColor(oContext, oColor.CGColor);
   CGContextClipToMask(oContext, oRect, self.CGImage);
   CGContextFillRect(oContext, oRect);
   
   UIImage *oImage = UIGraphicsGetImageFromCurrentImageContext();
   
   UIGraphicsEndImageContext();
   
   return oImage;
}

// -------------------------------------------------------------------------------------------------

+ (UIImage *) imageNamed:(NSString *) sName
               withColor:(UIColor *) oColor {
   //         ----------
   NSString *sKey = [NSString stringWithFormat:@"%@-%@", sName, [oColor cacheKey]];
   UIImage *oImage = [UIImage cachedImageForKey:sKey];
   
   if (!oImage) {
      /*
       UIImage *oImage = [UIImage cachedImageForKey:sName];
       
       if (!oImage) {
       NSString *sFull;
       
       if ([sName hasSuffix:@".png"]) {
       sFull = sName;
       } else {
       sFull = [NSString stringWithFormat:@"%@.png", sName];
       }
       
       NSString *sPath = [[NSBundle mainBundle] bundlePath];
       NSString *sFile = [sPath stringByAppendingPathComponent:sFull];
       oImage = [[UIImage alloc] initWithContentsOfFile:sFile];
       
       [UIImage setCachedImage:oImage
       forKey:sName];
       }
       
       oImage = [oImage imageWithColor:oColor];
       */
      oImage = [[UIImage imageNamed:sName] imageWithColor:oColor];
      
      [UIImage setCachedImage:oImage
                       forKey:sKey];
   }
   
   return oImage;
}

// -------------------------------------------------------------------------------------------------

- (UIImage *) randomImageOfSize:(CGSize) oSize {
   //         -----------------
   float nX = arc4random() % (int)(self.size.width - oSize.width);
   float nY = arc4random() % (int)(self.size.height - oSize.height);
   CGRect oRect = CGRectMake(nX, nY, oSize.width, oSize.height);
   
   CGImageRef oImageRef = CGImageCreateWithImageInRect(self.CGImage, oRect);
   UIImage *oImage = [UIImage imageWithCGImage:oImageRef];
   CGImageRelease(oImageRef);
   
   return oImage;
}

// -------------------------------------------------------------------------------------------------

- (UIImage *) imageOfSize:(CGSize) oSize {
   //         -----------
   float nHorRatio = oSize.width / self.size.width;
   float nVerRatio = oSize.height / self.size.height;
   float nRatio = fminf(nHorRatio, nVerRatio);
   
   oSize = CGSizeMake(self.size.width * nRatio, self.size.height * nRatio);
   CGRect oRect = CGRectIntegral(CGRectMake(0, 0, oSize.width, oSize.height)); // Runden!
   
   CGImageRef oImageRef = self.CGImage;
   CGColorSpaceRef oColorRef = CGColorSpaceCreateDeviceRGB();
   CGContextRef oContext =
   CGBitmapContextCreate(NULL, oRect.size.width, oRect.size.height,
                         8, 4 * oRect.size.width,
                         oColorRef,
                         kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Little);
   CGContextSetInterpolationQuality(oContext, kCGInterpolationHigh);
   CGContextDrawImage(oContext, oRect, oImageRef);
   
   CGImageRef oNewImageRef = CGBitmapContextCreateImage(oContext);
   UIImage *oImage = [UIImage imageWithCGImage:oNewImageRef
                                         scale:[UIScreen mainScreen].scale
                                   orientation:UIImageOrientationUp];
   CGContextRelease(oContext);
   CGImageRelease(oNewImageRef);
   CGColorSpaceRelease(oColorRef);
   
   return oImage;
}

// -------------------------------------------------------------------------------------------------

- (UIImage *) imageOfFixWidthOrHeightMax:(NSUInteger) nSize {
   //         --------------------------
   CGSize oSize;
   
   if (self.size.width > self.size.height ) {
      oSize = (CGSize){nSize, (int)(nSize * self.size.width / self.size.height)};
   } else {
      oSize = (CGSize){(int)(nSize * self.size.width / self.size.height), nSize};
   }
   
   return [self imageOfSize:oSize];
}

// -------------------------------------------------------------------------------------------------

- (UIImage *) imageOfFixWidthOrHeightMin:(NSUInteger) nSize {
   //         --------------------------
   CGSize oSize;
   
   if (self.size.width > self.size.height ) {
      oSize = (CGSize){(int)(nSize * self.size.width / self.size.height), nSize};
   } else {
      oSize = (CGSize){nSize, (int)(nSize * self.size.width / self.size.height)};
   }
   
   return [self imageOfSize:oSize];
}

// -------------------------------------------------------------------------------------------------

- (UIImage *) imageOfFixWidth:(NSUInteger) nWidth {
   //         ---------------
   CGSize oSize = {nWidth, (int)(nWidth * self.size.height / self.size.width)};
   return [self imageOfSize:oSize];
}

// -------------------------------------------------------------------------------------------------

- (UIImage *) imageOfFixHeight:(NSUInteger) nHeight {
   //         ----------------
   CGSize oSize = {(int)(nHeight * self.size.width / self.size.height), nHeight};
   return [self imageOfSize:oSize];
}

// -------------------------------------------------------------------------------------------------

- (UIImage *) imageRotatedByDegrees:(CGFloat) nDegrees {
   //         ---------------------
   /*
    oArrowLeft = [[UIImage alloc] initWithCGImage:oArrowRightWhite.CGImage
    scale:[UIScreen mainScreen].scale
    orientation:UIImageOrientationDown];
    */
   UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width, self.size.height)];
   CGAffineTransform t = CGAffineTransformMakeRotation(degreesToRadian(nDegrees));
   rotatedViewBox.transform = t;
   CGSize rotatedSize = rotatedViewBox.frame.size;
   
   // Create the bitmap context
   UIGraphicsBeginImageContext(rotatedSize);
   CGContextRef bitmap = UIGraphicsGetCurrentContext();
   
   // Move the origin to the middle of the image so we will rotate and scale around the center.
   CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
   
   //   // Rotate the image context
   CGContextRotateCTM(bitmap, degreesToRadian(nDegrees));
   
   // Now, draw the rotated/scaled image into the context
   CGContextScaleCTM(bitmap, 1.0, -1.0);
   CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
   
   UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
   UIGraphicsEndImageContext();
   return newImage;
   
}

// -------------------------------------------------------------------------------------------------

+ (UIImage *) imageFromBundle:(NSString *) sFile {
   //         ---------------
   NSString *sPath = [[NSBundle mainBundle] bundlePath];
   
   return [UIImage imageWithContentsOfFile:[sPath stringByAppendingPathComponent:sFile]];
}

// -------------------------------------------------------------------------------------------------

+ (UIImage *) imageFromPDF:(NSURL *) oURL
                  withSize:(CGSize ) oSize {
   //         ------------
   CGPDFDocumentRef oPdf = CGPDFDocumentCreateWithURL((__bridge CFURLRef)oURL);
   
   UIGraphicsBeginImageContext(oSize);
   CGContextRef oContext = UIGraphicsGetCurrentContext();
   CGContextTranslateCTM(oContext, 0.0, oSize.height);
   CGContextScaleCTM(oContext, 1.0, -1.0);
   
   CGPDFPageRef oPage = CGPDFDocumentGetPage(oPdf, 1);
   
   CGContextSaveGState(oContext);
   
   CGRect oRect = {0, 0, oSize.width, oSize.height};
   CGAffineTransform oTransform = CGPDFPageGetDrawingTransform(oPage, kCGPDFCropBox, oRect, 0, true);
   CGContextConcatCTM(oContext, oTransform);
   CGContextDrawPDFPage(oContext, oPage);
   
   CGContextRestoreGState(oContext);
   
   UIImage *oImage = UIGraphicsGetImageFromCurrentImageContext();
   UIGraphicsEndImageContext();
   
   return oImage;
}

// -------------------------------------------------------------------------------------------------

+ (UIImage *) imageOfColor:(UIColor *) oColor {
   //         ------------
   CGRect oRect = {0, 0, 1, 1};
   UIGraphicsBeginImageContext(oRect.size);
   CGContextRef oContext = UIGraphicsGetCurrentContext();
   
   CGContextSetFillColorWithColor(oContext, [oColor CGColor]);
   CGContextFillRect(oContext, oRect);
   
   UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
   UIGraphicsEndImageContext();
   
   return image;
}

// -------------------------------------------------------------------------------------------------

@end
