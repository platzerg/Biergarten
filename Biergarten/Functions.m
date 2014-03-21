//
//  Functions.h
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

#import "Functions.h"

void PerformBlockAfterDelay(NSTimeInterval nDelay, void (^oBlock)(void)) {
   // ---------------------
   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * nDelay),
                  dispatch_get_main_queue(), oBlock);
}

// -------------------------------------------------------------------------------------------------

void PerformBlockInRunLoop(void (^oBlock)(void)) {
   // --------------------
   [[NSOperationQueue mainQueue] addOperationWithBlock:oBlock];
}

// -------------------------------------------------------------------------------------------------
