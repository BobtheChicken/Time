//
//  Title.m
//  Time
//
//  Created by Kevin Frans on 4/20/14.
//
//

#import "Title.h"
#import "HelloWorldLayer.h"
#import "SimpleAudioEngine.h"

@implementation Title

-(id) init
{
	if ((self = [super init]))
	{
        glClearColor(255, 255, 255, 255);
        
        CCSprite* bg =[CCSprite spriteWithFile:@"titlebackground.png"];
        bg.position = ccp(160,240);
        [self addChild:bg];
        
        
        [self scheduleUpdate];
        
        CCLabelTTF* label = [CCLabelTTF labelWithString:@"tap to begin" fontName:@"Helvetica" fontSize:32];
        label.color = ccc3(0,0,0);
        label.position = ccp(160,50);
        [self addChild:label];
        [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"intro.mp3"];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"intro.mp3"];
        
        
        [label setOpacity:1.0];
        CCFadeTo *fadeIn = [CCFadeTo actionWithDuration:1 opacity:0];
        CCFadeTo *fadeOut = [CCFadeTo actionWithDuration:1 opacity:255];
        
        CCSequence *pulseSequence = [CCSequence actionOne:fadeIn two:fadeOut];
        CCRepeatForever *repeat = [CCRepeatForever actionWithAction:pulseSequence];
        [label runAction:repeat];
        
        
        wheel = [CCSprite spriteWithFile:@"Wheel.png"];
        wheel.position = ccp(160,180);
        [self addChild:wheel];
        
        
        
    }

    return self;
}


-(void)update:(ccTime)dt
{
    KKInput* input = [KKInput sharedInput];
    
    
    
    if (input.anyTouchBeganThisFrame) {
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[HelloWorldLayer scene] ]];
    }
    
    
    
    wheel.rotation = wheel.rotation + 3;
}
@end
