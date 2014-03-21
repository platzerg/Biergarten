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

#import <QuartzCore/QuartzCore.h>

@interface UIView (Extensions) 

// -------------------------------------------------------------------------------------------------

@property (nonatomic, strong) id bag;
@property (nonatomic, assign) float x;
@property (nonatomic, assign) float y;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) float width;
@property (nonatomic, assign) float height;
@property (nonatomic, assign) CGSize size;

// -------------------------------------------------------------------------------------------------

- (UIView *) viewWithBag:(id) oBag;
- (void) enableShadowWithValue:(float) nValue;
- (void) enableRoundRectsWithValue:(float) nValue;
- (void) enableRoundRects;
- (void) enableShadow;
- (void) enableRoundRectsWithValue:(float) nValue 
                       borderWidth:(float) nWidth
                       borderColor:(UIColor *) oColor;

- (UIViewController *) viewController;
- (void) removeAllSubviews;
- (void) jump;
- (void) swell:(float) nValue;
- (void) shake;
- (void) stopShaking;
- (BOOL) isShaking;
- (UIView*) subViewWithTag:(int) nTag;
- (UIImage *) viewAsImage;

// -------------------------------------------------------------------------------------------------

@end
