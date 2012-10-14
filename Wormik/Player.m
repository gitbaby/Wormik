//
//  Player.m
//  Wormik
//
//  Created by Oleksii Kozlov on 20.12.11.
//  Copyright 2012 Oleksii Kozlov. All rights reserved.
//

#import "Player.h"

@implementation Player

@synthesize isMoving;

+ (id)player
{
    Player *player = [[[Player alloc] initWithSpriteFrameName:@"player.png"] autorelease];
    player.anchorPoint = ccp(0.25f,0.6f);
    player.isMoving = NO;
    return player;
}

/*
- (void)draw
{
    [super draw];
    CGSize size = self.contentSize;
    glEnable(GL_LINE_SMOOTH);
    glColor4ub(255,0,0,255);
    glLineWidth(1);
    CGPoint vertices2[] = {
        ccp(0,0),
        ccp(0,size.height),
        ccp(size.width,size.height),
        ccp(size.width,0)
    };
    ccDrawPoly(vertices2,4,YES);
}
*/

- (void)goToPosition:(CGPoint)position
{
    isMoving = YES;
    [self runAction:[CCSequence actions:
                     [CCMoveTo actionWithDuration:0.15f position:position],
                     [CCCallFuncN actionWithTarget:self selector:@selector(moveFinished)],
                     nil]];
}

- (void)moveFinished
{
    isMoving = NO;
}

@end
