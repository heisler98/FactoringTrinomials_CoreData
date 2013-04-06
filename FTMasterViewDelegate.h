//
//  FTMasterViewDelegate.h
//  FactoringTri2
//
//  Created by Hunter Eisler on 3/9/13.
//  Copyright (c) 2013 H-Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FTMasterViewController, CCTrinomial;

@protocol FTMasterViewDelegate <NSObject>
@optional
-(void) masterController:(FTMasterViewController *)masterView willTransitionToDetailWithTrinomial:(CCTrinomial *)trinomialObject;

@end
