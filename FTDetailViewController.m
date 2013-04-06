//
//  FTDetailViewController.m
//  triObjectTri2
//
//  Created by Hunter Eisler on 3/7/13.
//  Copyright (c) 2013 H-Tech. All rights reserved.
// hi

#import "FTDetailViewController.h"


@interface FTDetailViewController () {
    
}
- (void)configureView;
@property (nonatomic, strong) NSArray *cellArray;
@end

@implementation FTDetailViewController
@synthesize triObject;

- (void) masterController:(FTMasterViewController *)masterView willTransitionToDetailWithTrinomial:(CCTrinomial *)trinomialObject {
    if (!self.triObject) {
        self.triObject = [[CCTrinomial alloc] init];
    }
    
    self.triObject.bTerm = trinomialObject.bTerm;
    self.triObject.cTerm = trinomialObject.cTerm;
    self.triObject.bOperand = trinomialObject.bOperand;
    self.triObject.cOperand = trinomialObject.cOperand;
    self.triObject.factorResult = trinomialObject.factorResult;
    

    if (!self.cellArray) {
    self.cellArray = [NSArray arrayWithObjects:@"Binomial Form", @"Type", @"Factorable", @"Solutions", nil];
    }
}


#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    //enter in necessary code for handling trinomials and properties
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.title = [NSString stringWithFormat:@"%@ Properties", [self.triObject retrieveTrinomial]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UITableViewDelegate, DataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    
    cell.textLabel.text = [self.cellArray objectAtIndex:indexPath.row];
    switch (indexPath.row) {
        case 0:
            cell.detailTextLabel.text = [self.triObject factorize:[self.triObject bTerm] with:[self.triObject cTerm]];
            if ([cell.detailTextLabel.text isEqualToString:@""]) {
                cell.detailTextLabel.text = @"n/a";
            }
            break;
        case 1:
            if ([[self.triObject bOperand]isEqualToString:@"+"] && [[self.triObject cOperand] isEqualToString:@"+"]) {
                cell.detailTextLabel.text = @"+, +";
            } else if ([[self.triObject bOperand] isEqualToString:@"+"] && [[self.triObject cOperand] isEqualToString:@"-"]) {
                cell.detailTextLabel.text = @"+, -";
            } else if ([[self.triObject bOperand] isEqualToString:@"-"] && [[self.triObject cOperand] isEqualToString:@"+"]) {
                cell.detailTextLabel.text = @"-, +";
            } else if ([[self.triObject bOperand] isEqualToString:@"-"] && [[self.triObject cOperand]isEqualToString:@"-"]) {
                cell.detailTextLabel.text = @"-, -";
            }
            break;
        case 2:
            if ([self.triObject factorable] == YES) {
                cell.detailTextLabel.text = @"Yes";
            } else if ([self.triObject factorable] == NO) {
                cell.detailTextLabel.text = @"No";
            }
            break;
        case 3:
            if ([[self.triObject calculateDiscriminant:[self.triObject bTerm] with:[self.triObject cTerm]] isEqualToString:@"2"]) {
                cell.detailTextLabel.text = @"2 solutions";
            } else if ([[self.triObject calculateDiscriminant:[self.triObject bTerm] with:[self.triObject cTerm]] isEqualToString:@"1"]) {
                cell.detailTextLabel.text = @"1 solution";
            } else if ([[self.triObject calculateDiscriminant:[self.triObject bTerm] with:[self.triObject cTerm]] isEqualToString:@"0"]) {
                cell.detailTextLabel.text = @"No solutions";
            } else if ([[self.triObject calculateDiscriminant:[self.triObject bTerm] with: [self.triObject cTerm]] isEqualToString:@"ERROR"]) {
                cell.detailTextLabel.text = @"";
            } else {
                cell.detailTextLabel.text = @"Error";
            }
            break;
        default:
            NSLog(@"Error in array");
            
            break;
    }
    
    
    return cell;

}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

@end
