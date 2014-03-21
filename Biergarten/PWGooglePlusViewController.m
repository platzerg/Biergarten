//
//  PWGooglePlusViewController.m
//  Biergarten
//
//  Created by platzerworld on 13.03.14.
//  Copyright (c) 2014 platzerworld. All rights reserved.
//

#import "PWGooglePlusViewController.h"
#import <GooglePlus/GooglePlus.h>

@interface PWGooglePlusViewController ()
- (IBAction)doLogin:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *labelGooglePlus;

@end

@implementation PWGooglePlusViewController

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
}

- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth error: (NSError *) error
{
    NSLog(@"Received error %@ and auth object %@",error, auth);
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

- (IBAction)doLogin:(id)sender {
    [[GPPSignIn sharedInstance] trySilentAuthentication];
}

-(void)refreshInterfaceBasedOnSignIn
{
    if ([[GPPSignIn sharedInstance] authentication]) {
        // The user is signed in.
        // Perform other actions here, such as showing a sign-out button
    }
}
@end
