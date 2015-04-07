//
//  GameScene.h
//  Tanks
//

//  Copyright (c) 2015 Ihor Koblan. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SliderArea.h"

@interface GameScene : SKScene<SliderAreaDelegate> {
    SKSpriteNode *leftWheel;
    SKSpriteNode *rightWheel;
    SliderArea *_sliderLeft;
    SliderArea *_sliderRight;
    
    CGFloat rightPower;
    CGFloat leftPower;
}

@end
