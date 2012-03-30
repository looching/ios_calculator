//
//  CalculatorBrain.h
//  Calculator2
//
//  Created by ching loo on 12-3-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperant:(double)operant;
- (void)pushOperator:(NSString *)operator;
- (double)popOperant;
- (NSString *)popOperator;
- (double)performOperation:(NSString *)operation;

@end
