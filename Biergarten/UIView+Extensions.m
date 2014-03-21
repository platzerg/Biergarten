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

#import <objc/runtime.h>
#import "UIView+Extensions.h"

@implementation UIView (Extensions)

// -------------------------------------------------------------------------------------------------

static const char *bagKey = "bag";

// =================================================================================================
#pragma mark - Bag methods
// =================================================================================================

@dynamic bag;

- (id) bag {
   //  ---
   return objc_getAssociatedObject(self, bagKey);
}

// -------------------------------------------------------------------------------------------------

- (void) setBag:(id) oBag {
   //    ------
   objc_setAssociatedObject(self, bagKey, oBag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// -------------------------------------------------------------------------------------------------

- (UIView *) viewWithBag:(id) oBag {
   //        -----------
   if (self.bag == oBag) {
      return self;
   } else {
      for (UIView *oSubview in self.subviews) {
         UIView *oView = [oSubview viewWithBag:oBag];
         
         if (oView != nil) {
            return oView;
         }
      }
   }
   
   return nil;
}

// =================================================================================================
#pragma mark - Setter/Getter methods
// =================================================================================================

- (float) x {
   //     -
   return self.frame.origin.x;
}

// -------------------------------------------------------------------------------------------------

- (void) setX:(float) nX {
   //    ----
   CGRect oRect = self.frame;
   oRect.origin.x = nX;
   self.frame = oRect;
}

// -------------------------------------------------------------------------------------------------

- (float) y {
   //     -
   return self.frame.origin.y;
}

// -------------------------------------------------------------------------------------------------

- (void) setY:(float) nY {
   //    ----
   CGRect oRect = self.frame;
   oRect.origin.y = nY;
   self.frame = oRect;
}

// -------------------------------------------------------------------------------------------------

- (CGPoint) origin {
   //       ------
   return self.frame.origin;
}

// -------------------------------------------------------------------------------------------------

- (void) setOrigin:(CGPoint) oPoint {
   //    ---------
   CGRect oRect = self.frame;
   oRect.origin = oPoint;
   self.frame = oRect;
}

// -------------------------------------------------------------------------------------------------

- (float) width {
   //     -----
   return self.bounds.size.width;
}

// -------------------------------------------------------------------------------------------------

- (void) setWidth:(float) nWidth {
   //    --------
   CGRect oRect = self.frame;
   oRect.size.width = nWidth;
   self.frame = oRect;
}

// -------------------------------------------------------------------------------------------------

- (float) height {
   //     ------
   return self.bounds.size.height;
}

// -------------------------------------------------------------------------------------------------

- (void) setHeight:(float) nHeight {
   //    ---------
   CGRect oRect = self.frame;
   oRect.size.height = nHeight;
   self.frame = oRect;
}

// -------------------------------------------------------------------------------------------------

- (CGSize) size {
   //      ----
   return self.bounds.size;
}

// -------------------------------------------------------------------------------------------------

- (void) setSize:(CGSize) oSize {
   //    -------
   CGRect oRect = self.frame;
   oRect.size = oSize;
   self.frame = oRect;
}

// =================================================================================================
#pragma mark - Shadow/RoundRect methods
// =================================================================================================

- (void) enableShadowWithValue:(float) nValue {
   //    ---------------------
   // Falsch in der Doku; Default ist true!
   //self.layer.masksToBounds = false;
   self.layer.shadowOffset = CGSizeMake(0, nValue);
   self.layer.shadowOpacity = 0.5;   
}

// -------------------------------------------------------------------------------------------------

- (void) enableShadow {
   //    ------------
   [self enableShadowWithValue:5.0];
}

// -------------------------------------------------------------------------------------------------

- (void) enableRoundRectsWithValue:(float) nValue {
   //    -------------------------
   self.layer.masksToBounds = true;
   self.layer.cornerRadius = nValue;
   self.layer.shouldRasterize = true;
}

// -------------------------------------------------------------------------------------------------

- (void) enableRoundRects {
   //    ----------------
   [self enableRoundRectsWithValue:5.0];
}

// -------------------------------------------------------------------------------------------------

- (void) enableRoundRectsWithValue:(float) nValue 
                       borderWidth:(float) nWidth
                       borderColor:(UIColor *) oColor {
   //    -------------------------
   [self enableRoundRectsWithValue:nValue]; 
   self.layer.borderWidth = nWidth; 
   self.layer.borderColor = oColor.CGColor;
}

// =================================================================================================
#pragma mark - ViewController/View methods
// =================================================================================================

- (UIViewController *) viewController {
   //                  --------------
   // static macht Schwierigkeiten, wenn man das iPhone zwischendurch lockt.
   // Start -> Venue -> Venue Detail -> Map -> Zurück in Venue-Liste -> Anderes Venue -> Map -> Crash.
   UIViewController *oViewController = nil;
   // static UIViewController *oViewController;
   
   // if (oViewController == nil) {
   for (UIView *oView = self.superview; oView; oView = oView.superview) {
      UIResponder *oNextResponder = oView.nextResponder;
      
      if ([oNextResponder isKindOfClass:UIViewController.class]) {
         oViewController = (UIViewController *)oNextResponder;
         break;
      }
   }
   // }
   
   return oViewController;
}

// -------------------------------------------------------------------------------------------------

- (void) removeAllSubviews {
   //    -----------------
   [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

// -------------------------------------------------------------------------------------------------

- (void) jump {
   //    -----
   CGAffineTransform upJump = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, -25);
   CGAffineTransform downJump = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 25);
   
   self.transform = upJump;  // Starten mit Hochsprung
   
   [UIView beginAnimations:@"Jump" context:nil];
   [UIView setAnimationRepeatAutoreverses:true]; 
   [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
   [UIView setAnimationRepeatCount:3];
   [UIView setAnimationDuration:0.2];
   [UIView setAnimationDelegate:self];
   [UIView setAnimationDidStopSelector:@selector(jumpEnded:finished:context:)];
   
   self.transform = downJump;  // "Autoreverse"...
   
   [UIView commitAnimations];
}   

// -------------------------------------------------------------------------------------------------

- (void) jumpEnded:(NSString *) sId 
          finished:(NSNumber *) oFinished 
           context:(void *) oContext {
   //    ---------
   // NSLog(@"sId: %@, finished: %@, context: %@", sId, oFinished, oContext);
   
   if (oFinished.boolValue) {
      // Hier nur prinzipiell der "Listener". Ist hier identisch mit self.
      // UIView *oView = (UIView *) oContext;
      self.transform = CGAffineTransformIdentity;
      
      if ([self respondsToSelector:@selector(actionAfterFinishedJumping)]) {
         [self performSelector:@selector(actionAfterFinishedJumping) afterDelay:0.01];
      }
   }
}

// -------------------------------------------------------------------------------------------------

- (void) swell:(float) nValue {
   //    -----
   CABasicAnimation *oScale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
   oScale.fromValue = @1.0;
   oScale.toValue = @(nValue);
   oScale.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
   oScale.autoreverses = true;
   oScale.repeatCount = 1;
   oScale.duration = 0.2;
   
   [self.layer addAnimation:oScale forKey:@"swell"];
   
   /*
   CGAffineTransform swell = CGAffineTransformScale(CGAffineTransformIdentity, 1.5, 1.5);
   
   [UIView animateWithDuration:0.25
                    animations:^{
                       self.transform = swell;  // Starten mit Vergrößern
                    }
                    completion:^(BOOL finished) { 
                       [UIView animateWithDuration:0.25
                                        animations:^{
                                           self.transform = CGAffineTransformIdentity;
                                        }];
                    }];
   */
}

// -------------------------------------------------------------------------------------------------

- (void) shake {
   //    -----
   BOOL bAnimation = true;
   
   if (bAnimation) {
      CABasicAnimation *oShake = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
      oShake.fromValue = @(degreesToRadian(-2));
      oShake.toValue = @(degreesToRadian(2));
      oShake.autoreverses = true;
      oShake.repeatCount = 3; // HUGE_VAL;
      oShake.duration = 0.1;
      
      [self.layer addAnimation:oShake forKey:@"shake"];
      
   } else {
      self.transform = CGAffineTransformMakeRotation(degreesToRadian(-10));
      
      [UIView animateWithDuration:0.1
                            delay:0
                          options:
       UIViewAnimationOptionAllowUserInteraction |
       UIViewAnimationOptionRepeat |
       UIViewAnimationOptionAutoreverse
                       animations:^{
                          self.transform = CGAffineTransformMakeRotation(degreesToRadian(10));
                       }
                       completion:nil
       ];
   }
}

// -------------------------------------------------------------------------------------------------

- (void) stopShaking {
   //    -----------
   BOOL bAnimation = true;
   
   if (bAnimation) {
      [self.layer removeAnimationForKey:@"shake"];
      
   } else {
      [UIView animateWithDuration:0.1
                       animations:^{
                          self.transform = CGAffineTransformIdentity;
                       }
       ];
   }
}

// -------------------------------------------------------------------------------------------------

- (BOOL) isShaking {
   //    ---------
   for (NSString *sKey in [self.layer animationKeys]) {
      if ([sKey isEqualToString:@"shake"]) {
         return true;
      }
   }
   
   return false;
}

// -------------------------------------------------------------------------------------------------

- (UIView *) subViewWithTag:(int) nTag {
   //        --------------
	for (UIView *oView in self.subviews) {
		if (oView.tag == nTag) {
			return oView;
		}
	}
   
	return nil;
}

// -------------------------------------------------------------------------------------------------

- (UIImage *) viewAsImage {
   //         -----------
   UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, [[UIScreen mainScreen] scale]);
   
   [self.layer renderInContext:UIGraphicsGetCurrentContext()];
   
   UIImage *oImage = UIGraphicsGetImageFromCurrentImageContext();
   
   UIGraphicsEndImageContext();
   
   return oImage;
}

// -------------------------------------------------------------------------------------------------

@end
