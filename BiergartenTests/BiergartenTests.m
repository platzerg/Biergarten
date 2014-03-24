//
//  BiergartenTests.m
//  BiergartenTests
//
//  Created by platzerworld on 13.03.14.
//  Copyright (c) 2014 platzerworld. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface BiergartenTests : XCTestCase
@property (nonatomic, retain) UIViewController* mapviewcontroller;
@property (nonatomic, retain) UIViewController* twitterViewController;

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

@end
