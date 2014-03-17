//
//  Trinomial.m
//  FactoringTrinomials_CoreData
//
//  Created by Hunter Eisler on 7/9/13.
//  Copyright (c) 2013 H-Tech. All rights reserved.
//

#import "Trinomial.h"

double square (double num) {
    double result = num * num;
    return result;
}

int gcdForNumbers (int m, int n)
{
    int temp;
    while (n != 0) {
        temp = n;
        n = m % temp;
        m = temp;
    }
    return m;
}

int tenRaisedToPower (int decimalLength)
{
    int answer = 10;
    while (decimalLength != 1) {
        answer *= 10;
        decimalLength --;
    }
    return answer;
}

NSArray* numberToFraction (NSNumber *number)
{
    
    NSString *decimalString = [NSString stringWithFormat:@"%f", [number floatValue]];
    NSArray *components = [decimalString componentsSeparatedByString:@"."];
    NSUInteger decimalLength = [[components objectAtIndex:1] length];
    NSUInteger n = tenRaisedToPower((int)decimalLength);
    int m = [[components objectAtIndex:1] intValue];
    int gcd = gcdForNumbers(m, (int)n);
    int numer = m/gcd;
    int deno = (int)n/gcd;
    int fractionnumer;
    if ([number floatValue] < 0) {
        fractionnumer = ([[components objectAtIndex:0] intValue] * deno) - numer;
    } else {
        fractionnumer = ([[components objectAtIndex:0] intValue] * deno) + numer;
    }
    NSNumber *numerator = [NSNumber numberWithInteger:fractionnumer];
    NSNumber *denominator = [NSNumber numberWithInteger:deno];
    return [NSArray arrayWithObjects:numerator, denominator, nil];
}


@interface Trinomial ()
+ (NSDictionary *) quadFormula: (NSNumber*) aTerm withBTerm: (NSNumber *)bTerm withCTerm: (NSNumber *)cTerm;
+ (NSDictionary *) borrowAndReturn: (NSNumber *)aTerm withBTerm: (NSNumber *)bTerm withCTerm: (NSNumber *) cTerm;

@end

@implementation Trinomial

@dynamic bOperand;
@dynamic bTerm;
@dynamic cOperand;
@dynamic cTerm;
@dynamic binomial;
@dynamic bDisplayTerm, cDisplayTerm;
@dynamic creationDate;
@dynamic aTerm;


- (NSString *) factorize {
    
    //perform quadratic formula
    NSDictionary *quadDict = [Trinomial quadFormula:self.aTerm withBTerm:self.bTerm withCTerm:self.cTerm];
    
    if (quadDict == nil) {
        self.binomial = @"";
        return self.binomial;
    }
    
    self.binomial = [quadDict objectForKey:@"binomial"]; 
    
    if ([self.bTerm doubleValue] < 0) {
        self.bDisplayTerm = [NSNumber numberWithDouble:(-[self.bTerm doubleValue])];
    } else {
        self.bDisplayTerm = self.bTerm;
    }
    
    if ([self.cTerm doubleValue] < 0) {
        self.cDisplayTerm = [NSNumber numberWithDouble:(-[self.cTerm doubleValue])];
    } else {
        self.cDisplayTerm = self.cTerm;
    }
    
    return self.binomial;
}

- (NSString *) retrieveTrinomial {
    if ([self.aTerm doubleValue] != 1) {
        return [NSString stringWithFormat:@"%gx² %@ %gx %@ %g", [self.aTerm doubleValue], self.bOperand, [self.bDisplayTerm doubleValue], self.cOperand, [self.cDisplayTerm doubleValue]];
    }
    return [NSString stringWithFormat:@"x² %@ %gx %@ %g", self.bOperand, [self.bDisplayTerm doubleValue], self.cOperand, [self.cDisplayTerm doubleValue]];
}

- (NSNumber *) discriminant {
    
    double discriminant = ((square([self.bTerm doubleValue])) - ((4) * ([self.cTerm doubleValue])));
    
    if (discriminant > 0) {
        return [NSNumber numberWithDouble:2];
    } else if (discriminant == 0) {
        return [NSNumber numberWithDouble:1];
    } else if (discriminant < 0) {
        return [NSNumber numberWithDouble:0];
    } else {
        return nil;
    }
                                                                 
}

- (NSArray *) solutions {
    NSDictionary *solveDict = [Trinomial quadFormula:self.aTerm withBTerm:self.bTerm withCTerm:self.cTerm];
    NSNumber *plusValue, *minusValue;
    
    if ([self.aTerm doubleValue] == 1) {
        plusValue = [solveDict objectForKey:@"plusValue"];
        minusValue = [solveDict objectForKey:@"minusValue"];
    } else {
        plusValue = [solveDict objectForKey:@"firstSolution"];
        minusValue = [solveDict objectForKey:@"secondSolution"];
    }
    [self factorize];
        if ([self.bTerm doubleValue] == 0 && [self.cTerm doubleValue] == 0) {
            if ([self.binomial isEqualToString:@"(x)(x)"]) {
                double testforx = 0;
                return [NSArray arrayWithObject:[NSNumber numberWithDouble:testforx]];
            }}
    //0 solutions
    if ([[self discriminant] doubleValue] == 0) {
        return nil;
    }
    
    //1 solution
    if ([[self discriminant] doubleValue] == 1) {
        return [NSArray arrayWithObject:plusValue];
    }
    
    //2 solutions
    if ([plusValue doubleValue] == [minusValue doubleValue] && [[self discriminant] doubleValue] == 2) {
        return [NSArray arrayWithObject:plusValue];
    } else {
        return [NSArray arrayWithObjects:plusValue, minusValue, nil];
    }
    return nil;
            
}

- (NSString *) trinomialOperandType {
    return [NSString stringWithFormat:@"%@, %@", self.bOperand, self.cOperand];
}


- (BOOL) factorable {
    if ([Trinomial quadFormula:self.aTerm withBTerm:self.bTerm withCTerm:self.cTerm] == nil) {
        return NO;
    }
    return YES;
}

+ (NSDictionary *) quadFormula:(NSNumber *)aTerm withBTerm:(NSNumber *)bTerm withCTerm:(NSNumber *)cTerm
{
    //temp vars
    double plusValue = 0, minusValue = 0, a = [aTerm doubleValue], b = [bTerm doubleValue], c = [cTerm doubleValue];
    NSString *firstBinomialOperand, *secondBinomialOperand, *binomial;
    //vars in ifs
    NSNumber *pValue, *mValue;
    NSArray *objectsToDict, *keysToDict = @[@"firstBinomialOperand", @"secondBinomialOperand", @"binomial", @"plusValue", @"minusValue"];
    NSDictionary *triDict;

    switch ([aTerm intValue]) {
        case 1:
            //perform quadratic formula
            plusValue = -(b) + sqrt(square(b) - 4*(a) * c);
            plusValue /= (2*a);
            
            minusValue = -(b) - sqrt(square(b) - 4*(a) * c);
            minusValue /= (2*a);
            
            //encapsulating doubles into NSNumbers for dict. transfer
            pValue = [NSNumber numberWithDouble:plusValue];
            mValue = [NSNumber numberWithDouble:minusValue];
            if ([pValue doubleValue] - [pValue integerValue] != 0) {
                return nil;
            }
            
            if ([mValue doubleValue] - [mValue integerValue] != 0) {
                return nil;
            }
            //perform p/m values w/o aTerm business
            if (b < 0 && c < 0 && (square(plusValue)) + (b * plusValue) + c == 0 && (square(minusValue)) + (b * minusValue) + c == 0)
            {
                firstBinomialOperand = @"-";
                secondBinomialOperand = @"+";
                binomial = [NSString stringWithFormat:@"(x - %g)(x + %g)", plusValue, -minusValue];
                //prepare array for dict.
                objectsToDict = @[firstBinomialOperand, secondBinomialOperand, binomial, pValue, mValue];
                //return dict.
                triDict = [NSDictionary dictionaryWithObjects:objectsToDict forKeys:keysToDict];
                return triDict;
                //second else-if
            } else if (b >= 0 && c < 0 && (square(plusValue)) + (b * plusValue) + c == 0 && (square(minusValue)) + (b * minusValue) + c == 0)
            {
                firstBinomialOperand = @"-";
                secondBinomialOperand = @"+";
                binomial = [NSString stringWithFormat:@"(x - %g)(x + %g)", plusValue, -minusValue];
                //prepare array for dict.
                objectsToDict = @[firstBinomialOperand, secondBinomialOperand, binomial, pValue, mValue];
                //return dict.
                triDict = [NSDictionary dictionaryWithObjects:objectsToDict forKeys:keysToDict];
                return triDict;
                //third else-if
            } else if (b < 0 && c >= 0 && (square(plusValue)) + (b * plusValue) + c == 0 && (square(minusValue)) + (b * minusValue) + c == 0)
            {
                firstBinomialOperand = @"-";
                secondBinomialOperand = @"-";
                binomial = [NSString stringWithFormat:@"(x - %g)(x - %g)", plusValue, minusValue];
                //prepare array for dict.
                objectsToDict = @[firstBinomialOperand, secondBinomialOperand, binomial, pValue, mValue];
                //return dict.
                triDict = [NSDictionary dictionaryWithObjects:objectsToDict forKeys:keysToDict];
                return triDict;
            } else if (b == 0 && c == 0) {
                plusValue = 0;
                minusValue = 0;
                firstBinomialOperand = @"+";
                secondBinomialOperand = @"+";
                binomial = @"(x²)";
                //prepare array for dict.
                objectsToDict = @[firstBinomialOperand, secondBinomialOperand, binomial, pValue, mValue];
                //return dict.
                triDict = [NSDictionary dictionaryWithObjects:objectsToDict forKeys:keysToDict];
                return triDict;
            } else if (b > 0 && c > 0 && (square(plusValue)) + (b * plusValue) + c == 0 && (square(minusValue)) + (b * minusValue) + c == 0) {
                
                firstBinomialOperand = @"+";
                secondBinomialOperand = @"+";
                binomial = [NSString stringWithFormat:@"(x + %g)(x + %g)", -plusValue, -minusValue];
                //prepare array for dict.
                objectsToDict = @[firstBinomialOperand, secondBinomialOperand, binomial, pValue, mValue];
                //return dict.
                triDict = [NSDictionary dictionaryWithObjects:objectsToDict forKeys:keysToDict];
                return triDict;
                
            } else {
                return nil;
                break;
            }
            
            
        default:
            //this case is if the a-term isn't one
            //redirects to new function that can call quadForm again without term larger than 1 (borrow & return)

            triDict = [NSDictionary dictionaryWithDictionary:[Trinomial borrowAndReturn:aTerm withBTerm:bTerm withCTerm:cTerm]];

            if (triDict == nil) {
                return nil;
            } else {
                return triDict;
            }
            
            break;
    }
    NSLog(@"There was an error in quadFormula().");
    NSLog(@"Possible issue: no aTerm values were present.");
    NSLog(@"Possible solution: require text field values in UI.");
    return nil;
    
}
    
+ (NSDictionary *) borrowAndReturn:(NSNumber *)aTerm withBTerm:(NSNumber *)bTerm withCTerm:(NSNumber *)cTerm {
    
    
    if ([aTerm doubleValue] == 1) {
        //invalid catch...
        NSLog(@"Error! Invalid borrowAndReturn() call in Trinomial.h");
#warning Use of 'abort()' only acceptable in app debugging
        abort();
    }
    
    //declare function vars
    double a = [aTerm doubleValue], b = [bTerm doubleValue], c = [cTerm doubleValue];
    double acTemp, apaTemp, acsTemp;
    int apGcd, amGcd;
    NSDictionary *quadDict;
    NSMutableDictionary *mutReturnDict = [[NSMutableDictionary alloc] init];
    NSDictionary *returnDict;
    NSMutableString *binomialStr = [[NSMutableString alloc] init];
    NSNumber *acTempObj, *aTemp, *plusValue, *minusValue;
    
    //quadFormula() for normal tri for real solutions; before borrow&return (original values)
    //all bases covered here
    double firstPlusSolution, secondMinusSolution;
    NSNumber *plusNumSol, *minusNumSol;
    
    
    firstPlusSolution = -(b) + sqrt(square(b) - (4)*(a)*(c));
    firstPlusSolution /= 2*(a);
    
    secondMinusSolution = -(b) - sqrt(square(b) - 4*(a)*(c));
    secondMinusSolution /= 2*(a);
    
    plusNumSol = [NSNumber numberWithDouble:firstPlusSolution];
    minusNumSol = [NSNumber numberWithDouble:secondMinusSolution];

    
    [mutReturnDict setObject:plusNumSol forKey:@"firstSolution"];
    [mutReturnDict setObject:minusNumSol forKey:@"secondSolution"];
    
    //start borrow & return
    
    aTemp = [NSNumber numberWithDouble:1];
    acTemp = (a * c);
    acTempObj = [NSNumber numberWithDouble:acTemp];
    
    //call quadFormula() with the borrow&return values!!! *** !!!
    quadDict = [Trinomial quadFormula:aTemp withBTerm:bTerm withCTerm:acTempObj];
    
    //quadFormula() will return nil if trinomial can't be factored.
    if (quadDict == nil) {
        return nil;
    }
    
    if ([[quadDict objectForKey:@"plusValue"] doubleValue] < 0) {
        plusValue = [NSNumber numberWithDouble:-[[quadDict objectForKey:@"plusValue"] doubleValue]];
    } else {
        plusValue = [NSNumber numberWithDouble:[[quadDict objectForKey:@"plusValue"] doubleValue]];
    }
    
    if ([[quadDict objectForKey:@"minusValue"] doubleValue] < 0) {
        minusValue = [NSNumber numberWithDouble:-[[quadDict objectForKey:@"minusValue"] doubleValue]];
    } else {
        minusValue = [NSNumber numberWithDouble:[[quadDict objectForKey:@"minusValue"] doubleValue]];
        
    }
    
    
    //get gcd of the aTerm and the binomial term to see if possible to simplify
    apGcd = gcdForNumbers((int) a, [plusValue doubleValue]);
    amGcd = gcdForNumbers((int) a, [minusValue doubleValue]);
    
    
    if (apGcd == 1) { //GCD = 1; can't simplify
        if (a == 1) {
            [binomialStr appendString:[NSString stringWithFormat:@"(x %@ %g)", [quadDict objectForKey:@"firstBinomialOperand"], [plusValue doubleValue]]];
        } else {
            [binomialStr appendString:[NSString stringWithFormat:@"(%gx %@ %g)", a, [quadDict objectForKey:@"firstBinomialOperand"], [plusValue doubleValue]]];
        }
        
    } else if (apGcd != 1) { //GCD != 1; can simplify
        
        apaTemp = a / apGcd;
        acsTemp = [plusValue doubleValue] / apGcd;
        if (apaTemp == 1) {
            [binomialStr appendString:[NSString stringWithFormat:@"(x %@ %g)", [quadDict objectForKey:@"firstBinomialOperand"], acsTemp]];
        } else {
            [binomialStr appendString:[NSString stringWithFormat:@"(%gx %@ %g)", apaTemp, [quadDict objectForKey:@"firstBinomialOperand"], acsTemp]];
        }
    }
    
    if (amGcd == 1) { //"     =1      "
        if (a == 1) {
            [binomialStr appendString:[NSString stringWithFormat:@"(x %@ %g)", [quadDict objectForKey:@"secondBinomialOperand"], [minusValue doubleValue]]];
        } else {
            [binomialStr appendString:[NSString stringWithFormat:@"(%gx %@ %g)", a, [quadDict objectForKey:@"secondBinomialOperand"], [minusValue doubleValue]]];
        }
        
        
    } else if (amGcd != 1) { //"   !=1         "
        apaTemp = a / amGcd;
        acsTemp = [minusValue doubleValue] / amGcd;
        if (apaTemp == 1) {
            [binomialStr appendString:[NSString stringWithFormat:@"(x %@ %g)", [quadDict objectForKey:@"secondBinomialOperand"], acsTemp]];
        } else {
            [binomialStr appendString:[NSString stringWithFormat:@"(%gx %@ %g)", apaTemp, [quadDict objectForKey:@"secondBinomialOperand"], acsTemp]];
        }
        
    }
    
    //setup dictionary for return to quadForm()
    [mutReturnDict setObject:binomialStr forKey:@"binomial"];
    [mutReturnDict setObject:[quadDict objectForKey:@"firstBinomialOperand"] forKey:@"firstBinomialOperand"];
    [mutReturnDict setObject:[quadDict objectForKey:@"secondBinomialOperand"] forKey:@"secondBinomialOperand"];
    
    returnDict = [NSDictionary dictionaryWithDictionary:mutReturnDict];
    return returnDict;
}


@end