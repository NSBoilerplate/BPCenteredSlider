//
//  BPCenteredSlider.m
//  BPCenteredSlider
//
//  Created by Jeffrey Sambells on 2014-03-24.
//  Copyright (c) 2014 Jeffrey Sambells. All rights reserved.
//

#import "BPCenteredSlider.h"

@implementation BPCenteredSlider

- (void)setup
{
    [self setContinuous:YES];
    [self addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventValueChanged];
    [self valueChanged];
    
    if (!self.valueColor) {
        self.valueColor = [UIColor colorWithRed:0.128 green:0.374 blue:0.998 alpha:1.000];
    }
    if (!self.backgroundColor) {
        self.backgroundColor = [UIColor colorWithWhite:0.651 alpha:1.000];
    }
    [self valueChanged];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (instancetype)init
{
    if ((self = [super init])) {
        [self setup];
    }
    return self;
}


- (UIImage *)minImageForValue:(CGFloat)value {
    
    CGFloat valueRange = (self.maximumValue - self.minimumValue);
    
    if (self.value <= self.minimumValue + (valueRange * 0.51)) {
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(3, 2), NO, 0.0);
        [self.backgroundColor setFill];
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 3, 2)
                                                         byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft
                                                               cornerRadii:CGSizeMake(1.f,1.f)];
        [bezierPath fill];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return [image stretchableImageWithLeftCapWidth:3 topCapHeight:0];
    } else {
        CGFloat halfWidth = (self.frame.size.width / 2);
        CGSize size = CGSizeMake(halfWidth, 2);
        UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
        [self.backgroundColor setFill];
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height)
                                                         byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft
                                                               cornerRadii:CGSizeMake(1.f,1.f)];
        [bezierPath fill];
        if (self.value > self.minimumValue + ((self.maximumValue - self.minimumValue) / 2)) {
            [self.valueColor setFill];
            CGRect rectangle = CGRectMake(size.width-1, 0, 1, size.height);
            CGContextFillRect(UIGraphicsGetCurrentContext(), rectangle);
        }
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return [image stretchableImageWithLeftCapWidth:image.size.width - 1 topCapHeight:0];
    }
    
}

- (UIImage *)maxImageForValue:(CGFloat)value {
    CGFloat halfWidth = (self.frame.size.width / 2);
    CGFloat maxWidth = self.frame.size.width * (self.maximumValue / self.maximumValue);
    CGFloat highlightedWidth = maxWidth - halfWidth;
    CGSize size = CGSizeMake(highlightedWidth +3, 2);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [self.backgroundColor setFill];
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height)
                                                     byRoundingCorners:UIRectCornerTopRight|UIRectCornerBottomRight
                                                           cornerRadii:CGSizeMake(1.f,1.f)];
    [bezierPath fill];
    [self.valueColor setFill];
    CGRect rectangle = CGRectMake(0, 0, highlightedWidth, size.height);
    CGContextFillRect(UIGraphicsGetCurrentContext(), rectangle);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, highlightedWidth, 0, image.size.width - highlightedWidth - 1)];
}

- (void)valueChanged {
    [self setMaximumTrackImage:[self maxImageForValue:self.value] forState:UIControlStateNormal];
    [self setMinimumTrackImage:[self minImageForValue:self.value] forState:UIControlStateNormal];
}

@end
