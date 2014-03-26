//
//  PWDopboxViewController.m
//  Biergarten
//
//  Created by platzerworld on 14.03.14.
//  Copyright (c) 2014 platzerworld. All rights reserved.
//

#import "PWDopboxViewController.h"
#import <DropboxSDK/DropboxSDK.h>

@interface PWDopboxViewController ()
- (void)updateButtons;

@end

@implementation PWDopboxViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        self.title = @"Link Account";
    }
    return self;
}

- (void)didPressLink {
    if (![[DBSession sharedSession] isLinked]) {
		[[DBSession sharedSession] linkFromController:self];
    } else {
        [[DBSession sharedSession] unlinkAll];
        [[[UIAlertView alloc]
           initWithTitle:@"Account Unlinked!" message:@"Your dropbox account has been unlinked"
           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]
       
         show];
        [self updateButtons];
    }
}

- (IBAction)didPressPhotos {
    [self.navigationController pushViewController:photoViewController animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateButtons];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                               initWithTitle:@"Photos" style:UIBarButtonItemStylePlain
                                               target:self action:@selector(didPressPhotos)] ;
    self.title = @"Link Account";
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userAuthenticateCallback:) name:@"db-70597bjsoly1oxgAuthCallbackNotification" object:nil];
}

- (void)viewDidUnload {
    linkButton = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return toInterfaceOrientation == UIInterfaceOrientationPortrait;
    } else {
        return YES;
    }
}


#pragma mark private methods

@synthesize linkButton;
@synthesize photoViewController;

- (void)updateButtons {
    NSString* title = [[DBSession sharedSession] isLinked] ? @"Unlink Dropbox" : @"Link Dropbox";
    [linkButton setTitle:title forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem.enabled = [[DBSession sharedSession] isLinked];
}

- (void) userAuthenticateCallback:(NSNotification *)notification {
	NSURL *callbackURL = notification.object;
    NSDictionary *result = FKQueryParamDictionaryFromURL1(callbackURL);
    NSString *oauth_token = [result valueForKey:@"oauth_token"];
    NSString *auth_token_secret = [result valueForKey:@"oauth_token_secret"];
    NSString *state = [result valueForKey:@"state"];
    NSString *uid = [result valueForKey:@"uid"];
    NSLog(@"UID: %@ Token: %@ Secret: %@ State: %@", uid, oauth_token, auth_token_secret, state);
    [self updateButtons];
}

NSDictionary *FKQueryParamDictionaryFromURL1(NSURL *url) {
    NSString *urlString = url.query;
    NSDictionary *params = FKQueryParamDictionaryFromQueryString1(urlString);
    return params;
}


NSDictionary *FKQueryParamDictionaryFromQueryString1(NSString *queryString) {
    if (queryString.length < 1) {
        return nil;
    }
    
    NSArray *vars = [queryString componentsSeparatedByString:@"&"];
    NSMutableDictionary *keyValues = [NSMutableDictionary dictionary];
    for (NSString *var in vars) {
        NSArray *kv = [var componentsSeparatedByString:@"="];
        if ([kv count] != 2) {
            continue;
        }
        keyValues[kv[0]] = kv[1];
    }
    
    return [keyValues copy];
}

@end
