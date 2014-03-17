//
//  AppDelegate.h
//  FactoringTrinomials_CoreData
//
//  Created by Hunter Eisler on 7/9/13.
//  Copyright (c) 2013 H-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasterViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
