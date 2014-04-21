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
    
    int random;
    
    CCLabelTTF* highscore;
    int inthighscore;
    
    CCSprite* clock;
    CCSprite* player;
    CCNode* center;
    
    CGPoint actualPosition;
    CGPoint worldPosition;
    
    CCSprite* fireball;
    
    CCSprite* lightning;
    
    CCSprite* chocobg;
        
    CCSprite* missle;
    
    CCSprite* mute;
    
    CCSprite* bomb;
    
    NSMutableArray* bombpieces;
    
    int fireballdirection;
    int missledirection;
    int playerrotation;
    int danger;
    int framespast;
    int tempframespast;
    int playerradius;
    
    bool isdead;
    
    CCLabelTTF *youdie;
    CCLabelTTF* retry;
    
    NSMutableArray* hail;
    NSMutableArray* cards;
    
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
