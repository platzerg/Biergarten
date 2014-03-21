//
//  PWGooglePlusViewController.m
//  Biergarten
//
//  Created by platzerworld on 13.03.14.
//  Copyright (c) 2014 platzerworld. All rights reserved.
//

#import "PWGooglePlusViewController.h"
#import <GTMOAuth2Authentication.h>
#import <GTLServicePlus.h>
#import <GTLServiceYouTube.h>
#import <GTMOAuth2ViewControllerTouch.h>
#import <GTLQueryPlus.h>
#import <GTLPlusPerson.h>
#import <GTLPlusActivityFeed.h>


NSString *const kKeychainItemYTName = @"YouTubeSample: YouTube";

@interface PWGooglePlusViewController ()
- (IBAction)doLogin:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *labelGooglePlus;

@property (nonatomic, readonly) GTLServicePlus *plusService;
@property (nonatomic, retain) GTLServiceTicket *profileTicket;



@end

@implementation PWGooglePlusViewController
{
    GTLPlusPerson *_userProfile;
    GTLPlusActivityFeed *_activityFeed;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*
    GPPSignIn *signIn = [GPPSignIn sharedInstance];
    signIn.shouldFetchGooglePlusUser = YES;
    //signIn.shouldFetchGoogleUserEmail = YES;  // Uncomment to get the user's email
    
    // You previously set kClientId in the "Initialize the Google+ client" step
    signIn.clientID = @"875672505958-fll5nbjcpf09fdnigpijgqckglmoa70f.apps.googleusercontent.com";
    
    // Uncomment one of these two statements for the scope you chose in the previous step
    //GTL_EXTERN NSString * const kGTLAuthScopePlusLogin;  // "https://www.googleapis.com/auth/plus.login"
    // Know who you are on Google
    //GTL_EXTERN NSString * const kGTLAuthScopePlusMe;     // "https://www.googleapis.com/auth/plus.me"
    signIn.scopes = @[ @"https://www.googleapis.com/auth/plus.login" ];  // "https://www.googleapis.com/auth/plus.login" scope
    //signIn.scopes = @[ @"profile" ];            // "profile" scope
    
    // Optional: declare signIn.actions, see "app activities"
    signIn.delegate = self;
     */
}

/*
- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth error: (NSError *) error
{
    NSLog(@"Received error %@ and auth object %@",error, auth);
}
*/
 
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)doLogin:(id)sender {
    NSString *clientID = @"712684320813-5ms6tcv7l810pumub45f3crv92e1cutv.apps.googleusercontent.com";
    NSString *clientSecret = @"bJp4B89-WDaIGAgEU4B1TNzU";
    
    NSString *scope = @"https://www.googleapis.com/auth/plus.me"; // scope for Google+ API
    
    
    
    GTMOAuth2ViewControllerTouch *viewController;
    viewController = [[GTMOAuth2ViewControllerTouch alloc] initWithScope:scope
                                                                clientID:clientID
                                                            clientSecret:clientSecret
                                                        keychainItemName:kKeychainItemYTName
                                                                delegate:self
                                                        finishedSelector:@selector(viewController:finishedWithAuth:error:)];
    
    [[self navigationController] pushViewController:viewController animated:YES];
}

- (void)viewController:(GTMOAuth2ViewControllerTouch *)viewController finishedWithAuth:(GTMOAuth2Authentication *)auth  error:(NSError *)error {
     if (error != nil)
     {
         
     }
     else
     {
         self.plusService.authorizer = auth;
         [self fetchUserProfile];
     }
 }

- (GTLServicePlus *)plusService {
    
    static GTLServicePlus* service = nil;
    
    if (!service) {
        service = [[GTLServicePlus alloc] init];
        
        // Have the service object set tickets to retry temporary error conditions
        // automatically
        service.retryEnabled = YES;
        
        // Have the service object set tickets to automatically fetch additional
        // pages of feeds when the feed's maxResult value is less than the number
        // of items in the feed
        service.shouldFetchNextPages = YES;
    }
    return service;
}

- (NSString *)signedInUsername {
    GTMOAuth2Authentication *auth = self.plusService.authorizer;
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
- (void)fetchUserProfile {
    
    // Make a batch for fetching both the user's profile and the activity feed
    GTLQueryPlus *profileQuery = [GTLQueryPlus queryForPeopleGetWithUserId:@"me"];
    profileQuery.completionBlock = ^(GTLServiceTicket *ticket, id object, NSError *error) {
        if (error == nil) {
            _userProfile = object;
            self.labelGooglePlus.text = _userProfile.displayName;
            NSString *usern = [self signedInUsername];
        } else {
            
        }
    };
    
    GTLQueryPlus *activitiesQuery = [GTLQueryPlus queryForActivitiesListWithUserId:@"me"
                                                                        collection:kGTLPlusCollectionPublic];
    // Set an appropriate page size when requesting the activity items
    activitiesQuery.maxResults = 100;
    activitiesQuery.completionBlock = ^(GTLServiceTicket *ticket, id object, NSError *error) {
        if (error == nil) {
            _activityFeed = object;
        } else {
           
        }
    };
    
    GTLBatchQuery *batchQuery = [GTLBatchQuery batchQuery];
    [batchQuery addQuery:profileQuery];
    [batchQuery addQuery:activitiesQuery];
    
    GTLServicePlus *service = self.plusService;
    self.profileTicket = [service executeQuery:batchQuery
                             completionHandler:^(GTLServiceTicket *ticket,
                                                 id result, NSError *error) {
                                 // Callback
                                 //
                                 // For batch queries with successful execution,
                                 // the result is a GTLBatchResult object
                                 //
                                 // At this point, the query completion blocks
                                 // have already been called
                                 self.profileTicket = nil;
                                 
                                 //[self updateUI];
                             }];
    //[self updateUI];
}
@end
