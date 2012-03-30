//
//  CalculatorBrain.m
//  Calculator2
//
//  Created by ching loo on 12-3-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()

@property (nonatomic, strong) NSMutableArray *operantStack;
@property (nonatomic, strong) NSMutableArray *operatorStack;

@end


@implementation CalculatorBrain

@synthesize operantStack = _operantStack;
@synthesize operatorStack = _operatorStack;

- (NSMutableArray *)operantStack
{
    if (_operantStack == nil) _operantStack = [[NSMutableArray alloc] init ];
    return _operantStack;
}

- (NSMutableArray *)operatorStack
{
    if (_operatorStack == nil) _operatorStack = [[NSMutableArray alloc] init ];
    return _operatorStack;
}


- (void)pushOperant:(double)operant
{
    [self.operantStack addObject:[NSNumber numberWithDouble:operant]]; 
} 

- (double)popOperant
{
    NSNumber *operantObject = [self.operantStack lastObject];
    if (self.operantStack) [self.operantStack removeLastObject];
    return [operantObject doubleValue];
}

- (void)pushOperator:(NSString *)operator
{
    [self.operatorStack addObject:operator];
}

- (NSString *)popOperator
{
    NSString *operator = [self.operatorStack lastObject];
    if (self.operatorStack) [self.operatorStack removeLastObject];
    return operator;
}

- (double)performOperation:(NSString *)operation
{
    double result = 0;
    return result;
}



@end
