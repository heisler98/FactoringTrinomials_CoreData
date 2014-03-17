//
//  CreatorViewController.m
//  FactoringTrinomials_CoreData
//
//  Created by Hunter Eisler on 7/10/13.
//  Copyright (c) 2013 H-Tech. All rights reserved.
//

#import "CreatorViewController.h"

@interface CreatorViewController ()

@end

@implementation CreatorViewController

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

- (IBAction)handleDoneButtonPushed:(id)sender {
    //dismiss CreatorViewController and pass in needed values to Master View Controller
    //create the object and save the context
    
    [self.currentTri setCreationDate:[NSDate date]];
    
    
    [self.currentTri setATerm:[NSNumber numberWithDouble:[_aTextField.text doubleValue]]];
    
    [self.currentTri setBDisplayTerm:[NSNumber numberWithDouble:[_bTextField.text doubleValue]]];
    [self.currentTri setCDisplayTerm:[NSNumber numberWithDouble:[_cTextField.text doubleValue]]];
    
    
    switch (_bOperand.selectedSegmentIndex) {
        case 0: {
            [self.currentTri setBOperand:@"-"];
            [self.currentTri setBTerm:[NSNumber numberWithDouble:-[_bTextField.text doubleValue]]];
            break;
        
        case 1: {
            [self.currentTri setBOperand:@"+"];
            [self.currentTri setBTerm:[NSNumber numberWithDouble:[_bTextField.text doubleValue]]];
            break;
        }
        
        default:
            NSLog(@"Uh-oh! Something's gone wrong with -[handleDoneButtonPushed:sender] in the switch statement & UISegmentedControls!");
            self.currentTri.bOperand = nil;
            self.currentTri.bDisplayTerm = nil;
            break;
    }
    
}
    
    switch (_cOperand.selectedSegmentIndex) {
        case 0: {
            [self.currentTri setCOperand:@"-"];
            [self.currentTri setCTerm:[NSNumber numberWithDouble:-[_cTextField.text doubleValue]]];
            break;
        }
        case 1: {
            [self.currentTri setCOperand:@"+"];
            [self.currentTri setCTerm:[NSNumber numberWithDouble:[_cTextField.text doubleValue]]];
            break;
        }
        default:
            NSLog(@"Uh-oh! Something's gone wrong with -[handleDoneButtonPushed:sender] in the switch statement & UISegmentedControls!");
            self.currentTri.bOperand = nil;
            self.currentTri.bDisplayTerm = nil;
            break;
    }
    //announce to delegate (MVC) that we are ready to save the context and dismiss the current VC!
    [self.currentTri factorize];
    [self.delegate creatorViewControllerDidSave];
    
    
}

- (IBAction)handleCancelButtonPushed:(id)sender {
    //dismiss VC and remove object
    [self.delegate creatorViewControllerDidCancel:[self currentTri]];
}

@end
