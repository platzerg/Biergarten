//
//  main.m
//  Biergarten
//
//  Created by platzerworld on 13.03.14.
//  Copyright (c) 2014 platzerworld. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SGTouchPresenter.h"

#import "PWAppDelegate.h"

int main(int argc, char * argv[])
{
    @autoreleasepool {
        //return UIApplicationMain(argc, argv, nil, NSStringFromClass([PWAppDelegate class]));
        
        return UIApplicationMain(argc, argv, NSStringFromClass([SGTouchPresenter class]), NSStringFromClass([PWAppDelegate class]));
    }
}
