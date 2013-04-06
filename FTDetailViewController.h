//
//  FTDetailViewController.h
//  FactoringTri2
//
//  Created by Hunter Eisler on 3/7/13.
//  Copyright (c) 2013 H-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCTrinomial.h"
@class FTMasterViewController;
@interface FTDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) id detailItem;
@property (nonatomic, strong) CCTrinomial *triObject;

-(void) masterController:(FTMasterViewController *)masterView willTransitionToDetailWithTrinomial:(CCTrinomial *)trinomialObject;
@end
