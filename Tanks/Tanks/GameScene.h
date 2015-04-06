//
//  GameScene.h
//  Tanks
//

//  Copyright (c) 2015 Ihor Koblan. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SliderArea.h"

@interface GameScene : SKScene {
    SKShapeNode *leftWheel;
    SKShapeNode *rightWheel;
    SliderArea *_sliderLeft;
}

@end
