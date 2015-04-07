//
//  SliderArea.h
//  Tanks
//
//  Created by Ihor Koblan on 4/6/15.
//  Copyright (c) 2015 Ihor Koblan. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class SliderArea;
@protocol SliderAreaDelegate <NSObject>
- (void)updateSliderArea:(SliderArea *)area withPower:(CGFloat)power;
@end

@interface SliderArea : SKSpriteNode {
    CGFloat power;
}
@property (nonatomic, assign) NSUInteger tag;
@property (nonatomic, weak) id<SliderAreaDelegate> delegate;
@end
