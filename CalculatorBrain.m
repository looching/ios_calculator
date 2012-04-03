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
@property (nonatomic, strong) NSMutableArray *formulaStack;

@end


@implementation CalculatorBrain

@synthesize operandStack = _operandStack;
@synthesize operatorStack = _operatorStack;
@synthesize formulaStack = _formulaStack;

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

- (NSMutableArray *)formulaStack
{
    if (_formulaStack == nil) _formulaStack = [[NSMutableArray alloc] init];
    return _formulaStack;
}

/* - (NSMutableArray *) getDisplayContent
{
    NSMutableArray *stack, *stack_temp;
    
    stack_temp = [self.formulaStack mutableCopy];
    int elementCount = [stack_temp count];
    while (elementCount >= 0) {
        [stack addObject:[stack_temp objectAtIndex:elementCount - 1]];
        elementCount -= 1;
    }
    return stack;
} */ //getting an array for displaying the formula

- (void)pushFormula
{
   // NSLog(@"the top of operand stack = %g", [self.operandStack lastObject]);
/*    while (self.operandStack) {
        [self.formulaStack addObject:[self.operandStack lastObject]];
        [self.operandStack removeLastObject];
        
        [self.formulaStack addObject:[self.operatorStack lastObject]];
        [self.operatorStack removeLastObject];
        
        [self.formulaStack addObject:[self.operandStack lastObject]];
        [self.operandStack removeLastObject];
    }*/
    
    int operatorCount = [self.operatorStack count];
    NSLog(@"operator count = %g", operatorCount);
    
    while (operatorCount) {
        NSLog(@"top of operand stack = %g", [[self.operandStack lastObject] doubleValue]);
        [self.formulaStack addObject:[NSNumber numberWithDouble:self.popOperand]];
        [self.formulaStack addObject:self.popOperator];
        operatorCount -= 1;
    }
    [self.formulaStack addObject:[NSNumber numberWithDouble:self.popOperand]];
    
    NSLog(@"formula stack elements count = %d", [self.formulaStack count]);
    
}  //combining the operand stack and the operator stack

- (double)calculateTheFormula
{
    double result = 0;
/*    NSMutableArray *stack;
    
    if (stack == nil) stack = [[NSMutableArray alloc] init];
    
    int formulaCount = [self.formulaStack count];
    
    while (formulaCount != 1) {
        double topOfStack_1 = [[self.formulaStack lastObject] doubleValue];
        [stack addObject:[NSNumber numberWithDouble:topOfStack_1]];
        [self.formulaStack removeLastObject];
        
        NSString * topOfStack_2 = [self.formulaStack lastObject];
        [stack addObject:topOfStack_2];
        [self.formulaStack removeLastObject];
        
        formulaCount -= 2;
    } //turnint the formula stack upside down
    
    double topOfStack = [[self.formulaStack lastObject] doubleValue];
    [stack addObject:[NSNumber numberWithDouble:topOfStack]];
    [self.formulaStack removeLastObject];   */ 
    
    //id topOfStack = [stack lastObject];
    int numberOfStackElement = [self.formulaStack count];
    
    while (numberOfStackElement != 1) {
        double operand_1 = [[self.formulaStack lastObject] doubleValue];
        [self.formulaStack removeLastObject];
        NSString *operator = [self.formulaStack lastObject];
        [self.formulaStack removeLastObject];
        double operand_2 = [[self.formulaStack lastObject] doubleValue];
        [self.formulaStack removeLastObject];
        numberOfStackElement -= 3;
        
        if ([operator isEqualToString:@"+"]) {
            result = operand_1 + operand_2;
            [self.formulaStack addObject:[NSNumber numberWithDouble:result]];
            numberOfStackElement += 1;
        } else if ([operator isEqualToString:@"-"]) {
            result = operand_1 - operand_2;
            [self.formulaStack addObject:[NSNumber numberWithDouble:result]];
            numberOfStackElement += 1;
        } else if ([operator isEqualToString:@"×"]) {
            result = operand_1 * operand_2;
            [self.formulaStack addObject:[NSNumber numberWithDouble:result]];
            numberOfStackElement += 1;
        } else if ([operator isEqualToString:@"/"]) {
            if (operand_2) {
                result = operand_1 / operand_2;
                [self.formulaStack addObject:[NSNumber numberWithDouble:result]];
                numberOfStackElement += 1;
            }
        }


    }
    
    [self.formulaStack removeLastObject];
    
    return result;
    
    //do the calculation things
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
        
        //NSLog(@"operand_1 = %g", operand_1);
        //NSLog(@"operand_2 = %g", operand_2);
        //NSLog(@"operator = %@", operator);
        
        
        if ([operator isEqualToString:@"+"]) {
            result = operand_1 + operand_2;
            operator = self.popOperator;
            [self.operandStack addObject:[NSNumber numberWithDouble:result]];
        } else if ([operator isEqualToString:@"-"]) {
            result = operand_1 - operand_2;
            operator = self.popOperator;
            [self.operandStack addObject:[NSNumber numberWithDouble:result]];
        } else if ([operator isEqualToString:@"×"]) {
            result = operand_1 * operand_2;
            operator = self.popOperator;
            [self.operandStack addObject:[NSNumber numberWithDouble:result]];
        } else if ([operator isEqualToString:@"/"]) {
            if (operand_2) {
                result = operand_1 / operand_2;
                operator = self.popOperator;
                [self.operandStack addObject:[NSNumber numberWithDouble:result]];
            }
        }
    }
    
    return result;
}



@end
