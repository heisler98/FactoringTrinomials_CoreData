//
//  FTMasterViewController.h
//  FactoringTri2
//
//  Created by Hunter Eisler on 3/7/13.
//  Copyright (c) 2013 H-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FTEditorViewDelegate.h"
#import "CCTrinomial.h"
@interface FTMasterViewController : UITableViewController <FTEditorViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSString *trinomialString;
@property (nonatomic, strong) NSMutableArray *trinomials;
@property (nonatomic, strong) CCTrinomial *factoring;
@end
