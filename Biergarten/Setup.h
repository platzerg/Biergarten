//
//  Setup.h
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

@interface Setup : NSObject
   //      -----
@property (nonatomic, copy) NSString *language; // @"de"
@property (nonatomic) NSBundle *bundle;
@property (nonatomic) UIColor *selectedColor;
@property (nonatomic) UIColor *tintColor;
@property (nonatomic) UIColor *tagColor;
@property (nonatomic) UIFont *normalFont;
@property (nonatomic) UIFont *boldFont;
@property (nonatomic) UIFont *smallFont;
@property (nonatomic) UIFont *iconFont;
@property (nonatomic) UIFont *largeFont;
@property (nonatomic, readonly) UIFont *textFont;
@property (nonatomic, readonly) UIFont *textBoldFont;
@property (nonatomic, readonly) UIFont *tagFont;
@property (nonatomic, readonly) NSInteger fontSizeInPoints; // 13, 15, 17 etc.
@property (nonatomic, copy) NSString *fontName;
@property (nonatomic) NSInteger fontSize; // 1=groß, 0=normal, -1=klein
@property (nonatomic, copy) NSString *appId;
@property (nonatomic, copy) NSString *appStore;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *webPath;
@property (nonatomic) BOOL fontRefresh;
@property (nonatomic) BOOL enableLeftMenu;
@property (nonatomic) BOOL enablePresenter;

// -------------------------------------------------------------------------------------------------

+ (Setup *) sharedSetup;
- (void) saveToUserDefaults;
- (void) loadFont;

// -------------------------------------------------------------------------------------------------

@end
