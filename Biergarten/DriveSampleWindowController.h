//
//  DriveSampleWindowController.h
//  Biergarten
//
//  Created by platzerworld on 26.03.14.
//  Copyright (c) 2014 platzerworld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DriveSampleWindowController : UIViewController {
@private
    IBOutlet UITextField *_signedInField;
    IBOutlet UIButton *_signedInButton;
    
    IBOutlet UITableView *_fileListTable;
    //IBOutlet NSProgressIndicator *_fileListProgressIndicator;
    IBOutlet UITextView *_fileListResultTextField;
    IBOutlet UIButton *_fileListCancelButton;
    IBOutlet UIImageView *_thumbnailView;
    
    IBOutlet UIButton *_downloadButton;
    IBOutlet UIButton *_viewButton;
    IBOutlet UIButton *_duplicateButton;
    IBOutlet UIButton *_trashButton;
    IBOutlet UIButton *_deleteButton;
    
    IBOutlet UIButton *_uploadButton;
    //IBOutlet NSProgressIndicator *_uploadProgressIndicator;
    IBOutlet UIButton *_pauseUploadButton;
    IBOutlet UIButton *_stopUploadButton;
    IBOutlet UIButton *_newFolderButton;
    
    IBOutlet UISegmentedControl *_segmentedControl;
    IBOutlet UITableView *_detailTable;
    //IBOutlet NSProgressIndicator *_detailProgressIndicator;
    IBOutlet UITextView *_detailResultTextField;
    IBOutlet UIButton *_detailCancelButton;
    
    // Client ID Sheet (Not needed by real applications)
    IBOutlet UIButton *_clientIDButton;
    IBOutlet UITextField *_clientIDRequiredTextField;
    IBOutlet UIWindow *_clientIDSheet;
    IBOutlet UITextField *_clientIDField;
    IBOutlet UITextField *_clientSecretField;
}

+ (DriveSampleWindowController *)sharedWindowController;

- (IBAction)signInClicked:(id)sender;

- (IBAction)getFileList:(id)sender;

- (IBAction)cancelFileListFetch:(id)sender;

- (IBAction)viewClicked:(id)sender;
- (IBAction)duplicateClicked:(id)sender;
- (IBAction)trashClicked:(id)sender;
- (IBAction)deleteClicked:(id)sender;

- (IBAction)uploadFileClicked:(id)sender;
- (IBAction)pauseUploadClicked:(id)sender;
- (IBAction)stopUploadClicked:(id)sender;
- (IBAction)createFolderClicked:(id)sender;

- (IBAction)segmentedControlClicked:(id)sender;

- (IBAction)loggingCheckboxClicked:(id)sender;

// Client ID Sheet
- (IBAction)clientIDClicked:(id)sender;
- (IBAction)clientIDDoneClicked:(id)sender;
- (IBAction)APIConsoleClicked:(id)sender;

@end