//
//  DetailViewController.m
//  FactoringTrinomials_CoreData
//
//  Created by Hunter Eisler on 7/10/13.
//  Copyright (c) 2013 H-Tech. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () {
    NSArray *cellArray;
}

@end

@implementation DetailViewController

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
    if ([self.currentTri.binomial isEqualToString:@"(x)(x)"]) {
        self.title = @"(x²) Properties";
    } else {
    self.title = [NSString stringWithFormat:@"%@ Properties", [self.currentTri retrieveTrinomial]];
    }
    cellArray = [NSArray arrayWithObjects:@"Binomial Form", @"Operand Type", @"Factorable", @"Solution(s)", nil];
    
    if (self.currentTri.binomial == nil) {
        [self.currentTri factorize];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View delegation

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    
    cell.textLabel.text = [cellArray objectAtIndex:indexPath.row];
    switch (indexPath.row) {
        case 0:
            cell.detailTextLabel.text = [self.currentTri binomial];
            if ([cell.detailTextLabel.text isEqualToString:@""]) {
                cell.detailTextLabel.text = @"n/a";
            }
            break;
        
        case 1:
            cell.detailTextLabel.text = [self.currentTri trinomialOperandType];
            break;
            
        case 2:
            if ([self.currentTri factorable] == YES) {
                cell.detailTextLabel.text = @"Yes";
            } else {
                cell.detailTextLabel.text = @"No";
            }
            break;
            
        case 3: {
            NSArray *sol = [self.currentTri solutions];
            int count = [sol count];
            
            if (count == 0) {
                cell.detailTextLabel.text = @"None";
            } else if (count == 1) {
                cell.detailTextLabel.text = [[sol objectAtIndex:0] stringValue];
            } else if (count == 2) {
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%g, %g", [[sol objectAtIndex:0] doubleValue], [[sol objectAtIndex:1] doubleValue]];
            } else {
                NSLog(@"Error in -[tableView:cellForRowAtIndexPath:] solutions array");
            }
        }
            break;
    }
    return cell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

@end
