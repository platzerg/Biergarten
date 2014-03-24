//
//  BiergartenTests.m
//  BiergartenTests
//
//  Created by platzerworld on 13.03.14.
//  Copyright (c) 2014 platzerworld. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface BiergartenTests : XCTestCase
@property (nonatomic, retain) UIViewController* vc;
@end

@implementation BiergartenTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    XCTAssertNotNil(@1, @"foo");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.vc = [storyboard instantiateViewControllerWithIdentifier:@"mapviewcontroller"];
    [self.vc performSelectorOnMainThread:@selector(viewDidLoad) withObject:nil waitUntilDone:YES];
}

@end
