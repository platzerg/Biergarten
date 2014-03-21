//
//  PWTumblrViewController.m
//  Biergarten
//
//  Created by platzerworld on 13.03.14.
//  Copyright (c) 2014 platzerworld. All rights reserved.
//

#import "PWTumblrViewController.h"
#import <TMAPIClient.h>

@interface PWTumblrViewController ()
- (IBAction)doLogin:(id)sender;
- (IBAction)doPostPhoto:(id)sender;

@end

@implementation PWTumblrViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [[TMAPIClient sharedInstance] authenticate:@"tumblr391994024204840" callback:^(NSError *error) {
        if (error)
            NSLog(@"Authentication failed: %@ %@", error, [error description]);
        else
            NSLog(@"Authentication successful!");
    }];
}

- (IBAction)doPostPhoto:(id)sender {
    [TMAPIClient sharedInstance].OAuthConsumerKey = @"ZBsIsrmUX5g1hirO290ldKn1TYS7EIRCkGJh1Iwe8U2bxzhQtP";
    [TMAPIClient sharedInstance].OAuthConsumerSecret = @"cJl3FP2imMke0uZoYRUQAEPjjO82IAF1X28B8aRy4fWUdYtVlx";
    //[TMAPIClient sharedInstance].OAuthToken = @"";
    //[TMAPIClient sharedInstance].OAuthTokenSecret = @"";
    
    [[TMAPIClient sharedInstance] photo:@""
                          filePathArray:@[[[NSBundle mainBundle] pathForResource:@"blue" ofType:@"png"]]
                       contentTypeArray:@[@"image/png"]
                          fileNameArray:@[@"blue.png"]
                             parameters:@{@"caption" : @"Caption"}
                               callback:^(id response, NSError *error) {
                                   if (error)
                                       NSLog(@"Error posting to Tumblr");
                                   else
                                       NSLog(@"Posted to Tumblr");
                               }];

}
@end
