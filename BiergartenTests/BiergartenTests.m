//
//  BiergartenTests.m
//  BiergartenTests
//
//  Created by platzerworld on 13.03.14.
//  Copyright (c) 2014 platzerworld. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <DropboxSDK/DropboxSDK.h>
#import "PWAppDelegate.h"
#import <Kiwi/Kiwi.h>

@interface BiergartenTests : XCTestCase
@property (nonatomic, retain) UIViewController *mapviewcontroller;
@property (nonatomic, retain) UIViewController *twitterViewController;
@property (nonatomic, retain) UIViewController *dopboxViewController;

@property (nonatomic, retain) PWAppDelegate *appDel;
@end

@implementation BiergartenTests
{
    UIStoryboard *storyboard;
}

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.mapviewcontroller = [storyboard instantiateViewControllerWithIdentifier:@"PWMapsViewController"];
    self.twitterViewController = [storyboard instantiateViewControllerWithIdentifier:@"PWTwitterViewController"];
    self.dopboxViewController = [storyboard instantiateViewControllerWithIdentifier:@"PWDopboxViewController"];
    
    self.appDel = (PWAppDelegate *)[[UIApplication sharedApplication] delegate];
    [[KWFailure new] clearStubs];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    storyboard = nil;
}

- (void)testExample
{
    XCTAssertNotNil(@1, @"foo");
    
    [self.mapviewcontroller performSelectorOnMainThread:@selector(viewDidLoad) withObject:nil waitUntilDone:YES];
}

- (void)testTwitter
{
    XCTAssertNotNil(@1, @"foo");
    
    [self.twitterViewController performSelectorOnMainThread:@selector(isTwitterLoginSucessful) withObject:nil waitUntilDone:YES];
}

- (void)dropbox
{
    [[DBSession sharedSession] unlinkAll];
    
    [self.dopboxViewController performSelectorOnMainThread:@selector(didPressLink) withObject:nil waitUntilDone:YES];
    BOOL *isLinked = [[DBSession sharedSession] isLinked];
    XCTAssertTrue(isLinked, @"");
}

@end
