//
//  GamePlayLayer.m
//  Wormik
//
//  Created by Oleksii Kozlov on 19.12.11.
//  Copyright 2012 Oleksii Kozlov. All rights reserved.
//

#import "GamePlayLayer.h"
#import "Scene.h"
#import "SceneManager.h"
#import "Player.h"

@implementation GamePlayLayer

@synthesize level;

+ (Scene *)scene
{
	return [[[Scene alloc] initWithLayer:[GamePlayLayer node]] autorelease];
}

- (CGPoint)tileCoordForPosition:(CGPoint)position {
    int x = position.x / tileMap.tileSize.width;
    int y = tileMap.mapSize.height - position.y / tileMap.tileSize.height;
    return ccp(x,y);
}

- (CGPoint)positionForTileCoord:(CGPoint)coord {
    float x = coord.x * tileMap.tileSize.width;
    float y = (tileMap.mapSize.height - coord.y) * tileMap.tileSize.height;
    return ccp(x,y);
}

- (id)init
{
    self = [super init];
	if (self) {
        level = 1;
        background = nil;
        tileMap = nil;

        NSString *spritesPngFile;
        NSString *spritesPlistFile;

        spritesPngFile      = @"sprites.png";
        spritesPlistFile    = @"sprites.plist";

        // Create a sprite batch node
        CCSpriteBatchNode *batchNode = [CCSpriteBatchNode batchNodeWithFile:spritesPngFile];
        [self addChild:batchNode z:0];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:spritesPlistFile];

        // Add finish
        finish = [CCSprite spriteWithSpriteFrameName:@"finish.png"];
        finish.anchorPoint = ccp(0.25f,0.6f);
        [batchNode addChild:finish];

        // Add player
        player = [Player player];
        [batchNode addChild:player];
	}
	return self;
}

- (void)dealloc
{
	[super dealloc];
}

- (void)startGame
{
    // Enable touch events
    self.isTouchEnabled = YES;

    isTouching = NO;

    [self scheduleUpdate];
}

- (void)stopGame
{
    // Disable touch events
    self.isTouchEnabled = NO;

    [self unscheduleAllSelectors];
}

- (void)onEnterTransitionDidFinish
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    NSString *backgroundPngFile;
    NSString *mapFile;
    
    backgroundPngFile   = [NSString stringWithFormat:@"level%d-bg.png", level];
    mapFile             = [NSString stringWithFormat:@"level%d.tmx", level];
    
    // Add background
    if (background != nil) [self removeChild:background cleanup:YES];
    background = [CCSprite spriteWithFile:backgroundPngFile];
    background.position = ccp(winSize.width/2, winSize.height/2);
    [self addChild:background z:-2];
    
    // Add map
    if (tileMap != nil) [self removeChild:tileMap cleanup:YES];
    tileMap = [CCTMXTiledMap tiledMapWithTMXFile:mapFile];
    backgroundLayer = [tileMap layerNamed:@"Background"];
    pathLayer = [tileMap layerNamed:@"Path"];
    pathLayer.visible = NO;
    [self addChild:tileMap z:-1];
    
    // Get objects
    CCTMXObjectGroup *objects = [tileMap objectGroupNamed:@"Objects"];
    NSAssert(objects != nil, @"Objects object group not found");
    
    // Get player's spawn point
    NSDictionary *spawnPointObj = [objects objectNamed:@"SpawnPoint"];        
    NSAssert(spawnPointObj != nil, @"SpawnPoint object not found");
    spawnPoint = ccp([[spawnPointObj valueForKey:@"x"] floatValue], [[spawnPointObj valueForKey:@"y"] floatValue]);
    spawnPoint = [self positionForTileCoord:[self tileCoordForPosition:spawnPoint]];
    player.position = spawnPoint;
    
    // Get exit point
    NSDictionary *exitPointObj = [objects objectNamed:@"ExitPoint"];        
    NSAssert(exitPointObj != nil, @"ExitPoint object not found");
    exitPoint = ccp([[exitPointObj valueForKey:@"x"] floatValue], [[exitPointObj valueForKey:@"y"] floatValue]);
    exitPoint = [self positionForTileCoord:[self tileCoordForPosition:exitPoint]];
    finish.position = exitPoint;

    [self startGame];
}

- (BOOL)canGoToPosition:(CGPoint)position
{
    CGPoint tileCoord = [self tileCoordForPosition:position];
    int tileGid = [pathLayer tileGIDAt:tileCoord];
    if (!tileGid) return NO;
    NSDictionary *properties = [tileMap propertiesForGID:tileGid];
    if (!properties) return NO;
    NSString *collision = [properties valueForKey:@"Path"];
    if (!collision || [collision compare:@"True"] != NSOrderedSame) return NO;
    return YES;
}

- (void)goToPosition:(CGPoint)position
{
    if (position.x == exitPoint.x && position.y == exitPoint.y) {
        [self stopGame];
        [[SceneManager sharedSceneManager] loadLevelCompleteScene];
    } else {
        [player goToPosition:position];
    }
}

- (void)movePlayer
{
    CGPoint playerPosX = player.position;
    CGPoint diff = ccpSub(touchLocation, playerPosX);
    CGPoint playerPosY = playerPosX;
    float absX = abs(diff.x);
    BOOL canGoX = NO;
    if (absX > 0) {
        if (diff.x > 0) {
            playerPosX.x += tileMap.tileSize.width;
        } else {
            playerPosX.x -= tileMap.tileSize.width;
        }
        canGoX = [self canGoToPosition:playerPosX];
    }
    float absY = abs(diff.y);
    BOOL canGoY = NO;
    if (absY > 0) {
        if (diff.y > 0) {
            playerPosY.y += tileMap.tileSize.height;
        } else {
            playerPosY.y -= tileMap.tileSize.height;
        }
        canGoY = [self canGoToPosition:playerPosY];
    }
    if (canGoX && canGoY) {
        if (absX > absY) {
            [self goToPosition:playerPosX];
        } else {
            [self goToPosition:playerPosY];
        }
    } else if (canGoX) {
        [self goToPosition:playerPosX];
    } else if (canGoY) {
        [self goToPosition:playerPosY];
    }
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];

    isTouching = YES;
    touchLocation = [self positionForTileCoord:[self tileCoordForPosition:location]];
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    isTouching = YES;
    touchLocation = [self positionForTileCoord:[self tileCoordForPosition:location]];
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    isTouching = NO;
}

- (void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    isTouching = NO;
}

- (void)update:(ccTime)dt
{
    if (isTouching && !player.isMoving) [self movePlayer];
}

@end
