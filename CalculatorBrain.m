//
//  CalculatorBrain.m
//  Calculator2
//
//  Created by ching loo on 12-3-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()

@property (nonatomic, strong) NSMutableArray *operandStack;
@property (nonatomic, strong) NSMutableArray *operatorStack;

@end


@implementation CalculatorBrain

@synthesize operandStack = _operandStack;
@synthesize operatorStack = _operatorStack;

- (NSMutableArray *)operandStack
{
    if (_operandStack == nil) _operandStack = [[NSMutableArray alloc] init ];
    return _operandStack;
}

- (NSMutableArray *)operatorStack
{
    if (_operatorStack == nil) _operatorStack = [[NSMutableArray alloc] init ];
    return _operatorStack;
}


- (void)pushOperand:(double)operand
{
    [self.operandStack addObject:[NSNumber numberWithDouble:operand]]; 
} 

- (double)popOperand
{
    NSNumber *operandObject = [self.operandStack lastObject];
    if (self.operandStack) [self.operandStack removeLastObject];
    return [operandObject doubleValue];
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

- (double)performOperation
{
    double result = 0;
    NSString *operator = self.popOperator;

    
    while (operator) {
        double operand_2 = self.popOperand;
        double operand_1 = self.popOperand;
        
        NSLog(@"operand_1 = %g", operand_1);
        NSLog(@"operand_2 = %g", operand_2);
        NSLog(@"operator = %@", operator);
        
        if ([operator isEqualToString:@"+"]) {
            result = operand_1 + operand_2;
            operator = self.popOperator;
        } else if ([operator isEqualToString:@"-"]) {
            result = operand_1 - operand_2;
            operator = self.popOperator;
        } else if ([operator isEqualToString:@"×"]) {
            result = operand_1 * operand_2;
            operator = self.popOperator;
        } else if ([operator isEqualToString:@"/"]) {
            if (operand_2) {
                result = operand_1 / operand_2;
                operator = self.popOperator;
            }
        }
    }
    
    return result;
}



@end
