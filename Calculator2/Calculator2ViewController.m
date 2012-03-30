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
@property (nonatomic) int operatorCount;
@end

@implementation Calculator2ViewController


@synthesize display = _display;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;
@synthesize operatorCount = _operatorCount;

- (int)operatorCount
{
    if (_operatorCount) {
        _operatorCount = 1;
    }
}


- (IBAction)digitPressed:(UIButton *)sender 
{
    NSString *digit = sender.currentTitle;
    if (self.userIsInTheMiddleOfEnteringANumber) {
        [self.display setText:[self.display.text stringByAppendingString:digit]];
    } else if ([[sender currentTitle] isEqualToString:@"0"]){
        self.userIsInTheMiddleOfEnteringANumber = NO;
    } else {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}

- (IBAction)operationPressed:(UIButton *)sender 
{
    double operant = [self.display.text doubleValue];
    [self.brain pushOperant:operant];
    [self.brain pushOperator:sender.currentTitle];
    self.display.text = sender.currentTitle;
    self.operatorCount += 1;
}

- (IBAction)equalPressed 
{

    double operant_1 = self.brain.popOperant;
    NSString *operator = self.brain.popOperator;
    self.operatorCount -= 1;
    double operant_2 = self.brain.popOperant;
    double result;
    
    while (self.operatorCount > 0) {
        if ([operator isEqualToString:@"+"]) {
            result = operant_1 + operant_2;
        } else if ([operator isEqualToString:@"-"]) {
            result = operant_1 - operant_2;
        } else if ([operator isEqualToString:@"×"]) {
            result = operant_1 * operant_2;
        } else if ([operator isEqualToString:@"÷"]) {
            if (operant_2) {
                result = operant_1 / operant_2;
            }
        }
    
    [self.brain pushOperant:result];
    }
}

- (IBAction)cancelPressed:(id)sender 
{
        [self.display setText:@"0"];
        self.userIsInTheMiddleOfEnteringANumber = NO;
        
}
@end