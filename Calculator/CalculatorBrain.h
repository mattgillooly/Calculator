//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Matt Gillooly on 7/29/12.
//  Copyright (c) 2012 Matt Gillooly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void) pushOperand:(double)operand;
- (double) performOperation:(NSString *)operation;
- (void) clearStack;

@property (readonly) id program;

+ (double)runProgram:(id)program;
+ (NSString *)descriptionOfProgram:(id)program;

@end
