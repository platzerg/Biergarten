//
//  PWAppDelegate.m
//  Biergarten
//
//  Created by platzerworld on 13.03.14.
//  Copyright (c) 2014 platzerworld. All rights reserved.
//

#import "PWAppDelegate.h"
#import "PWFBFriedPickerViewController.h"
#import <TSMessage.h>
#import "PWFoursquareViewController.h"
#import <BZFoursquare.h>
#import <Foursquare2.h>
#import <FlickrKit.h>
#import <InstagramKit.h>
#import <TMAPIClient.h>
#import <DropboxSDK/DropboxSDK.h>
#import "BiergartenGAEFetcher.h"
#import "PWDataManager.h"

@interface PWAppDelegate () <DBSessionDelegate, DBNetworkRequestDelegate>

@end

@implementation PWAppDelegate
{
    Reachability *reachability;
}
    static NSString * const kClientID = @"875672505958-fll5nbjcpf09fdnigpijgqckglmoa70f.apps.googleusercontent.com";

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [TSMessage setDefaultViewController: self.window.rootViewController];
    [PWFBFriedPickerViewController class];
    
    [self initFlickr];
    [self initInstagram];
    [self initTumblr];
    [self initGooglePlus];
    [self initDropbox];
    
    PWDataManager *sharedDataManager = [PWDataManager sharedManager];
    
    BiergartenGAEFetcher *myBiergartenFetcher = [[BiergartenGAEFetcher alloc] init];
    [myBiergartenFetcher loadBiergaerten];
    
    return YES;
}

-(void) initFlickr
{
    [[FlickrKit sharedFlickrKit] initializeWithAPIKey:@"73767299b91be4b2db8d67de99d1da66" sharedSecret:@"75e53598d548f2f3"];
}

-(void) initInstagram
{
    
}

-(void) initDropbox
{
    // Set these variables before launching the app
    NSString* appKey = @"70597bjsoly1oxg";
	NSString* appSecret = @"12vzjlv5lkl9duy";
	NSString *root = kDBRootDropbox; // Should be set to either kDBRootAppFolder or kDBRootDropbox
	// You can determine if you have App folder access or Full Dropbox along with your consumer key/secret
	// from https://dropbox.com/developers/apps
	
	// Look below where the DBSession is created to understand how to use DBSession in your app
	
	NSString* errorMsg = nil;
	if ([appKey rangeOfCharacterFromSet:[[NSCharacterSet alphanumericCharacterSet] invertedSet]].location != NSNotFound) {
		errorMsg = @"Make sure you set the app key correctly in DBBiergartenAppDelegate.m";
	} else if ([appSecret rangeOfCharacterFromSet:[[NSCharacterSet alphanumericCharacterSet] invertedSet]].location != NSNotFound) {
		errorMsg = @"Make sure you set the app secret correctly in DBBiergartenAppDelegate.m";
	} else if ([root length] == 0) {
		errorMsg = @"Set your root to use either App Folder of full Dropbox";
	} else {
		NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
		NSData *plistData = [NSData dataWithContentsOfFile:plistPath];
		NSDictionary *loadedPlist =
        [NSPropertyListSerialization
         propertyListFromData:plistData mutabilityOption:0 format:NULL errorDescription:NULL];
		NSString *scheme = [[[[loadedPlist objectForKey:@"CFBundleURLTypes"] objectAtIndex:0] objectForKey:@"CFBundleURLSchemes"] objectAtIndex:0];
		if ([scheme isEqual:@"db-APP_KEY"]) {
			errorMsg = @"Set your URL scheme correctly in Biergarten-Info.plist";
		}
	}
	
	DBSession* session =
    [[DBSession alloc] initWithAppKey:appKey appSecret:appSecret root:root];
	session.delegate = self; // DBSessionDelegate methods allow you to handle re-authenticating
	[DBSession setSharedSession:session];
	
	[DBRequest setNetworkRequestDelegate:self];
    
	if (errorMsg != nil) {
		[[[UIAlertView alloc]
		   initWithTitle:@"Error Configuring Session" message:errorMsg
		   delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]
		 show];
	}
}

-(void) initGooglePlus
{
    // Set app's client ID for |GPPSignIn| and |GPPShare|.
    //[GPPSignIn sharedInstance].clientID = kClientID;
    
    // Read Google+ deep-link data.
    //[GPPDeepLink setDelegate:self];
    //[GPPDeepLink readDeepLinkAfterInstall];
}

-(void) initTumblr
{
    [TMAPIClient sharedInstance].OAuthConsumerKey = @"ZBsIsrmUX5g1hirO290ldKn1TYS7EIRCkGJh1Iwe8U2bxzhQtP";
    [TMAPIClient sharedInstance].OAuthConsumerSecret = @"cJl3FP2imMke0uZoYRUQAEPjjO82IAF1X28B8aRy4fWUdYtVlx";
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [self setUpRechability];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    // FBSample logic
    // Call the 'activateApp' method to log an app event for use in analytics and advertising reporting.
    [FBAppEvents activateApp];
    
    // FBSample logic
    // We need to properly handle activation of the application with regards to SSO
    //  (e.g., returning from iOS 6.0 authorization dialog or from fast app switching).
    [FBAppCall handleDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // FBSample logic
    // if the app is going away, we close the session object
    [FBSession.activeSession close];
}

- (BOOL)canOpenURL:(NSURL *)url
{
    NSString *URLString = [url absoluteString];
    if ([url.scheme isEqual:@"http"] || [url.scheme isEqual:@"https"]) {
        return YES;
    }
    else if ([URLString hasPrefix:@"inst391994024204840://instagram"]) {
        return YES;
    }
    return YES;
}


// FBSample logic
// If we have a valid session at the time of openURL call, we handle Facebook transitions
// by passing the url argument to handleOpenURL; see the "Just Login" sample application for
// a more detailed discussion of handleOpenURL
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    // attempt to extract a token from the url
    
    NSString *scheme = [url scheme];
	if([@"flickr391994024204840" isEqualToString:scheme]) {
		[[NSNotificationCenter defaultCenter] postNotificationName:@"UserAuthCallbackNotification" object:url userInfo:nil];
        return YES;
    }
    else if([@"inst391994024204840" isEqualToString:scheme])
    {
        if( [[InstagramEngine sharedEngine] application:application openURL:url sourceApplication:sourceApplication annotation:annotation]){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"instAuthCallbackNotification" object:url userInfo:nil];
            return YES;
        }
    }
    else if([@"inst391994024204840" isEqualToString:scheme])
    {
        return [[InstagramEngine sharedEngine] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
    }
    else if([@"pin1436511prod" isEqualToString:scheme])
    {
        NSLog(@"Opened by handling url: %@", [url absoluteString]);
        return YES;
    }
    else if([@"tumblr391994024204840" isEqualToString:scheme])
    {
        NSString *host = url.host;
        
        BOOL success = [host isEqualToString:@"success"];
        BOOL cancelled = [host isEqualToString:@"cancelled"];
        
        return [[TMAPIClient sharedInstance] handleOpenURL:url];
    }
    else if([@"com.platzerworld.Biergarten" isEqualToString:scheme])
    {
        //return [GPPURLHandler handleURL:url sourceApplication:sourceApplication annotation:annotation];
        return YES;
    }
    else if([@"db-70597bjsoly1oxg" isEqualToString:scheme])
    {
        if ([[DBSession sharedSession] handleOpenURL:url]) {
            if ([[DBSession sharedSession] isLinked]) {
                // [navigationController pushViewController:rootViewController.photoViewController animated:YES];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"db-70597bjsoly1oxgAuthCallbackNotification" object:url userInfo:nil];
                return YES;
            }
            
        }
        
        return NO;

    }
    
    
    
    
    
    
    
    
    
    if([[url host] isEqualToString:@"foursquare"])
    {
        if(_isFoursquare2)
        {
            [Foursquare2 handleURL:url];
        }
        else
        {
            return [_foursquare handleOpenURL:url];
        }
    }
    else
    {
        return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication fallbackHandler:^(FBAppCall *call) {
            NSLog(@"In fallback handler");
        }];
        
    }
    
    return NO;
}


-(void)setUpRechability
{
    NSString* status;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNetworkChange:) name:kReachabilityChangedNotification object:nil];
    
    reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
    
    if(remoteHostStatus == NotReachable)
    {
        status = [NSString stringWithFormat:@"NO CONNECTION"];
    }
    else if(remoteHostStatus == ReachableViaWiFi)
    {
        status = [NSString stringWithFormat:@"WLAN"];
    }
    else if (remoteHostStatus == ReachableViaWWAN)
    {
        status = [NSString stringWithFormat:@"3G"];
    }
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Net avail" message:status delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //[alert show];
    
}

- (void) handleNetworkChange:(NSNotification *)notice
{
    NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
    NSString* status;
    
    if (remoteHostStatus == NotReachable)
    {
        status = [NSString stringWithFormat:@"NO CONNECTION"];
    }
    else if (remoteHostStatus == ReachableViaWiFi)
    {
        status = [NSString stringWithFormat:@"WLAN"];
    }
    else if (remoteHostStatus == ReachableViaWWAN)
    {
        status = [NSString stringWithFormat:@"3G"];
    }
    
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Net avail" message:status delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //[alert show];
    
}

#pragma mark - GPPDeepLinkDelegate

/*
- (void)didReceiveDeepLink:(GPPDeepLink *)deepLink {
    // An example to handle the deep link data.
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Deep-link Data"
                          message:[deepLink deepLinkID]
                          delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    [alert show];
}
*/

#pragma mark -
#pragma mark DBSessionDelegate methods

- (void)sessionDidReceiveAuthorizationFailure:(DBSession*)session userId:(NSString *)userId {
	relinkUserId = userId;
	[[[UIAlertView alloc]
	   initWithTitle:@"Dropbox Session Ended" message:@"Do you want to relink?" delegate:self
	   cancelButtonTitle:@"Cancel" otherButtonTitles:@"Relink", nil]
	 show];
}


#pragma mark -
#pragma mark UIAlertViewDelegate methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)index {
	if (index != alertView.cancelButtonIndex) {
		// [[DBSession sharedSession] linkUserId:relinkUserId fromController:rootViewController];
	}
    
	relinkUserId = nil;
}


#pragma mark -
#pragma mark DBNetworkRequestDelegate methods

static int outstandingRequests;

- (void)networkRequestStarted {
	outstandingRequests++;
	if (outstandingRequests == 1) {
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	}
}

- (void)networkRequestStopped {
	outstandingRequests--;
	if (outstandingRequests == 0) {
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	}
}



@end
