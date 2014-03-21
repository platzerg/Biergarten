//
//  PWAppDelegate.h
//  Biergarten
//
//  Created by platzerworld on 13.03.14.
//  Copyright (c) 2014 platzerworld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Reachability.h>
#import <FacebookSDK/FacebookSDK.h>
#import <BZFoursquare.h>
#import <Foursquare2.h>

@class GTMOAuth2Authentication;

@interface PWAppDelegate : UIResponder <UIApplicationDelegate>
{
    NSString *relinkUserId;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) BZFoursquare *foursquare;
@property  BOOL isFoursquare2;



@end
