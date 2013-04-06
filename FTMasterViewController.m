//
//  FTMasterViewController.m
//  FactoringTri2
//
//  Created by Hunter Eisler on 3/7/13.
//  Copyright (c) 2013 H-Tech. All rights reserved.
//

#import "FTMasterViewController.h"
#import "FTDetailViewController.h"

@interface FTMasterViewController () {
    NSMutableArray *_objects;
    
}
@property (nonatomic, strong) NSString *trinomialHolder;
@end

@implementation FTMasterViewController
@synthesize trinomialString, trinomials;

-(void)editorController:(FTEditorViewController *)editorController didCompleteEditingTrinomial:(NSString *)trinomial withBOperand:(NSString *)bOperandTerm andWithBTerm:(double)bEnteredTerm andWithCOperand:(NSString *)cOperandTerm andWithCTerm:(double)cEnteredTerm {

    if (!self.trinomials) {
        self.trinomials = [[NSMutableArray alloc] init];
    } if (!self.factoring) {
        self.factoring = [[CCTrinomial alloc] init];
    }
    
    self.trinomialHolder = [NSString stringWithString:trinomial];
    
    [self.factoring setBTerm:bEnteredTerm];
    [self.factoring setCTerm:cEnteredTerm];
    
    [self.factoring setBOperand:bOperandTerm];
    [self.factoring setCOperand:cOperandTerm];
    [self.factoring setFactorResult:[NSString stringWithString:trinomial]];
    
    [self.trinomials insertObject:self.factoring atIndex:0];
    [self.tableView reloadData];

}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
*/
#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.trinomials count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[[self.trinomials objectAtIndex:indexPath.row] factorResult]];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.trinomials removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/
/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        //pass in trinomial
        [[segue destinationViewController] masterController:self willTransitionToDetailWithTrinomial:self.factoring];
        
    }
    
    if ([[segue identifier] isEqualToString:@"addToEditorView"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
    [self performSegueWithIdentifier:@"showDetail" sender:tableView];
    //also say: tableView.indexPathforSelectedRow
}


/*
-(id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
    self.trinomials = [NSArray arrayWithArray:[aDecoder decodeObjectForKey:@"trinomialArray"]];
    self.bTermArray = [NSArray arrayWithArray:[aDecoder decodeObjectForKey:@"bTermArray"]];
    self.cTermArray = [NSArray arrayWithArray:[aDecoder decodeObjectForKey:@"cTermArray"]];
    self.bOperandArray = [NSArray arrayWithArray:[aDecoder decodeObjectForKey:@"bOperandArray"]];
    self.cOperandArray = [NSArray arrayWithArray:[aDecoder decodeObjectForKey:@"cOperandArray"]];
    }
    return self;
    
}

-(void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.trinomials forKey:@"trinomialArray"];
    [aCoder encodeObject:self.bTermArray forKey:@"bTermArray"];
    [aCoder encodeObject:self.cTermArray forKey:@"cTermArray"];
    [aCoder encodeObject:self.bOperandArray forKey:@"bOperandArray"];
    [aCoder encodeObject:self.cOperandArray forKey:@"cOperandArray"];
}

*/


@end
