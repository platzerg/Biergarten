//
//  PDViewController.m
//  PinItDemo
//
//  Created by Naveen Gavini on 2/19/13.
//  Copyright (c) 2013 Pinterest. All rights reserved.
//

#import "PDViewController.h"
#import <Pinterest/Pinterest.h>

#define kMargin             20.0
#define kSampleImageWidth   320.0
#define kSampleImageHeight  200.0

#define kPinItButtonWidth   72.0
#define kPinItButtonHeight  32.0

@interface PDViewController ()
{
    Pinterest*  _pinterest;
}

@end

@implementation PDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];

    // Initialize a Pinterest instance with our client_id pin1436511
    _pinterest = [[Pinterest alloc] initWithClientId:@"1436511" urlSchemeSuffix:@"prod"];

    // Setup Title Label
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    CGFloat centerX = CGRectGetMidX(self.view.frame);
    [titleLabel setText:@"Pinterest Pin It Demo"];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel sizeToFit];
    [titleLabel setFrame:CGRectMake(centerX - CGRectGetWidth(titleLabel.frame)/2,
                                    kMargin,
                                    CGRectGetWidth(titleLabel.frame),
                                    CGRectGetHeight(titleLabel.frame))];
    [self.view addSubview:titleLabel];

    // Setup a sample imageview for the image we want to pin
    NSURL* aURL = [NSURL URLWithString:@"http://placekitten.com/500/400"];
    NSData* data = [[NSData alloc] initWithContentsOfURL:aURL];
    UIImage* sampleImage = [UIImage imageWithData:data];
    UIImageView* sampleImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [sampleImageView setImage:sampleImage];
    [sampleImageView setFrame:CGRectMake(centerX - kSampleImageWidth/2,
                                         CGRectGetMaxY(titleLabel.frame) + kMargin,
                                         kSampleImageWidth,
                                         kSampleImageHeight)];
    [self.view addSubview:sampleImageView];

    // Setup PinIt Button
    UIButton* pinItButton = [Pinterest pinItButton];
    [pinItButton setFrame:CGRectMake(centerX - kPinItButtonWidth/2,
                                     CGRectGetMaxY(sampleImageView.frame) + kMargin,
                                     kPinItButtonWidth,
                                     kPinItButtonHeight)];
    [pinItButton addTarget:self
                    action:@selector(pinIt:)
          forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pinItButton];
}

#pragma mark -
#pragma mark PinIt Method

- (void)pinIt:(id)sender
{
    [_pinterest createPinWithImageURL:[NSURL URLWithString:@"http://placekitten.com/500/400"]
                            sourceURL:[NSURL URLWithString:@"http://placekitten.com"]
                          description:@"Pinning from Pin It Demo"];
}

@end
