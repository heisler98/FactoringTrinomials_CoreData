//
//  FTEditorViewController.h
//  FactoringTri2
//
//  Created by Hunter Eisler on 3/7/13.
//  Copyright (c) 2013 H-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FTEditorViewDelegate.h"
@class CCTrinomial;
@interface FTEditorViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
//implementation-wide properties
@property (weak, nonatomic) IBOutlet UITextField *bTriField;
@property (weak, nonatomic) IBOutlet UITextField *cTriField;
@property (weak, nonatomic) IBOutlet UITextField *bPlusMinusField;
@property (weak, nonatomic) IBOutlet UITextField *cPlusMinusField;
@property (strong, nonatomic) UIPickerView *picker;
@property (strong, nonatomic) NSArray *pickerSourceArray;
@property (nonatomic) double holdCValue;
@property (nonatomic) double holdBValue;
@property (nonatomic) NSArray *editorTriArray;
@property (nonatomic) id<FTEditorViewDelegate> delegate;

//IBAction methods
- (IBAction)keyboardButton:(id)sender;
-(IBAction)factorTestButtonPushed:(id)sender;
-(IBAction)handleDoneButtonPushed:(id)sender;

@end
