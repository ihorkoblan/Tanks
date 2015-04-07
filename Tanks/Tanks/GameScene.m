//
//  GameScene.m
//  Tanks
//
//  Created by Ihor Koblan on 4/6/15.
//  Copyright (c) 2015 Ihor Koblan. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

typedef NS_OPTIONS(uint32_t, CNPhysicsCategory)
{
    GFPhysicsCategoryWorld    = 1 << 0,  // 0001 = 1
    GFPhysicsCategoryRectangle  = 1 << 1,  // 0010 = 2
    GFPhysicsCategorySquare  = 1 << 2,  // 0010 = 2
};

-(void)didMoveToView:(SKView *)view {
    self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsWorld.gravity = CGVectorMake(0.0, 0.0);
    self.physicsBody.categoryBitMask = GFPhysicsCategoryWorld;
    
    [self performSelector:@selector(createCarOnScene:) withObject:self afterDelay:0.5];
    
    _sliderLeft = [[SliderArea alloc] initWithColor:[UIColor redColor] size:CGSizeMake(150.0f, self.size.height)];
    _sliderLeft.position = CGPointMake(75.0f, _sliderLeft.size.height / 2.0f);
    _sliderLeft.userInteractionEnabled = YES;
    _sliderLeft.tag = 1;
    _sliderLeft.delegate = self;
    [self addChild:_sliderLeft];
    
    _sliderRight = [[SliderArea alloc] initWithColor:[UIColor redColor] size:CGSizeMake(150.0f, self.size.height)];
    _sliderRight.position = CGPointMake(self.size.width - 75.0f, _sliderRight.size.height / 2.0f);
    _sliderRight.userInteractionEnabled = YES;
    _sliderRight.tag = 2;
    _sliderRight.delegate = self;
    [self addChild:_sliderRight];
}

-(void)update:(CFTimeInterval)currentTime {

    NSLog(@"left  power: %f",leftPower);
    NSLog(@"right power: %f",rightPower);
    [rightWheel.physicsBody applyForce:CGVectorMake(0.0, 3.0 * rightPower)];
}

- (void)createCarOnScene:(SKScene*)scene {
    // 1. car body
    SKSpriteNode *carBody = [SKSpriteNode spriteNodeWithImageNamed:@"panzer_body.png"];
    carBody.position = CGPointMake(400, 200);
    carBody.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:carBody.size];
    [scene addChild:carBody];
    
    // 2. wheels
    leftWheel = [SKSpriteNode spriteNodeWithImageNamed:@"panzer_track.png"];
    leftWheel.position = CGPointMake(carBody.position.x - carBody.size.width / 2, carBody.position.y);
    leftWheel.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:leftWheel.size];
    
    [scene addChild:leftWheel];
    
    rightWheel = [SKSpriteNode spriteNodeWithImageNamed:@"panzer_track.png"];
    rightWheel.position = CGPointMake(carBody.position.x + carBody.size.width / 2, carBody.position.y);
    rightWheel.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:rightWheel.size];
    [scene addChild:rightWheel];
    
    // 3. Join wheels to car
    
    [scene.physicsWorld addJoint:[SKPhysicsJointPin jointWithBodyA:carBody.physicsBody bodyB:leftWheel.physicsBody anchor:leftWheel.position]];
    [scene.physicsWorld addJoint:[SKPhysicsJointPin jointWithBodyA:carBody.physicsBody bodyB:leftWheel.physicsBody anchor:CGPointMake(leftWheel.position.x, leftWheel.position.y+2)]];
    
    [scene.physicsWorld addJoint:[SKPhysicsJointPin jointWithBodyA:carBody.physicsBody bodyB:rightWheel.physicsBody anchor:rightWheel.position]];
    [scene.physicsWorld addJoint:[SKPhysicsJointPin jointWithBodyA:carBody.physicsBody bodyB:rightWheel.physicsBody anchor:CGPointMake(rightWheel.position.x, rightWheel.position.y+2)]];
    

}

- (void)updateSliderArea:(SliderArea *)area withPower:(CGFloat)power {
    if (area.tag == 1) {
        leftPower = power;
    } else if (area.tag == 2) {
        rightPower = power;
    }
}

@end
