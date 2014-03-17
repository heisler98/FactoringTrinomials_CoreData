//
//  DetailViewController.h
//  FactoringTrinomials_CoreData
//
//  Created by Hunter Eisler on 7/10/13.
//  Copyright (c) 2013 H-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Trinomial.h"

@interface DetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) Trinomial *currentTri;

@end
