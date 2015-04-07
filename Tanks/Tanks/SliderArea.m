//
//  SliderArea.m
//  Tanks
//
//  Created by Ihor Koblan on 4/6/15.
//  Copyright (c) 2015 Ihor Koblan. All rights reserved.
//

#import "SliderArea.h"

@implementation SliderArea

@synthesize delegate = _delegate;

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint position = [[touches anyObject] locationInNode:self];
    [self handleTouch:position];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint position = [[touches anyObject] locationInNode:self];
    [self handleTouch:position];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    power = 0.0;
}

- (void)handleTouch:(CGPoint)touchLocation {
    power = 2 * touchLocation.y / self.size.height;
    if (self.delegate && [self.delegate respondsToSelector:@selector(updateSliderArea:withPower:)]) {
        [self.delegate updateSliderArea:self withPower:power];
    }
}



@end
