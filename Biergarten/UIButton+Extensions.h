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

@interface UIButton (Extensions)

// -------------------------------------------------------------------------------------------------

- (void) addTarget:(id) oTarget
            action:(SEL) oAction;
- (void)  setImage:(UIImage *) oImage
         withColor:(UIColor *) oColor;
- (void) setImage:(UIImage *) oImage;
- (void) setBothImages:(UIImage *) oImage;
- (void) setBackgroundImage:(UIImage *) oNormal
                highlighted:(UIImage *) oHighlighted;
- (void) setImageNamed:(NSString *) sImage
             withColor:(UIColor *) oColor;
- (void) setImageNamed:(NSString *) sImage;
- (void) setTitle:(NSString *) sTitle;

// -------------------------------------------------------------------------------------------------

@end
