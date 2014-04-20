/*
 * Kobold2D™ --- http://www.kobold2d.org
 *
 * Copyright (c) 2010-2011 Steffen Itterheim. 
 * Released under MIT License in Germany (LICENSE-Kobold2D.txt).
 */

#import "cocos2d.h"

@interface HelloWorldLayer : CCLayer
{
	NSString* helloWorldString;
	NSString* helloWorldFontName;
	int helloWorldFontSize;
    
    CCLabelTTF *score;
    int intscore;
    
    CCSprite* clock;
    CCSprite* player;
    CCNode* center;
    
    CGPoint actualPosition;
    CGPoint worldPosition;
    
    CCSprite* fireball;
    
    CCSprite* lightning;
    
    CCSprite* chocobg;
    
    int fireballdirection;
    int playerrotation;
    int danger;
    int framespast;
    int tempframespast;
    int playerradius;
    
    bool isdead;
    
    CCLabelTTF *youdie;
    
    NSMutableArray* hail;
    
    CCSprite* spikeball;
    CCSprite* spikeball2;
    CCSprite* spikeball3;
    CCSprite* spikeball4;
    
    CCSprite* shieldsprite;
    
    bool islightning;
    bool shield;
}

+(id) scene;

@property (nonatomic, copy) NSString* helloWorldString;
@property (nonatomic, copy) NSString* helloWorldFontName;
@property (nonatomic) int helloWorldFontSize;

@end
