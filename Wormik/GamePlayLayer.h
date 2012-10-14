//
//  GamePlayLayer.h
//  Wormik
//
//  Created by Oleksii Kozlov on 19.12.11.
//  Copyright 2012 Oleksii Kozlov. All rights reserved.
//

#import "cocos2d.h"

@class Scene;
@class Player;

@interface GamePlayLayer : CCLayer
{
    int             level;
    CCSprite        *background;
    CCTMXTiledMap   *tileMap;
    CCTMXLayer      *backgroundLayer;
    CCTMXLayer      *pathLayer;
    CGPoint         spawnPoint;
    CGPoint         exitPoint;
    Player          *player;
    CCSprite        *finish;
    BOOL            isTouching;
    CGPoint         touchLocation;
}

@property (nonatomic, assign) int level;

+ (Scene *)scene;

@end
