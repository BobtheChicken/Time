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
        id rotate = [CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:1 angle:360]];
        [center runAction:rotate];
        
        
        
        
        
        
        
        //INITIATING VARIABLES
        playerrotation = 360;
        
        [self scheduleUpdate];
	}

	return self;
}


-(void)update:(ccTime)dt
{
    
    KKInput* input = [KKInput sharedInput];
    
   // playerangle = playerangle + directionchange;

    
    if (input.anyTouchBeganThisFrame) {
        
        [center stopAllActions];
        id rotate;
        
        if(playerrotation == 360)
        {
            rotate = [CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:1 angle:-360]];
            playerrotation = -360;
        }
        else if(playerrotation == -360)
        {
            rotate = [CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:1 angle:360]];
            playerrotation = 360;
        }
        [center runAction:rotate];
        
    }
 
    
}

@end
