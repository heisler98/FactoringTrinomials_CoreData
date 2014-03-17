//
//  Trinomial.h
//  FactoringTrinomials_CoreData
//
//  Created by Hunter Eisler on 7/9/13.
//  Copyright (c) 2013 H-Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Trinomial : NSManagedObject

@property (nonatomic, retain) NSString * bOperand;
@property (nonatomic, retain) NSNumber * bTerm;
@property (nonatomic, retain) NSString * cOperand;
@property (nonatomic, retain) NSNumber * cTerm;
@property (nonatomic, retain) NSString * binomial;
@property (nonatomic, retain) NSNumber * bDisplayTerm;
@property (nonatomic, retain) NSNumber * cDisplayTerm;
@property (nonatomic, retain) NSDate *creationDate;
@property (nonatomic, retain) NSNumber * aTerm;

- (NSString *) factorize;
- (NSString *) retrieveTrinomial;
- (NSNumber *) discriminant;
- (NSArray *) solutions;
- (NSString *) trinomialOperandType;
- (BOOL) factorable;



@end
