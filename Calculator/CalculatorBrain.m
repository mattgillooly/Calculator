//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Matt Gillooly on 7/29/12.
//  Copyright (c) 2012 Matt Gillooly. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *programStack;
@end

@implementation CalculatorBrain

@synthesize programStack = _programStack;

- (NSMutableArray *) programStack
{
    if (_programStack == nil) _programStack = [[NSMutableArray alloc] init];
    return _programStack;
}

- (void) pushOperand:(double)operand
{
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
}

- (void) clearStack
{
    [self.programStack removeAllObjects];
}

- (double) performOperation:(NSString *)operation
{
    [self.programStack addObject:operation];
    return [CalculatorBrain runProgram:self.program];
}

- (id)program
{
    return [self.programStack copy];
}

+ (NSString *) descriptionOfProgram:(id)program
{
    return @"Implement this in Assignment 2";
}

+ (double)popOperandOffStack:(NSMutableArray *)stack
{
    double result = 0;
    
    id topOfStack = [stack lastObject];
    if (topOfStack) [stack removeLastObject];

    if ([topOfStack isKindOfClass:[NSNumber class]]) {
        result = [topOfStack doubleValue];
    }
    else if ([topOfStack isKindOfClass:[NSString class]]) {
        NSString *operation = topOfStack;
        
        if ([operation isEqualToString:@"+"]) {
            result = [self popOperandOffStack:stack] + [self popOperandOffStack:stack];
        } else if ([operation isEqualToString:@"-"]) {
            double amount_to_subtract = [self popOperandOffStack:stack];
            result = [self popOperandOffStack:stack] - amount_to_subtract;
        } else if ([operation isEqualToString:@"*"]) {
            result = [self popOperandOffStack:stack] * [self popOperandOffStack:stack];
        } else if ([operation isEqualToString:@"/"]) {
            double amount_to_divide_by = [self popOperandOffStack:stack];
            result = [self popOperandOffStack:stack] / amount_to_divide_by;
        } else if ([operation isEqualToString:@"sin"]) {
            result = sin([self popOperandOffStack:stack]);
        } else if ([operation isEqualToString:@"cos"]) {
            result = cos([self popOperandOffStack:stack]);
        } else if ([operation isEqualToString:@"sqrt"]) {
            result = sqrt([self popOperandOffStack:stack]);
        } else if ([operation isEqualToString:@"pi"]) {
            result = 3.14159;
        }
    }
    
    return result;
}

+ (double)runProgram:(id)program
{
    NSMutableArray *stack;
    
    if ([program isKindOfClass:[NSArray class]]) {
        stack = [program mutableCopy];
    }
    return [self popOperandOffStack:stack];
}
    
@end
