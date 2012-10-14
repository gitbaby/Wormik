//
//  Player.h
//  Wormik
//
//  Created by Oleksii Kozlov on 20.12.11.
//  Copyright 2012 Oleksii Kozlov. All rights reserved.
//

#import "cocos2d.h"

@interface Player : CCSprite {
    BOOL    isMoving;
}

@property (nonatomic, assign) BOOL isMoving;

+ (id)player;

- (void)goToPosition:(CGPoint)position;

@end
