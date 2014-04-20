//
//  Title.m
//  Time
//
//  Created by Kevin Frans on 4/20/14.
//
//

#import "Title.h"
#import "HelloWorldLayer.h"

@implementation Title

-(id) init
{
	if ((self = [super init]))
	{
        glClearColor(255, 255, 255, 255);
        [self scheduleUpdate];
        
        CCLabelTTF* label = [CCLabelTTF labelWithString:@"Twisted Fate" fontName:@"Helvetica" fontSize:56];
        label.color = ccc3(0,0,0);
        label.position = [CCDirector sharedDirector].screenCenter;
        [self addChild:label];
    }
    return self;
}


-(void)update:(ccTime)dt
{
    KKInput* input = [KKInput sharedInput];
    
    
    
    if (input.anyTouchBeganThisFrame) {
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[HelloWorldLayer scene] ]];
    }
}
@end
