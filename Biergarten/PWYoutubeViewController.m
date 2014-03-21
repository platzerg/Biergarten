//
//  PWYoutubeViewController.m
//  Biergarten
//
//  Created by platzerworld on 15.03.14.
//  Copyright (c) 2014 platzerworld. All rights reserved.
//

#import "PWYoutubeViewController.h"


enum {
    // Playlist pop-up menu item tags.
    kUploadsTag = 0,
    kLikesTag = 1,
    kFavoritesTag = 2,
    kWatchHistoryTag = 3,
    kWatchLaterTag = 4
};

// Keychain item name for saving the user's authentication information.
NSString *const kKeychainItemName = @"YouTubeSample: YouTube";

@interface PWYoutubeViewController ()
// Accessor for the app's single instance of the service object.
//@property (nonatomic, readonly) GTLServiceYouTube *youTubeService;
@end

@implementation PWYoutubeViewController{
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // Load the OAuth 2 token from the keychain, if it was previously saved.
    NSString *clientID = @"712684320813-5ms6tcv7l810pumub45f3crv92e1cutv.apps.googleusercontent.com";
    NSString *clientSecret = @"bJp4B89-WDaIGAgEU4B1TNzU";
    
    
    //GTMOAuth2Authentication *auth =
    //[GTMOAuth2ViewControllerTouch authForGoogleFromKeychainForName:kKeychainItemName clientID:clientID  clientSecret:clientSecret];
    
    /*
    GTLServiceYouTube *service = [[GTLServiceYouTube alloc] init];
    // Services which do not require sign-in may need an API key from the
    // API Console
    service.APIKey = @"AIzaSyD9pvsUtnegJvwv5z5XrBO5vFTBVpErYN8";
    // Create a query
    GTLQueryYouTube *query = [GTLQueryYouTube queryForSearchListWithPart:@"video"];
    query.q = @"hiking boots";
    //query.country = @"US";
    // Execute the query
    GTLServiceTicket *ticket = [service executeQuery:query completionHandler:^(GTLServiceTicket *ticket, id object, NSError *error) {
    
        if (error == nil) {
            //I'VE NEVER GOTTEN TO HERE, I ALWAYS GET AN ERROR
        }
    
    
    }];
     */
    

    
}
- (IBAction)doYoutubeLogin:(id)sender {
}
/*
- (void)signInClicked {
    
    if (![self isSignedIn]) {
        // Sign in.
        [self runSigninThenHandler:^{
            [self updateUI];
        }];
    } else {
        // Sign out.
        GTLServiceYouTube *service = self.youTubeService;
        
        [GTMOAuth2ViewControllerTouch removeAuthFromKeychainForName:kKeychainItemName];
        service.authorizer = nil;
        [self updateUI];
    }
}

- (NSString *)signedInUsername {
    // Get the email address of the signed-in user.
    GTMOAuth2Authentication *auth = self.youTubeService.authorizer;
    BOOL isSignedIn = auth.canAuthorize;
    if (isSignedIn) {
        return auth.userEmail;
    } else {
        return nil;
    }
     
}

- (BOOL)isSignedIn {
   
    NSString *name = [self signedInUsername];
    return (name != nil);
}

- (void)updateUI {
}

- (void)runSigninThenHandler:(void (^)(void))handler {
    // Applications should have client ID and client secret strings
    // hardcoded into the source, but the sample application asks the
    // developer for the strings.
    NSString *clientID = @"712684320813-5ms6tcv7l810pumub45f3crv92e1cutv.apps.googleusercontent.com";
    NSString *clientSecret = @"bJp4B89-WDaIGAgEU4B1TNzU";

    
    if ([clientID length] == 0 || [clientSecret length] == 0) {
        // Remind the developer that client ID and client secret are needed.
        /*
        [_clientIDButton performSelector:@selector(performClick:)
                              withObject:self
                              afterDelay:0.5];
 
        NSLog(@"runSigninThenHandler");
        return;
    }
    
    /*
    //GTMOAuth2Authentication *d = [GTMOAuth2ViewControllerTouch authForGoogleFromKeychainForName:kKeychainItemName clientID:clientID clientSecret:clientSecret];
    
    // Show the OAuth 2 sign-in controller.
    NSBundle *frameworkBundle = [NSBundle bundleForClass:[GTMOAuth2ViewControllerTouch class]];
    GTMOAuth2ViewControllerTouch *windowController = [GTMOAuth2ViewControllerTouch controllerWithScope:kGTLAuthScopeYouTube clientID:clientID clientSecret:clientSecret keychainItemName:kKeychainItemName
        completionHandler:^(GTMOAuth2ViewControllerTouch *viewController, GTMOAuth2Authentication *auth, NSError *error) {
        NSLog(@"runSigninThenHandler");
        
        }];
    
    GTMOAuth2SignIn* h = [windowController signIn];
    
    
    GTMOAuth2ViewControllerTouch *windowController1 = [GTMOAuth2ViewControllerTouch controllerWithScope:kGTLAuthScopeYouTube clientID:clientID clientSecret:clientSecret keychainItemName:kKeychainItemName delegate:self finishedSelector:@selector(oatuhfin)];
    
    
 
    NSLog(@"++++");
}

- (void) oatuhfin
{
     NSLog(@"++++");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/*
- (IBAction)doYoutubeLogin:(id)sender {
    // [self signInClicked];
    
    NSString *clientID = @"712684320813-5ms6tcv7l810pumub45f3crv92e1cutv.apps.googleusercontent.com";
    NSString *clientSecret = @"bJp4B89-WDaIGAgEU4B1TNzU";
    
    NSString *scope = @"https://www.googleapis.com/auth/plus.me"; // scope for Google+ API
    
    GTMOAuth2ViewControllerTouch *viewController;
    viewController = [[GTMOAuth2ViewControllerTouch alloc] initWithScope:scope
                                                                 clientID:clientID
                                                             clientSecret:clientSecret
                                                         keychainItemName:kKeychainItemName
                                                                 delegate:self
                                                         finishedSelector:@selector(viewController:finishedWithAuth:error:)];
    
    [[self navigationController] pushViewController:viewController animated:YES];
     
}

- (void)viewController:(GTMOAuth2ViewControllerTouch *)viewController
      finishedWithAuth:(GTMOAuth2Authentication *)auth
                 error:(NSError *)error {
    if (error != nil) {
        // Authentication failed
    } else {
        // Authentication succeeded
    }
}
     */
    
    
@end
