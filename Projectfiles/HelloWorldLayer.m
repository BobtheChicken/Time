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
        
        
        
        //PLAYER MODEL.
        player = [CCSprite spriteWithFile:@"player.png"];
        player.scale = 0.4;
        player.position = ccp(155,390);
        [self addChild:player];
        
        
        
        //INITIATING VARIABLES
        playerangle = 180;
        playerspeed = 7;
        directionchange = 4;
        direction = true;
        
        [self scheduleUpdate];
	}

	return self;
}


-(void)update:(ccTime)dt
{
    
    KKInput* input = [KKInput sharedInput];
 
    if(direction)
    {
        playerangle = playerangle + directionchange;
    }
    else
    {
        playerangle = playerangle - directionchange;
    }
    
    
    if ([KKInput sharedInput].anyTouchBeganThisFrame) {
        direction = !direction;
        playerangle = 180 - playerangle;
    }

    
    [self movePlayer];

}


-(void) movePlayer
{
    //MOVING THE PLAYER IN A CERTAIN DIRECTION.
    float angle = playerangle;
    float speed = playerspeed; // Move 50 pixels in 60 frames (1 second)
    
    float vx = cos(angle * M_PI / 180) * speed;
    float vy = sin(angle * M_PI / 180) * speed;
    
    CGPoint direction2 = ccp(vx,vy);
    
    player.position = ccpAdd(player.position, direction2);
}

@end
