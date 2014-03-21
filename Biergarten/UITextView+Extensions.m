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

#import "UITextView+Extensions.h"

// -------------------------------------------------------------------------------------------------

@implementation UITextView (Extensions)

// -------------------------------------------------------------------------------------------------

+ (float) calcHeightWithText:(NSString *) sText {
   //     ------------------
   static UITextView *oTextView;
   
   if (oTextView == nil) {
      // Beim allerersten Mal...
      oTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 300, 480)];
      // oTextView.font = [Setup sharedSetup].textFont;
      oTextView.editable = false;
      oTextView.userInteractionEnabled = false;
      
      UIEdgeInsets oInset = oTextView.contentInset;
      oInset.top = -5;
      //oInset.left = -3;
      
      oTextView.contentInset = oInset;
   }
   
   // @"Dies ist <b>fett</b>, dies <i>kursiv</i>, <br>neue Zeile <u>unterstrichen</u>..."
   [oTextView setValue:sText forKey:@"contentToHTMLString"];
   [oTextView sizeToFit]; // UITextView auf die notwendige Größe ziehen...
   
   return oTextView.contentSize.height - 8.0;
}

// -------------------------------------------------------------------------------------------------

@end
