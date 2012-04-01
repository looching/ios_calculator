//
//  Calculator2ViewController.m
//  Calculator2
//
//  Created by ching loo on 12-3-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Calculator2ViewController.h"
#import "CalculatorBrain.h"

@interface  Calculator2ViewController()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
//@property (nonatomic) int operatorCount;
@end

@implementation Calculator2ViewController


@synthesize display = _display;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;
//@synthesize operatorCount = _operatorCount;

- (CalculatorBrain *)brain
{
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}


- (IBAction)digitPressed:(UIButton *)sender 
{
    NSString *digit = sender.currentTitle;
    //int dotCount = 0;
    if (self.userIsInTheMiddleOfEnteringANumber) {
        [self.display setText:[self.display.text stringByAppendingString:digit]];
    } else if ([[sender currentTitle] isEqualToString:@"0"]) {
        self.userIsInTheMiddleOfEnteringANumber = NO;
    } else {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    } 
}

- (IBAction)operatorPressed:(UIButton *)sender 
{
    //NSLog(@"self.display.text = %@", self.display.text);
    //double operant = [self.display.text doubleValue];
    //NSLog(@"operant = %g", operant);
    [self.brain pushOperand:[self.display.text doubleValue]];
    [self.brain pushOperator:sender.currentTitle];
    self.display.text = sender.currentTitle;
    //NSLog(@"top of operang stack = %g", self.brain.popOperant);
    //NSLog(@"top of operator stack = %@", self.brain.popOperator);

    //self.operatorCount += 1;
    self.userIsInTheMiddleOfEnteringANumber = NO;
}

- (IBAction)equalPressed 
{
    //double result;
    //[self.brain pushOperand:[self.display.text doubleValue]];
    //NSLog(@"operator count1 = %g", self.operatorCount);

    /*while (self.operatorCount > 0) {
        NSLog(@"operator count = %g", self.operatorCount);
        double operant_1 = self.brain.popOperant;
        NSString *operator = self.brain.popOperator;
        self.operatorCount -= 1;
        double operant_2 = self.brain.popOperant;
        
        if ([operator isEqualToString:@"+"]) {
            result = operant_1 + operant_2;
        } else if ([operator isEqualToString:@"-"]) {
            result = operant_1 - operant_2;
        } else if ([operator isEqualToString:@"×"]) {
            result = operant_1 * operant_2;
        } else if ([operator isEqualToString:@"/"]) {
            if (operant_2) {
                result = operant_1 / operant_2;
            }
        }
    
        [self.brain pushOperand:result];
    }*/
    
    [self.brain pushOperand:[self.display.text doubleValue]];
    double result = self.brain.performOperation;
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString; 
    
    self.userIsInTheMiddleOfEnteringANumber = NO;
}

- (IBAction)cancelPressed:(id)sender 
{
        [self.display setText:@"0"];
        self.userIsInTheMiddleOfEnteringANumber = NO;
        
}
@end