//
//  SceneManager.h
//  Wormik
//
//  Created by Oleksii Kozlov on 24.12.11.
//  Copyright (c) 2011 Oleksii Kozlov. All rights reserved.
//

#import "SynthesizeSingleton.h"

@class Scene;

@interface SceneManager : NSObject
{
    Scene *gamePlayScene;
    Scene *levelCompleteScene;
    Scene *leaderBoardScene;
}

@property (nonatomic, retain) Scene *gamePlayScene;
@property (nonatomic, retain) Scene *levelCompleteScene;
@property (nonatomic, retain) Scene *leaderBoardScene;

SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(SceneManager);

- (void)loadFirstScene;
- (void)firstLevel;
- (void)nextLevel;
- (void)loadLevelCompleteScene;

@end
