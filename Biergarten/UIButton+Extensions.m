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

#import "UIButton+Extensions.h"

// -------------------------------------------------------------------------------------------------

@implementation UIButton (Extensions)

// -------------------------------------------------------------------------------------------------

- (void) addTarget:(id) oTarget
            action:(SEL) oAction {
   //    ---------
   [self addTarget:oTarget action:oAction forControlEvents:UIControlEventTouchUpInside];
}

// -------------------------------------------------------------------------------------------------

- (void)  setImage:(UIImage *) oImage
         withColor:(UIColor *) oColor {
   //    ---------
   [self setImage:[oImage imageWithColor:oColor]
         forState:UIControlStateNormal];
}

// -------------------------------------------------------------------------------------------------

- (void) setImage:(UIImage *) oImage {
   //    --------
   [self setImage:oImage
         forState:UIControlStateNormal];
}

// -------------------------------------------------------------------------------------------------

- (void) setBothImages:(UIImage *) oImage {
   //    -------------
   [self setImage:oImage forState:UIControlStateNormal];
   [self setImage:oImage forState:UIControlStateHighlighted];
}

// -------------------------------------------------------------------------------------------------

- (void) setBackgroundImage:(UIImage *) oNormal
                highlighted:(UIImage *) oHighlighted {
   //    ------------------
   [self setBackgroundImage:oNormal forState:UIControlStateNormal];
   [self setBackgroundImage:oHighlighted forState:UIControlStateHighlighted];
}

// -------------------------------------------------------------------------------------------------

- (void) setImageNamed:(NSString *) sImage
             withColor:(UIColor *) oColor {
   //    -------------
   [self setImage:[UIImage imageNamed:sImage withColor:oColor]
         forState:UIControlStateNormal];
}

// -------------------------------------------------------------------------------------------------

- (void) setImageNamed:(NSString *) sImage {
   //    -------------
   [self setImage:[UIImage imageNamed:sImage]
         forState:UIControlStateNormal];
}

// -------------------------------------------------------------------------------------------------

- (void) setTitle:(NSString *) sTitle {
   //    --------
   [self setTitle:sTitle 
         forState:UIControlStateNormal];
}

// -------------------------------------------------------------------------------------------------

@end
