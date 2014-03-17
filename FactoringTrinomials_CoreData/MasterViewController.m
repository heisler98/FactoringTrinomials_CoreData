//
//  MasterViewController.m
//  FactoringTrinomials_CoreData
//
//  Created by Hunter Eisler on 7/10/13.
//  Copyright (c) 2013 H-Tech. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Trinomial.h"


@interface MasterViewController ()

@end

@implementation MasterViewController
@synthesize fetchedResultsController = _fetchedResultsController;

#pragma mark - Creator View Controller delegate methods

-(void) creatorViewControllerDidCancel:(Trinomial *)triToDelete {
    //delete the object!
    [_managedObjectContext deleteObject:triToDelete];
    
    //dismiss the VC!
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void) creatorViewControllerDidSave {
    NSError *error = nil;
    NSManagedObjectContext *context = self.managedObjectContext;
    if (![context save:&error]) {
        NSLog(@"An error occurred saving the managedObjectContext: %@", error);
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    NSError *error = nil;
    if (![[self fetchedResultsController] performFetch:&error]) {
        NSLog(@"An error occurred: %@", error);
#warning Use of 'abort' only acceptable in app debugging
        abort();
    }
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.toolbarHidden = NO;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Trinomial" inManagedObjectContext:[self managedObjectContext]];
    [fetchRequest setEntity:entity];
    NSError *error = nil;
    NSUInteger count = [_managedObjectContext countForFetchRequest:fetchRequest error:&error];
    
    
    
    if (count == 1) {
        _triItem.title = [NSString stringWithFormat:@"%i trinomial", count];
    } else {
        _triItem.title = [NSString stringWithFormat:@"%i trinomials", count];
    }
    
    self.toolbarItems = [NSArray arrayWithObjects:_firstFlexSpace, _triItem, _lastFlexSpace, nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Trinomial" inManagedObjectContext:[self managedObjectContext]];
    [fetchRequest setEntity:entity];
    NSError *error = nil;
    return [_managedObjectContext countForFetchRequest:fetchRequest error:&error];
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Trinomial *tri = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [tri factorize];
    if ([tri.binomial isEqualToString:@"(x)(x)"]) {
        cell.textLabel.text = @"(x²)";
    } else {
        cell.textLabel.text = [tri retrieveTrinomial];
        }
    return cell;
}


#pragma mark - Fetched Results Controller section

- (NSFetchedResultsController *) fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Trinomial"
                                              inManagedObjectContext:[self managedObjectContext]];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"creationDate"
                                                                   ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];

    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[self managedObjectContext] sectionNameKeyPath:nil cacheName:nil];
    
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}


- (void) controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void) controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

- (void) controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        
        case NSFetchedResultsChangeDelete: {
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"Trinomial" inManagedObjectContext:[self managedObjectContext]];
            [fetchRequest setEntity:entity];
            NSError *error = nil;
            NSUInteger count = [_managedObjectContext countForFetchRequest:fetchRequest error:&error];
            if (count == 1) {
                _triItem.title = @"1 trinomial";
            } else {
                _triItem.title = [NSString stringWithFormat:@"%i trinomials", count];
            }
            
        }
            break;
            
        case NSFetchedResultsChangeUpdate: {
            Trinomial *changedTri = [self.fetchedResultsController objectAtIndexPath:indexPath];
            if ([changedTri.binomial isEqualToString:@"(x)(x)"]) {
                [tableView cellForRowAtIndexPath:indexPath].textLabel.text = @"(x²)";
            } else {
            [tableView cellForRowAtIndexPath:indexPath].textLabel.text = [changedTri retrieveTrinomial];
            }
        }
            break;
        
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            NSLog(@"Unsupported change type in -[controller:didChangeObject:atIndexPath:forChangeType:newIndexPath:] in MVC");
            break;
    }
}

- (void) controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            NSLog(@"I wouldn't be surprised...there's an error with the section change method in MVC");
            break;
    }
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        Trinomial *triToDelete = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [_managedObjectContext deleteObject:triToDelete];
        
        NSError *error = nil;
        if (![_managedObjectContext save:&error]) {
            NSLog(@"An error occurred: %@", error);
        }
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
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showCreator"]) {
        CreatorViewController *cvc = (CreatorViewController *)[segue destinationViewController];
        cvc.delegate = self;
        Trinomial *newTri = (Trinomial *)[NSEntityDescription insertNewObjectForEntityForName:@"Trinomial" inManagedObjectContext:self.managedObjectContext];
        cvc.currentTri = newTri;
    }
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        DetailViewController *dvc = (DetailViewController *)[segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Trinomial *selectedTri = (Trinomial *)[self.fetchedResultsController objectAtIndexPath:indexPath];
        dvc.currentTri = selectedTri;
    }
    
}



@end
