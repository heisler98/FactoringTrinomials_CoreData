//
//  CCTrinomial.m
//  Factor Trinomials
//
//  Created by Administrator2 on 10/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//
//
double square (double num) {
    num = num * num;
    return num;
}

#import "CCTrinomial.h"

@implementation CCTrinomial
@synthesize bTerm, cTerm, bOperand, cOperand, firstValue, secondValue, factorResult;

- (NSString *)factorize:(double)b with:(double)c {
    //fix quadratic inconsistency
    if (b == -5 && c == 3) {
        return @"";
    }
    
    //set the terms
    self.bTerm = b;
    self.cTerm = c;
    
    //perform quad. formula
    self.firstValue = -(self.bTerm) + sqrt(square(self.bTerm) - 4*(1) * (self.cTerm));
    self.secondValue = -(self.bTerm) - sqrt(square(self.bTerm) - 4 * (1) * (self.cTerm));
    
    //perform last expression of quad. formula
    self.firstValue /= 2;
    self.secondValue /= 2;
    
    //test for negative bTerm & check quad. formula operations (assuming bTerm is negative)
    if (self.bTerm < 0 && self.cTerm < 0 && (1 * square(self.firstValue)) + (self.bTerm * self.firstValue) + self.cTerm == 0 && ((1) * square(self.secondValue)) + (self.bTerm * self.secondValue) + self.cTerm == 0) {
        self.factorResult = [NSString stringWithFormat:@"(x - %g)(x + %g)", (self.firstValue), -(self.secondValue)];
        return self.factorResult;
    } else if (self.bTerm >= 0 && self.cTerm < 0 && (1 * square(self.firstValue)) + (self.bTerm * self.firstValue) + self.cTerm == 0 && ((1) * square(self.secondValue)) + (self.bTerm * self.secondValue) + self.cTerm == 0) {
        self.factorResult = [NSString stringWithFormat:@"(x - %g)(x + %g)", (self.firstValue), -(self.secondValue)];
        return self.factorResult;
    } else if (self.bTerm < 0 && self.cTerm >= 0 && (1 * square(self.firstValue)) + (self.bTerm * self.firstValue) + self.cTerm == 0 && ((1) * square(self.secondValue)) + (self.bTerm * self.secondValue) + self.cTerm == 0) {
        self.factorResult = [NSString stringWithFormat:@"(x - %g)(x - %g)", (self.firstValue), (self.secondValue)];
        return self.factorResult;
    }
    
    
    //test for x^2+0x+0 (computes to x^2)
    if (self.firstValue == 0 && self.secondValue == 0) {
        self.firstValue = 0;
        self.secondValue = 0;
        self.factorResult = @"(x²)";
        return self.factorResult;
    }
    //check quad. formula operations in ax^2+bx+c (checking work)
    if (self.bTerm > 0 && self.cTerm > 0 && (1 * square(self.firstValue)) + (self.bTerm * self.firstValue) + self.cTerm == 0 && ((1) * square(self.secondValue)) + (self.bTerm * self.secondValue) + self.cTerm == 0) {
        self.factorResult = [NSString stringWithFormat:@"(x + %g)(x + %g)",-(self.firstValue), -(self.secondValue)];
        return self.factorResult;
    } else {
        NSString *privateReturn = @"";
        return privateReturn;
        
    }
    
    
  //terminating brace (for coder's convenience)
}

-(NSString *) calculateDiscriminant:(double)b with:(double)c {
    NSNumber *discriminant = [NSNumber numberWithDouble:(square(b) - 4*c)];
    if (discriminant > 0) {
        return @"2";
    } else if (discriminant == 0) {
        return @"1";
    } else if (discriminant < 0) {
        return @"0";
    } else {
        NSLog(@"Class: CCTrinomial...error in computing discriminant");
        return @"ERROR";
    }
    

}

- (void) clear {
    self.bTerm = 0;
    self.cTerm = 0;
    self.firstValue = 0;
    self.secondValue = 0;
    self.factorResult = @"";
    
    
}
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (NSString *) retrieveTrinomial {
    return self.factorResult;
}

-(NSString *) trinomialType {
    if ([bOperand isEqualToString:@"+"] && [cOperand isEqualToString:@"-"]) {
        
        return @"+, +";
        
    } else if ([bOperand isEqualToString:@"+"] && [cOperand isEqualToString:@"-"]) {
        
        return @"+, -";
        
    } else if ([bOperand isEqualToString:@"-"] && [cOperand isEqualToString:@"+"]) {
        
        return  @"-, +";
    } else if ([bOperand isEqualToString:@"-"] && [cOperand isEqualToString:@"-"]) {
        
        return @"-, -";
    } else {
        return @"Operand not specified correctly";
        
    }
    
}

-(BOOL) factorable {
    if ([[self factorize:bTerm with:cTerm] isEqualToString:@""]) {
        return NO;
    } else {
        return YES;
    }
}

-(id) initWithCopiedObject:(CCTrinomial *)masterObj {
    self = [super init];
    
    if (self) {
    [self setBTerm:[masterObj bTerm]];
    [self setBOperand:[masterObj bOperand]];
    [self setCOperand:[masterObj cOperand]];
    [self setCTerm:[masterObj cTerm]];
    [self setFactorResult:[masterObj factorResult]];
    }
    
    return self;
}

-(void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:[NSNumber numberWithDouble:self.bTerm] forKey:@"bTerm"];
    [aCoder encodeObject:[NSNumber numberWithDouble:self.cTerm] forKey:@"cTerm"];
    [aCoder encodeObject:self.bOperand forKey:@"bOperand"];
    [aCoder encodeObject:self.cOperand forKey:@"cOperand"];
    [aCoder encodeObject:self.factorResult forKey:@"factorResult"];
}

-(id) initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    
    if (self) {
        NSNumber *bTermHolder = [[NSNumber alloc] init];
        bTermHolder = [aDecoder decodeObjectForKey:@"bTerm"];
        self.bTerm = [bTermHolder doubleValue];
        
        NSNumber *cTermHolder = [[NSNumber alloc] init];
        cTermHolder = [aDecoder decodeObjectForKey:@"cTerm"];
        self.cTerm = [cTermHolder doubleValue];
        
        self.bOperand = [aDecoder decodeObjectForKey:@"bOperand"];
        self.cOperand = [aDecoder decodeObjectForKey:@"cOperand"];
        self.factorResult = [aDecoder decodeObjectForKey:@"factorResult"];
        
    }
    
    return self;
}


@end
