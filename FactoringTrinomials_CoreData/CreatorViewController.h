//
//  CreatorViewController.h
//  FactoringTrinomials_CoreData
//
//  Created by Hunter Eisler on 7/10/13.
//  Copyright (c) 2013 H-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Trinomial.h"

@protocol CreatorViewControllerDelegate;

@interface CreatorViewController : UIViewController

- (IBAction)handleDoneButtonPushed:(id)sender;
- (IBAction)handleCancelButtonPushed:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *aTextField;
@property (strong, nonatomic) IBOutlet UITextField *bTextField;
@property (strong, nonatomic) IBOutlet UITextField *cTextField;
@property (strong, nonatomic) IBOutlet UISegmentedControl *bOperand;
@property (strong, nonatomic) IBOutlet UISegmentedControl *cOperand;

@property (nonatomic, weak) id<CreatorViewControllerDelegate> delegate;
@property (nonatomic, strong) Trinomial *currentTri;

@end

@protocol CreatorViewControllerDelegate <NSObject>

-(void)creatorViewControllerDidSave;
-(void)creatorViewControllerDidCancel:(Trinomial *)triToDelete;

@end
