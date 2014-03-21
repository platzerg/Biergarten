//
//  UIViewController+Extensions.m
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

#import "UIViewController+Extensions.h"

@implementation UIViewController (Extensions)

// -------------------------------------------------------------------------------------------------

- (CGRect) contentRect {
   //      -----------
   CGRect oRect = self.view.bounds;
   oRect.size.height -= self.navigationController.navigationBar.bounds.size.height;
   
   if (!self.hidesBottomBarWhenPushed) {
      oRect.size.height -= self.tabBarController.tabBar.bounds.size.height;
   }
   
   return oRect;
}

// -------------------------------------------------------------------------------------------------

@end
