//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Matt Gillooly on 7/29/12.
//  Copyright (c) 2012 Matt Gillooly. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringNumber;
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringFloatingPointNumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController

@synthesize display = _display;
@synthesize history = _history;
@synthesize userIsInTheMiddleOfEnteringNumber = _userIsInTheMiddleOfEnteringNumber;
@synthesize userIsInTheMiddleOfEnteringFloatingPointNumber = _userIsInTheMiddleOfEnteringFloatingPointNumber;
@synthesize brain = _brain;

- (CalculatorBrain *) brain
{
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender
{
    NSString *digit = sender.currentTitle;
    if (self.userIsInTheMiddleOfEnteringNumber) {
        self.display.text = [self.display.text stringByAppendingString:digit];
    } else {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringNumber = YES;
    }
}

- (IBAction)periodPressed {
    if (!self.userIsInTheMiddleOfEnteringFloatingPointNumber) {
        self.display.text = [self.display.text stringByAppendingString:@"."];
        self.userIsInTheMiddleOfEnteringFloatingPointNumber = YES;
    }
}

- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];

    if (self.history.text != @"") {
        self.history.text = [self.history.text stringByAppendingString:@" "];
    }
    self.history.text = [self.history.text stringByAppendingString:self.display.text];

    self.userIsInTheMiddleOfEnteringNumber = NO;
    self.userIsInTheMiddleOfEnteringFloatingPointNumber = NO;
}

- (IBAction)operationPressed:(UIButton *)sender {
    if (self.userIsInTheMiddleOfEnteringNumber) [self enterPressed];
    
    if (self.history.text != @"") {
        self.history.text = [self.history.text stringByAppendingString:@" "];
    }
    self.history.text = [self.history.text stringByAppendingString:sender.currentTitle];

    double result = [self.brain performOperation:sender.currentTitle];
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;
}

- (IBAction)clearPressed {
    self.display.text = @"0";
    self.history.text = @"";
    self.userIsInTheMiddleOfEnteringNumber = NO;
    self.userIsInTheMiddleOfEnteringFloatingPointNumber = NO;

    [self.brain clearStack];
}

- (void)viewDidUnload {
    [self setHistory:nil];
    [super viewDidUnload];
}
@end
