/*
 * Kobold2D™ --- http://www.kobold2d.org
 *
 * Copyright (c) 2010-2011 Steffen Itterheim. 
 * Released under MIT License in Germany (LICENSE-Kobold2D.txt).
 */

#import "HelloWorldLayer.h"
#import "SimpleAudioEngine.h"
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
        [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"bg.mp3"];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"bg.mp3"];
        glClearColor(255,255,255,255);
        
        CCSprite* bg = [CCSprite spriteWithFile:@"Background.png"];
        [self addChild:bg z:-2];
        bg.position = ccp(160,240);
        
        
        CCSprite* tick = [CCSprite spriteWithFile:@"tick.png"];
        tick.position = ccp(160,320);
        tick.scale = 0.3;
        [self addChild:tick z:1];
        
        //THE CLOCK ITSELF.
		clock = [CCSprite spriteWithFile:@"Wheel.png"];
        clock.position = ccp(160,240);
        [self addChild:clock];
        //The hail
        hail = [[NSMutableArray alloc] init];
        //The spikeball
        cards = [[NSMutableArray alloc] init];
        bombpieces = [[NSMutableArray alloc] init];

        mute = [CCSprite spriteWithFile:@"mute.png"];
        [self addChild:mute];
        mute.scale = 0.2;
        mute.position = ccp(295,20);
        
        center = [CCNode node];
        center.position = CGPointMake(160, 240);
        [self addChild:center];
        
        //PLAYER MODEL.
        player = [CCSprite spriteWithFile:@"player.png"];
        player.scale = 0.2;
        
        id tint = [CCTintTo actionWithDuration:1 red:0 green:0 blue:0];
        [player runAction:tint];
        
        [center addChild:player];
        
        // offset rotateMe from center by 100 points to the right
        player.position = CGPointMake(100, 0);
        
        // perform rotation of rotateMe around center by rotating center
        id rotate = [CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:2 angle:360]];
        [center runAction:rotate];

        //label
        score = [CCLabelTTF labelWithString:@"0" fontName:@"Helvetica-Bold" fontSize:32];
        score.position = ccp(160,440);
        [self addChild:score];
        
        //INITIATING VARIABLES
        playerrotation = 360;
        danger = 1;
        framespast = -100;
        fireballdirection = 210;
        isdead = false;
        tempframespast = 0;
        islightning = false;
        playerradius = 10;
        intscore = 0;
        shield = false;
        missledirection = 90;
        
        [self scheduleUpdate];
	}

	return self;
}


-(void) mute
{
    
    KKInput* input = [KKInput sharedInput];
    if ([input isAnyTouchOnNode:mute touchPhase:KKTouchPhaseBegan])
    {
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    }
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
    [self spikeballCollision];
    
    [self checkHail];
    [self checkSpike];
    [self shieldcollision];
    [self moveCard];
    [self missleDirections];
    [self moveMissle];
    [self moveBombPieces];
    [self bombCollision];
    [self missleCollision];
    
    [self mute];
    
    [self cardDie];
    
    framespast++;
    tempframespast--;
    
    
    
}








-(void) gameRand
{
    if((framespast % 200) == 0 && isdead == false)
    {
        [self removeChild:chocobg cleanup:YES];
        [self removeChild:fireball cleanup:YES];
        intscore += 100;
        NSString *tempstring = [NSString stringWithFormat:@"%d",intscore];
        [score setString:tempstring];
        random = arc4random() % 11;
        //int random = 6;
        
        [self performSelector:@selector(danger) withObject:nil afterDelay:1.0f];

        
        switch(random)
        {
                //fireball.
            case 0:
            {
                
                id rotate = [CCRotateTo actionWithDuration:1.0 angle:315];
                [clock runAction:rotate];
                break;
            }
                //hail
            case 1:
            {
                id rotate = [CCRotateTo actionWithDuration:1.0 angle:283];
                [clock runAction:rotate];
                break;
            }
                //meteor
            case 2:
            {
                
                id rotate = [CCRotateTo actionWithDuration:1.0 angle:255];
                [clock runAction:rotate];
                
                break;
            }
                //spike balls
            case 3:
            {
                
                id rotate = [CCRotateTo actionWithDuration:1.0 angle:225];
                [clock runAction:rotate];
                break;
            }
                //damger
            case 4:
            {
              
                
                id rotate = [CCRotateTo actionWithDuration:1.0 angle:15];
                [clock runAction:rotate];
                break;
            }
                //bounceing fire
            case 5:
            {
                
                id rotate = [CCRotateTo actionWithDuration:1.0 angle:135];
                [clock runAction:rotate];
                break;
            }
                //bomb.
            case 6:
            {
               
                id rotate = [CCRotateTo actionWithDuration:1.0 angle:105];
                [clock runAction:rotate];
                break;
            }
            case 7:
            {
                
                id rotate = [CCRotateTo actionWithDuration:1.0 angle:75];
                [clock runAction:rotate];
                break;
            }
            case 8:
            {
                ;
                id rotate = [CCRotateTo actionWithDuration:1.0 angle:45];
                [clock runAction:rotate];
                break;
            }
            
            case 9:
            {
                
                id rotate = [CCRotateTo actionWithDuration:1.0 angle:165];
                [clock runAction:rotate];
                
               
                break;
            }
            case 10:
            {
               

                id rotate = [CCRotateTo actionWithDuration:1.0 angle:195];
                [clock runAction:rotate];
                break;
            }
                
        }
    }
}



-(void)danger
{
    switch(random)
    {
            //fireball.
        case 0:
        {
            [self removeChild:fireball cleanup:YES];
            fireball = [CCSprite spriteWithFile:@"Fireball.png"];
            fireball.scale = 0.5;
            fireball.position = ccp(320,480);
            [self addChild:fireball];
       
            break;
        }
            //hail
        case 1:
        {
            tempframespast = 9000;
      
            break;
        }
            //meteor
        case 2:
        {
            [self removeChild:lightning cleanup:YES];
            lightning = [CCSprite spriteWithFile:@"meteor.png"];
            lightning.position = ccp(160 ,480);
            
            id move = [CCMoveTo actionWithDuration:3 position:ccp(160,50)];
            
            [lightning runAction:move];
            
            [self addChild:lightning];
            
            [self performSelector:@selector(deleteLightning) withObject:nil afterDelay:4.0f];
            islightning = true;
            
        
            break;
        }
            //spike balls
        case 3:
        {
            tempframespast = 18001;
           
            break;
        }
            //damger
        case 4:
        {
            for(int i = 0; i < 3;i++)
            {
                CCSprite* card = [CCSprite spriteWithFile:@"Cards.png"];
                [self addChild:card];
                card.scale = 0.5;
                card.position = ccp(445,(180*i)+30);
                [cards addObject:card];
                
            }
            
           
            break;
        }
            //bounceing fire
        case 5:
        {
            [self removeChild:missle cleanup:YES];
            missle = [CCSprite spriteWithFile:@"Fireball.png"];
            missle.scale = 0.5;
            missle.position = ccp(360,240);
            [self addChild:missle];
         
            break;
        }
            //bomb.
        case 6:
        {
            bomb = [CCSprite spriteWithFile:@"Bomb.png"];
            bomb.position = ccp(160,480);
            [self addChild:bomb];
            
            id move = [CCMoveTo actionWithDuration:1 position:ccp(160,300)];
            [bomb runAction:move];
            [self performSelector:@selector(bombexplode) withObject:nil afterDelay:1.0f];
            
         
            break;
        }
        case 7:
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
        case 8:
        {
            tempframespast = 18001;
            
            break;
        }
            
        case 9:
        {
            
            
            //chocolate
            playerradius = 25;
            id scale = [CCScaleTo actionWithDuration:1 scale:0.5];
            [player runAction:scale];
            [self performSelector:@selector(backthing) withObject:nil afterDelay:10.0f];
         
            chocobg = [CCSprite spriteWithFile:@"Chocobackground.png"];
            chocobg.position = ccp(160,240);
            [self addChild:chocobg z:-1];
            break;
        }
        case 10:
        {
            //shield
            
            
            
            
            shieldsprite = [CCSprite spriteWithFile:@"shield.png"];
            shieldsprite.scale = 0.3;
            shieldsprite.position = ccp(320,480);
            [self addChild:shieldsprite];
            
            id move = [CCMoveTo actionWithDuration:3 position:ccp(0,0)];
            
            [shieldsprite runAction:move];
            
            
            [self performSelector:@selector(delete) withObject:nil afterDelay:3.0f];
            
            
            break;
        }
            
    }
}
































-(void) bombexplode
{
    for(int i = 0; i < 6; i++)
    {
        CCSprite* bombpiece = [CCSprite spriteWithFile:@"pieceofbomb.png"];
        bombpiece.position = bomb.position;
        [self addChild:bombpiece];
        [bombpieces addObject:bombpiece];
    }
    
    [self removeChild:bomb cleanup:YES];
}



-(void) moveBombPieces
{
    for(int i = 0; i < [bombpieces count]; i++)
    {
        NSLog(@"mvoe");
        CCSprite* temp = [bombpieces objectAtIndex:i];
        float angle = (i*60) + 20;
        float speed = 3; // Move 50 pixels in 60 frames (1 second)
        
        float vx = cos(angle * M_PI / 180) * speed;
        float vy = sin(angle * M_PI / 180) * speed;
        
        CGPoint direction = ccp(vx,vy);
        
        temp.position = ccpAdd(temp.position, direction);
        
        temp.rotation = angle;
    }
}


-(void) delete
{
    [self removeChild:shieldsprite cleanup:YES];

}

-(void) moveCard
{
    for(int i = 0; i < [cards count];i++)
        {
            CCSprite* temp = [cards objectAtIndex:i];
            temp.position = ccp(temp.position.x - 6, temp.position.y);
        }
}

-(void) backthing
{
    playerradius = 10;
    [player stopAllActions];
    id scale = [CCScaleTo actionWithDuration:1 scale:0.2];
    [player runAction:scale];
    
    [self removeChild:chocobg cleanup:YES];
    
    [self unschedule:@selector(backthing)];
}

-(void) shieldoff
{
    [player stopAllActions];
    shield = false;
    id tint = [CCTintTo actionWithDuration:1.0f red:0 green:0 blue:0];
    [player runAction:tint];
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

-(void) cardDie
{
    for(int i = 0; i < [cards count]; i++)
    {
        if([self isCollidingRect:[cards objectAtIndex:i] WithSphere:player])
        {
            [self deadPlayer];
        }
    }
    
}

-(BOOL) isCollidingRect:(CCSprite *) spriteOne WithSphere:(CCSprite *) spriteTwo
{

    return CGRectIntersectsRect([spriteOne boundingBox],CGRectMake(actualPosition.x,actualPosition.y,playerradius*2,playerradius*2));
}

-(void) deleteLightning
{
    [self removeChild:lightning];
    islightning = false;
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


-(void) missleDirections
{
    if(missledirection < 270)
    {
        missledirection = missledirection + 2;
    }
    else if(missledirection >= 270)
    {
        missledirection = 90;
    }
}


-(void) moveMissle
{
    float angle = missledirection;
    float speed = 5; // Move 50 pixels in 60 frames (1 second)
    
    float vx = cos(angle * M_PI / 180) * speed;
    float vy = sin(angle * M_PI / 180) * speed;
    
    CGPoint direction = ccp(vx,vy);
    
    missle.position = ccpAdd(missle.position, direction);
    
    missle.rotation = angle;
    
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
    
    
    if(framespast > 3)
    {
        float diff = ccpDistance(actualPosition, fireball.position);
        if (diff <  playerradius + 80) {
            [self deadPlayer];
            
        }
    }
}

-(void) missleCollision
{
   
    
    
    if(framespast > 3)
    {
        float diff = ccpDistance(actualPosition, missle.position);
        if (diff <  playerradius + 80) {
            [self deadPlayer];
            
        }
    }
}

-(void) spikeballCollision
{
    if(framespast > 3)
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
            if (diff <  playerradius + 10) {
                [self deadPlayer];
                
            }
        }
}

-(void) bombCollision
{
    
    
    for(int i = 0; i < [bombpieces count];i++)
    {
        CCSprite* temp = [bombpieces objectAtIndex:i];
        float diff = ccpDistance(actualPosition, temp.position);
        if (diff <  playerradius + 20) {
            [self deadPlayer];
            
        }
    }
}

-(void) shieldcollision
{

        float diff = ccpDistance(actualPosition, shieldsprite.position);
        if (diff <  playerradius + 20) {
            shield = true;
            [self performSelector:@selector(shieldoff) withObject:nil afterDelay:10.0f];
            
            [player stopAllActions];
            
            id tint = [CCTintTo actionWithDuration:1.0f red:0 green:255 blue:0];
            [player runAction:tint];
            
           
            
            
            [self removeChild:shieldsprite cleanup:YES];

            
        }
    
}

-(void) deadPlayer
{
    if(isdead == false)
    {
        if(shield == false)
        {
        [self removeChild:score cleanup:YES];
        [center removeChild:player];
            
        NSString* tempstring = [NSString stringWithFormat:@"Game Over\n %d points",intscore];
        youdie = [CCLabelTTF labelWithString:tempstring fontName:@"Helvetica" fontSize:48];
        youdie.color = ccc3(0, 0, 0);
        [self addChild:youdie];
        youdie.position = ccp(160,400);
        isdead = true;
            
            CCSprite* ring = [CCSprite spriteWithFile:@"ring.png"];
            ring.scale = 0;
            id expand = [CCScaleTo actionWithDuration:2 scale:6];
            id fade = [CCFadeOut actionWithDuration:2];
            [self addChild:ring];
            ring.position = actualPosition;
            [ring runAction:expand];
            [ring runAction:fade];
            
            
            if(intscore > [[NSUserDefaults standardUserDefaults] integerForKey:@"highscore"])
            {
                [[NSUserDefaults standardUserDefaults] setInteger:intscore forKey:@"highscore"];
            }
            
            
            NSString* tempstring2 = [NSString stringWithFormat:@"high score: %d",[[NSUserDefaults standardUserDefaults] integerForKey:@"highscore"]];
            highscore = [CCLabelTTF labelWithString:tempstring2 fontName:@"Helvetica" fontSize:16];
            highscore.color = ccc3(0, 0, 0);
            [self addChild:highscore];
            highscore.position = ccp(160,20);
            
            
            retry = [CCLabelTTF labelWithString:@" Retry?" fontName:@"Helvetica" fontSize:64];
            retry.color = ccc3(0, 0, 0);
            [self addChild:retry];
            retry.position = ccp(160,100);
        }
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



@end
