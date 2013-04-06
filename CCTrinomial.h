//
//  CCTrinomial.h
//  Factor Trinomials
//
//  Created by Administrator2 on 10/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CCTrinomial : NSObject <NSCoding>{
    UIAlertView *errorAlert;
    }
//declare term properties
@property (nonatomic) double cTerm, bTerm;
@property (nonatomic, strong) NSString *bOperand, *cOperand;
//declare misc. properties
@property (nonatomic) double firstValue, secondValue;
@property (nonatomic, weak) NSString *factorResult;


-(NSString *) factorize:(double) b with:(double) c;
-(void) clear;
-(NSString *) retrieveTrinomial;

//properties of trinomial methods
-(NSString *) calculateDiscriminant:(double) b with:(double) c;
-(NSString *) trinomialType;
-(BOOL) factorable;
-(id) initWithCopiedObject:(CCTrinomial *)masterObj;

@end
