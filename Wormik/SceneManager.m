//
//  SceneManager.m
//  Wormik
//
//  Created by Oleksii Kozlov on 24.12.11.
//  Copyright (c) 2011 Oleksii Kozlov. All rights reserved.
//

#import "SceneManager.h"
#import "Scene.h"
#import "GamePlayLayer.h"
#import "LevelCompleteLayer.h"
#import "LeaderBoardLayer.h"

#define totalLevels 2

@implementation SceneManager

@synthesize gamePlayScene;
@synthesize levelCompleteScene;
@synthesize leaderBoardScene;

SYNTHESIZE_SINGLETON_FOR_CLASS(SceneManager);

- (id)init 
{
    if ((self = [super init])) {
        self.gamePlayScene      = [GamePlayLayer scene];
        self.levelCompleteScene = [LevelCompleteLayer scene];
        self.leaderBoardScene   = [LeaderBoardLayer scene];
    }
    return self;
}

- (void)loadFirstScene
{
	[[CCDirector sharedDirector] runWithScene:gamePlayScene];
}

- (void)firstLevel
{
    ((GamePlayLayer *)gamePlayScene.layer).level = 1;
    [[CCDirector sharedDirector] replaceScene:gamePlayScene];
}

- (void)nextLevel
{
    ((GamePlayLayer *)gamePlayScene.layer).level++;
    [[CCDirector sharedDirector] replaceScene:gamePlayScene];
}

- (void)loadLevelCompleteScene
{
    if (((GamePlayLayer *)gamePlayScene.layer).level < totalLevels) {
        [[CCDirector sharedDirector] replaceScene:levelCompleteScene];
    } else {
        [[CCDirector sharedDirector] replaceScene:leaderBoardScene];
    }
}

@end
