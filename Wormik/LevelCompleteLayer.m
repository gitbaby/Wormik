//
//  LevelCompleteLayer.m
//  Wormik
//
//  Created by Oleksii Kozlov on 23.12.11.
//  Copyright 2011 Oleksii Kozlov. All rights reserved.
//

#import "LevelCompleteLayer.h"
#import "Scene.h"
#import "SceneManager.h"

@implementation LevelCompleteLayer

+ (Scene *)scene
{
	return [[[Scene alloc] initWithLayer:[LevelCompleteLayer node]] autorelease];
}

- (id)init
{
    self = [super init];
	if (self) {
        CGSize winSize = [[CCDirector sharedDirector] winSize];

		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Level Complete" fontName:@"Chalkduster" fontSize:32];
		label.color = ccc3(255,255,0);
		label.position = ccp(winSize.width/2,winSize.height/2);
		[self addChild:label];

        self.isTouchEnabled = YES;
	}
	return self;
}

- (void)onEnterTransitionDidFinish
{
    touched = NO;
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    touched = YES;
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (touched) [[SceneManager sharedSceneManager] nextLevel];
}

@end
