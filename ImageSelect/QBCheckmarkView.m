//
//  QBCheckmarkView.m
//  QBImagePicker
//
//  Created by Katsuma Tanaka on 2015/04/06.
//  Copyright (c) 2015 Katsuma Tanaka. All rights reserved.
//

#import "QBCheckmarkView.h"

@implementation QBCheckmarkView
@synthesize isSelected = _isSelected;
@synthesize delegate = _delegate;
@synthesize itemTag = _itemTag;
- (id)init
{
    if (self = [super init]) {
        self.frame = CGRectMake(3, 3, 20, 20);
        // Set default values
        self.borderWidth = 1.0;
        self.checkmarkLineWidth = 1.2;
        
        self.backgroundColor = [UIColor clearColor];
        self.borderColor = [UIColor whiteColor];
        self.bodyColor = [UIColor greenColor];
        self.checkmarkColor = [UIColor whiteColor];
        
        // Set shadow
        self.layer.shadowColor = [[UIColor grayColor] CGColor];
        self.layer.shadowOffset = CGSizeMake(0, 0);
        self.layer.shadowOpacity = 0.6;
        self.layer.shadowRadius = 2.0;
        _isSelected = NO;
        [self setColorOfCheckMark:_isSelected];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Border
//    [self.borderColor setFill];
//    [[UIBezierPath bezierPathWithOvalInRect:self.bounds] fill];
    
    // Body
    [self.bodyColor setFill];
    [[UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.bounds, self.borderWidth, self.borderWidth)] fill];
    
    // Checkmark
    UIBezierPath *checkmarkPath = [UIBezierPath bezierPath];
    checkmarkPath.lineWidth = self.checkmarkLineWidth;
    
    [checkmarkPath moveToPoint:CGPointMake(CGRectGetWidth(self.bounds) * (6.0 / 24.0), CGRectGetHeight(self.bounds) * (12.0 / 24.0))];
    [checkmarkPath addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds) * (10.0 / 24.0), CGRectGetHeight(self.bounds) * (16.0 / 24.0))];
    [checkmarkPath addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds) * (18.0 / 24.0), CGRectGetHeight(self.bounds) * (8.0 / 24.0))];
    
    [self.checkmarkColor setStroke];
    [checkmarkPath stroke];
}

#pragma mark - private 
- (void)setColorOfCheckMark:(BOOL)flag {
    if (flag) {
        self.bodyColor = [UIColor greenColor];
    } else {
        self.bodyColor = [UIColor grayColor];
    }
    [self setNeedsDisplay];
}

- (void)changeColorOfCheckMark {
    _isSelected = !_isSelected;
    [self setColorOfCheckMark:_isSelected];
    [_delegate onCheckmarkViewChange:_isSelected];
}

@end
