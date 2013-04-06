//
//  FTEditorViewController.m
//  FactoringTri2
//
//  Created by Hunter Eisler on 3/7/13.
//  Copyright (c) 2013 H-Tech. All rights reserved.
//

#import "FTEditorViewController.h"
#import "CCTrinomial.h"
#import "FTMasterViewController.h"
@interface FTEditorViewController () {

}
@property (nonatomic, strong) CCTrinomial *factoring;
@end

@implementation FTEditorViewController
@synthesize bTriField, cTriField, factoring, picker, pickerSourceArray, holdBValue, holdCValue, bPlusMinusField, cPlusMinusField, editorTriArray;

-(IBAction)handleDoneButtonPushed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
    NSString *trinomialString = [NSString stringWithFormat:@"x² %@ %g %@ %g", bPlusMinusField.text, [bTriField.text doubleValue], cPlusMinusField.text, [cTriField.text doubleValue]];
    
    [self.delegate editorController:self didCompleteEditingTrinomial:trinomialString withBOperand:bPlusMinusField.text andWithBTerm:[bTriField.text doubleValue] andWithCOperand:cPlusMinusField.text andWithCTerm:[cTriField.text doubleValue]];
    
    
}


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
    self.picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 210)];
    self.picker.dataSource = self;
    self.picker.delegate = self;
    
    self.bPlusMinusField.textAlignment = NSTextAlignmentCenter;
    self.cPlusMinusField.textAlignment = NSTextAlignmentCenter;
    
    //setup the source array
    self.pickerSourceArray = [[NSArray alloc] initWithObjects:@"+", @"-", nil];
    
    //setup inputView
    self.bPlusMinusField.inputView = self.picker;
    self.cPlusMinusField.inputView = self.picker;
    
    self.picker.showsSelectionIndicator = YES;
    [self.picker selectRow:0 inComponent:0 animated:NO];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)keyboardButton:(id)sender {
    [bTriField resignFirstResponder];
    [cTriField resignFirstResponder];
    [bPlusMinusField resignFirstResponder];
    [cPlusMinusField resignFirstResponder];
}
-(IBAction) factorTestButtonPushed:(id)sender {
    //declare vars
    double bFieldValueTemp, cFieldValueTemp;
    UIAlertView *alert;
    //dismiss keyboard
    [bTriField resignFirstResponder];
    [cTriField resignFirstResponder];
    [bPlusMinusField resignFirstResponder];
    [cPlusMinusField resignFirstResponder];
    
    //init the object
    self.factoring = [[CCTrinomial alloc] init];
    
    //test for no binomial result
    
    //test for +/-
    if ([self.bPlusMinusField.text isEqualToString:[self.pickerSourceArray objectAtIndex:0]] && [self.cPlusMinusField.text isEqualToString:[self.pickerSourceArray objectAtIndex:0]] && [[self.factoring factorize:[bTriField.text doubleValue] with:[cTriField.text doubleValue]] compare:@""]) {
        alert = [[UIAlertView alloc] initWithTitle:@"Result of Operation" message:[self.factoring factorize:[bTriField.text doubleValue] with:[cTriField.text doubleValue]] delegate:nil cancelButtonTitle:@"OK!" otherButtonTitles:nil];
        [alert show];
    }
    else if ([[self.factoring factorize:[bTriField.text doubleValue] with:[cTriField.text doubleValue]] isEqualToString:@""]) {
        UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"This trinomial cannot be factored with the given formula." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [errorView show];
    
    } else if ([self.bPlusMinusField.text isEqualToString:[self.pickerSourceArray objectAtIndex:1]] && [self.cPlusMinusField.text isEqualToString:[self.pickerSourceArray objectAtIndex:1]]) {
        bFieldValueTemp = -[bTriField.text doubleValue];
        cFieldValueTemp = -[cTriField.text doubleValue];
        alert = [[UIAlertView alloc] initWithTitle:@"Result of Operation" message:[self.factoring factorize:bFieldValueTemp with:cFieldValueTemp] delegate:nil cancelButtonTitle:@"OK!" otherButtonTitles: nil];
        [alert show];
    }
    else if ([[self.factoring factorize:-[bTriField.text doubleValue] with:-[cTriField.text doubleValue]] isEqualToString:@""]) {
            UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"This trinomial cannot be factored with the given formula." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [errorView show];
        
    } else if ([self.bPlusMinusField.text isEqualToString:[self.pickerSourceArray objectAtIndex:0]] && [self.cPlusMinusField.text isEqualToString:[self.pickerSourceArray objectAtIndex:1]]) {
        bFieldValueTemp = [bTriField.text doubleValue];
        cFieldValueTemp = -[cTriField.text doubleValue];
        alert = [[UIAlertView alloc] initWithTitle:@"Result of Operation" message:[self.factoring factorize:bFieldValueTemp with:cFieldValueTemp] delegate:nil cancelButtonTitle:@"OK!" otherButtonTitles: nil];
        [alert show];
    }
        else if ([[self.factoring factorize:[bTriField.text doubleValue] with:-[cTriField.text doubleValue]] isEqualToString:@""]) {
            UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"This trinomial cannot be factored with the given formula." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [errorView show];
        
    } else if ([self.bPlusMinusField.text isEqualToString:[self.pickerSourceArray objectAtIndex:1]] && [self.cPlusMinusField.text isEqualToString:[self.pickerSourceArray objectAtIndex:0]]) {
        bFieldValueTemp = -[bTriField.text doubleValue];
        cFieldValueTemp = [cTriField.text doubleValue];
        alert = [[UIAlertView alloc] initWithTitle:@"Result of Operation" message:[self.factoring factorize:bFieldValueTemp with:cFieldValueTemp] delegate:nil cancelButtonTitle:@"OK!" otherButtonTitles: nil];
    }
    else if ([[self.factoring factorize:-[bTriField.text doubleValue] with:[cTriField.text doubleValue]] isEqualToString:@""]) {
            UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"This trinomial cannot be factored with the given formula." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [errorView show];
        

    } else {
        UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"The supplied trinomial is invalid and cannot be factored." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [errorView show];
    }

}

#pragma mark <UIPickerViewDelegate, UIPickerViewDataSource>

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.pickerSourceArray count];
}

-(CGFloat) pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 50;
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.pickerSourceArray objectAtIndex:row];
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if ([self.picker selectedRowInComponent:0] == 0 && [self.bPlusMinusField isFirstResponder]) {
        self.bPlusMinusField.text = [self.pickerSourceArray objectAtIndex:0];
    } else if ([self.picker selectedRowInComponent:0] == 0 && [self.cPlusMinusField isFirstResponder]) {
        self.cPlusMinusField.text = [self.pickerSourceArray objectAtIndex:0];
    } else if ([self.picker selectedRowInComponent:0] == 1 && [self.bPlusMinusField isFirstResponder]) {
        self.bPlusMinusField.text = [self.pickerSourceArray objectAtIndex:1];
    } else if ([self.picker selectedRowInComponent:0] == 1 && [self.cPlusMinusField isFirstResponder]) {
        self.cPlusMinusField.text = [self.pickerSourceArray objectAtIndex:1];
    }

  
}
@end
