/*
 * Kobold2D™ --- http://www.kobold2d.org
 *
 * Copyright (c) 2010-2011 Steffen Itterheim. 
 * Released under MIT License in Germany (LICENSE-Kobold2D.txt).
 */

#import "HelloWorldLayer.h"
#import "SimpleAudioEngine.h"

@interface HelloWorldLayer (PrivateMethods)
@end

@implementation HelloWorldLayer

@synthesize helloWorldString, helloWorldFontName;
@synthesize helloWorldFontSize;




//iphone nonretina 480 x 320

-(id) init
{
	if ((self = [super init]))
	{
        glClearColor(255,255,255,255);
        
        //THE CLOCK ITSELF.
		clock = [CCSprite spriteWithFile:@"clock.png"];
        clock.scale = 0.8;
        clock.position = ccp(160,240);
        [self addChild:clock];
        
        
        
        center = [CCNode node];
        center.position = CGPointMake(160, 240);
        [self addChild:center];
        
        //PLAYER MODEL.
        player = [CCSprite spriteWithFile:@"player.png"];
        player.scale = 0.4;
        
        [center addChild:player];
        
        // offset rotateMe from center by 100 points to the right
        player.position = CGPointMake(100, 0);
        
        // perform rotation of rotateMe around center by rotating center
        id rotate = [CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:2 angle:360]];
        [center runAction:rotate];

        
        //INITIATING VARIABLES
        playerrotation = 360;
        danger = 1;
        framespast = 0;
        fireballdirection = 210;
        
        [self scheduleUpdate];
	}

	return self;
}


-(void)update:(ccTime)dt
{
    
    [self touchRotation];
    [self gameTime];
    
    [self moveFireball];
    [self fireballCollision];
    
    framespast++;
    
}

-(void) gameTime
{
    if(framespast == 65)
    {
        fireball = [CCSprite spriteWithFile:@"clock.png"];
        fireball.scale = 1;
        fireball.position = ccp(320,480);
        [self addChild:fireball];
    }
    
    if(framespast == 300)
    {
        
    }
}

-(void) touchRotation
{
    KKInput* input = [KKInput sharedInput];
    
    // playerangle = playerangle + directionchange;
    
    
    if (input.anyTouchBeganThisFrame) {
        
        [center stopAllActions];
        id rotate;
        
        if(playerrotation == 360)
        {
            rotate = [CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:2 angle:-360]];
            playerrotation = -360;
        }
        else if(playerrotation == -360)
        {
            rotate = [CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:2 angle:360]];
            playerrotation = 360;
        }
        [center runAction:rotate];
        
    }
}

-(void) moveFireball
{
    float angle = fireballdirection;
    float speed = 5; // Move 50 pixels in 60 frames (1 second)
    
    float vx = cos(angle * M_PI / 180) * speed;
    float vy = sin(angle * M_PI / 180) * speed;
    
    CGPoint direction = ccp(vx,vy);
    
    fireball.position = ccpAdd(fireball.position, direction);
    
    fireball.rotation = angle;

}

-(void) fireballCollision
{
    if(fireball.position.x < 0 && fireballdirection < 270 && fireballdirection > 90)
    {
        fireballdirection = 270 + (270 - fireballdirection);
    }
    
    if(fireball.position.x > 320 && fireballdirection < 90)
    {
        fireballdirection = 270 - (fireballdirection - 270);
    }
    if(fireball.position.x > 320 && fireballdirection > 270)
    {
        fireballdirection = 270 - (fireballdirection - 270);
    }
    
    
    
    NSLog(@"%d",fireballdirection);
}

@end
