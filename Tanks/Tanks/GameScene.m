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
    
    _sliderLeft = [[SliderArea alloc] initWithImageNamed:@"track.png"];
    _sliderLeft.position = CGPointMake(200.f, 200.0f);
    [self addChild:_sliderLeft];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    [leftWheel.physicsBody setDynamic:YES];
    [rightWheel.physicsBody applyForce:CGVectorMake(0.0, 15.0)];
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

- (SKShapeNode*) makeWheel
{
    SKShapeNode *wheel = [[SKShapeNode alloc] init];
    CGMutablePathRef myPath = CGPathCreateMutable();
    CGPathAddArc(myPath, NULL, 0,0, 16, 0, M_PI*2, YES);
    wheel.path = myPath;
    return wheel;
}


- (void)createCarOnScene:(SKScene*)scene
{
    // 1. car body
    SKSpriteNode *carBody = [SKSpriteNode spriteNodeWithImageNamed:@"panzer_body.png"];
    carBody.position = CGPointMake(400, 200);
    carBody.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:carBody.size];
    [scene addChild:carBody];
    
    // 2. wheels
    leftWheel = [self makeWheel];
    leftWheel.position = CGPointMake(carBody.position.x - carBody.size.width / 2, carBody.position.y);
    leftWheel.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:16];
    [scene addChild:leftWheel];
    
    rightWheel = [self makeWheel];
    rightWheel.position = CGPointMake(carBody.position.x + carBody.size.width / 2, carBody.position.y);
    rightWheel.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:16];
    [scene addChild:rightWheel];
    
    // 3. Join wheels to car
    [scene.physicsWorld addJoint:[SKPhysicsJointPin jointWithBodyA:carBody.physicsBody bodyB:leftWheel.physicsBody anchor:leftWheel.position]];
    [scene.physicsWorld addJoint:[SKPhysicsJointPin jointWithBodyA:carBody.physicsBody bodyB:rightWheel.physicsBody anchor:rightWheel.position]];
    
    // 4. drive car
    
}

@end
