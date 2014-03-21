//
//  PWDopboxViewController.h
//  Biergarten
//
//  Created by platzerworld on 14.03.14.
//  Copyright (c) 2014 platzerworld. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DBRestClient;

@interface PWDopboxViewController : UIViewController
{
    UIButton* linkButton;
    UIViewController* photoViewController;
	DBRestClient* restClient;
}

- (IBAction)didPressLink;

@property (nonatomic, retain) IBOutlet UIButton* linkButton;
@property (nonatomic, retain) UIViewController* photoViewController;


@end
