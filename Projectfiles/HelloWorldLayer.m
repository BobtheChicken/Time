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
        
        CCSprite* bg = [CCSprite spriteWithFile:@"Background.png"];
        [self addChild:bg];
        bg.position = ccp(160,240);
        
        //THE CLOCK ITSELF.
		clock = [CCSprite spriteWithFile:@"Wheel.png"];
        clock.position = ccp(160,240);
        [self addChild:clock];
        //The hail
        hail = [[NSMutableArray alloc] init];
        //The spikeball
        
        
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
        isdead = false;
        tempframespast = 0;
        islightning = false;
        
        [self scheduleUpdate];
	}

	return self;
}


+(id) scene
{
    CCScene *scene = [CCScene node];
    
    HelloWorldLayer *layer = [HelloWorldLayer node];
    
    [scene addChild: layer];
    
    return scene;
}


-(void)update:(ccTime)dt
{
    
    [self touchRotation];
    [self gameRand];
    
    [self moveFireball];
    [self fireballCollision];
    [self playerPositioning];
    [self hailfall];
    [self hailCollision];
    [self restartGame];
    [self lightningDeath];
    
    [self spikeballmovement];
    [self spikeballmovement2];
    [self spikeballmovement3];
    [self spikeballmovement4];
    [self spikeballCollision];
    
    [self checkHail];
    [self checkSpike];
    
    framespast++;
    tempframespast--;
    
    NSLog(@"%d",framespast);
    NSLog(@"%d",tempframespast);
    
}


-(void) gameRand
{
    if((framespast % 300) == 0)
    {
        int random = arc4random() % 4;
        
        switch(random)
        {
            case 0:
                fireball = [CCSprite spriteWithFile:@"Fireball.png"];
                fireball.scale = 0.6;
                fireball.position = ccp(320,480);
                [self addChild:fireball];
                break;
            case 1:
                tempframespast = 9000;
                break;
            case 2:
            {
                lightning = [CCSprite spriteWithFile:@"meteor.png"];
                lightning.position = ccp(160 ,480);
                
                id move = [CCMoveTo actionWithDuration:3 position:ccp(160,50)];
                
                [lightning runAction:move];
                
                [self addChild:lightning];
                
                [self performSelector:@selector(deleteLightning) withObject:nil afterDelay:4.0f];
                islightning = true;
                break;
            }
            case 3:
                tempframespast = 18001;
                break;
                
        }
    }
}


-(void) checkHail
{
    if(tempframespast >= 8997 && tempframespast <= 8999)
    {
        //function for adding more hail
        
        CCSprite* hailsprite = [CCSprite spriteWithFile:@"Hail.png"];
        hailsprite.position = ccp(arc4random() % 320,480);
        [hail addObject:hailsprite];
        [self addChild:hailsprite];
    }
    if(tempframespast >= 8917 && tempframespast <= 8920)
    {
        //function for adding more hail
        
        CCSprite* hailsprite = [CCSprite spriteWithFile:@"Hail.png"];
        hailsprite.position = ccp(arc4random() % 320,480);
        [hail addObject:hailsprite];
        [self addChild:hailsprite];
    }
    if(tempframespast >= 8867 && tempframespast <= 8870)
    {
        //function for adding more hail
        
        CCSprite* hailsprite = [CCSprite spriteWithFile:@"Hail.png"];
        hailsprite.position = ccp(arc4random() % 320,480);
        [hail addObject:hailsprite];
        [self addChild:hailsprite];
    }

}



-(void) checkSpike
{
    if(tempframespast == 18000)
    {
        spikeball = [CCSprite spriteWithFile:@"Spikeball.png"];
        spikeball.scale = 1;
        spikeball.position = ccp(0,0);
        [self addChild:spikeball];
    }
    
    if(tempframespast == 17900)
    {
        spikeball2 = [CCSprite spriteWithFile:@"Spikeball.png"];
        spikeball2.scale = 1;
        spikeball2.position = ccp(320,0);
        [self addChild:spikeball2];
        
    }
    
    if(tempframespast == 17800)
    {
        spikeball3 = [CCSprite spriteWithFile:@"Spikeball.png"];
        spikeball3.scale = 1;
        spikeball3.position = ccp(320,480);
        [self addChild:spikeball3];
        
    }
    
    if(tempframespast == 17700)
    {
        spikeball4 = [CCSprite spriteWithFile:@"Spikeball.png"];
        spikeball4.scale = 1;
        spikeball4.position = ccp(0,480);
        [self addChild:spikeball4];
        
    }

}

-(void) gameTime
{
    if(framespast == 65)
    {
        fireball = [CCSprite spriteWithFile:@"Fireball.png"];
        fireball.scale = 0.6;
        fireball.position = ccp(320,480);
        [self addChild:fireball];
    }
    
    
    
    
    
    if(framespast == 900)
    {
        spikeball = [CCSprite spriteWithFile:@"Spikeball.png"];
        spikeball.scale = 1;
        spikeball.position = ccp(0,0);
        [self addChild:spikeball];
    }
    
    if(framespast == 950)
    {
        spikeball2 = [CCSprite spriteWithFile:@"Spikeball.png"];
        spikeball2.scale = 1;
        spikeball2.position = ccp(320,0);
        [self addChild:spikeball2];
        
    }
    
    if(framespast == 1000)
    {
        spikeball3 = [CCSprite spriteWithFile:@"Spikeball.png"];
        spikeball3.scale = 1;
        spikeball3.position = ccp(320,480);
        [self addChild:spikeball3];
        
    }
    
    if(framespast == 1500)
    {
        spikeball4 = [CCSprite spriteWithFile:@"Spikeball.png"];
        spikeball4.scale = 1;
        spikeball4.position = ccp(0,480);
        [self addChild:spikeball4];
        
    }
    NSLog(@"%d",framespast);
   
}

-(void) lightningDeath
{
    if(islightning)
    {
        if([self isCollidingRect:lightning WithSphere:player])
        {
            [self deadPlayer];
        }
    }
}

-(BOOL) isCollidingRect:(CCSprite *) spriteOne WithSphere:(CCSprite *) spriteTwo {
    

    return CGRectIntersectsRect([spriteOne boundingBox],CGRectMake(actualPosition.x,actualPosition.y,20,20));
}

-(void) deleteLightning
{
    [self removeChild:lightning];
    islightning = false;
    NSLog(@"ad");
}

-(void) restartGame
{
    if(isdead)
    {
    KKInput* input = [KKInput sharedInput];
    
    // playerangle = playerangle + directionchange;
    
    
    if (input.anyTouchBeganThisFrame) {
        [[CCDirector sharedDirector] replaceScene:[HelloWorldLayer scene]];

    }
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
    
    
    if(framespast > 64)
    {
        float diff = ccpDistance(actualPosition, fireball.position);
        if (diff <  10 + 80) {
            [self deadPlayer];
            
        }
    }
}

-(void) spikeballCollision
{
    if(framespast > 64)
    {
        float diff = ccpDistance(actualPosition, spikeball.position);
        if (diff <  10 + 68) {
            [self deadPlayer];
            
        }
        diff = ccpDistance(actualPosition, spikeball2.position);
        if (diff <  10 + 68) {
            [self deadPlayer];
            
        }
        diff = ccpDistance(actualPosition, spikeball3.position);
        if (diff <  10 + 68) {
            [self deadPlayer];
            
        }
        diff = ccpDistance(actualPosition, spikeball4.position);
        if (diff <  10 + 68) {
            [self deadPlayer];
            
        }
    }
}

-(void) hailCollision
{
    
    
        for(int i = 0; i < [hail count];i++)
        {
            CCSprite* temp = [hail objectAtIndex:i];
            float diff = ccpDistance(actualPosition, temp.position);
            if (diff <  10 + 10) {
                [self deadPlayer];
                
            }
        }
    
}


-(void) deadPlayer
{
    if(isdead == false)
    {
    [center removeChild:player];
    youdie = [CCLabelTTF labelWithString:@"B+ you die" fontName:@"Helvetica" fontSize:64];
    youdie.color = ccc3(155, 89, 182);
    [self addChild:youdie];
    youdie.position = ccp(160,400);
    isdead = true;
    }
}

-(void) playerPositioning
{
    worldPosition = [center convertToWorldSpace:player.position];
    actualPosition = [self convertToNodeSpace:worldPosition];
}

-(void) hailfall
{
    for(int i = 0; i < [hail count]; i++)
    {
        CCSprite* temp = [hail objectAtIndex:i];
        temp.position = ccp(temp.position.x,temp.position.y - 5);
    }
}

-(void) spikeballmovement
{
    float angle = 45;
    float speed = 5; // Move 50 pixels in 60 frames (1 second)
    
    float vx = cos(angle * M_PI / 180) * speed;
    float vy = sin(angle * M_PI / 180) * speed;
    
    CGPoint direction = ccp(vx,vy);
    
    spikeball.position = ccpAdd(spikeball.position, direction);
    
    spikeball.rotation = angle;
    
}

-(void) spikeballmovement2
{
    float angle = 135;
    float speed = 5; // Move 50 pixels in 60 frames (1 second)
    
    float vx = cos(angle * M_PI / 180) * speed;
    float vy = sin(angle * M_PI / 180) * speed;
    
    CGPoint direction = ccp(vx,vy);
    
    spikeball2.position = ccpAdd(spikeball2.position, direction);
    
    spikeball2.rotation = angle;
    
}

-(void) spikeballmovement3
{
    float angle = 225;
    float speed = 5; // Move 50 pixels in 60 frames (1 second)
    
    float vx = cos(angle * M_PI / 180) * speed;
    float vy = sin(angle * M_PI / 180) * speed;
    
    CGPoint direction = ccp(vx,vy);
    
    spikeball3.position = ccpAdd(spikeball3.position, direction);
    
    spikeball3.rotation = angle;
    
}

-(void) spikeballmovement4
{
    float angle = 315;
    float speed = 5; // Move 50 pixels in 60 frames (1 second)
    
    float vx = cos(angle * M_PI / 180) * speed;
    float vy = sin(angle * M_PI / 180) * speed;
    
    CGPoint direction = ccp(vx,vy);
    
    spikeball4.position = ccpAdd(spikeball4.position, direction);
    
    spikeball4.rotation = angle;
    
}

@end
