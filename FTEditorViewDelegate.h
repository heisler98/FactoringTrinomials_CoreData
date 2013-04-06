//
//  FTEditorViewDelegate.h
//  FactoringTri2
//
//  Created by Hunter Eisler on 3/8/13.
//  Copyright (c) 2013 H-Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CCTrinomial, FTMasterViewController, FTEditorViewController;
@protocol FTEditorViewDelegate <NSObject>

@optional
-(void) editorController:(FTEditorViewController *)editorController didCompleteEditingTrinomial:(NSString *)trinomial withBOperand:(NSString *)bOperandTerm andWithBTerm:(double)bEnteredTerm andWithCOperand:(NSString *)cOperandTerm andWithCTerm:(double)cEnteredTerm;

@end
