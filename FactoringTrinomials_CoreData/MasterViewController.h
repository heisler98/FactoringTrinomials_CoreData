//
//  MasterViewController.h
//  FactoringTrinomials_CoreData
//
//  Created by Hunter Eisler on 7/10/13.
//  Copyright (c) 2013 H-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreatorViewController.h"

@interface MasterViewController : UITableViewController <CreatorViewControllerDelegate, NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *triItem;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *firstFlexSpace;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *lastFlexSpace;



@end
