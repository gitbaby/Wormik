//
//  LevelCompleteLayer.h
//  Wormik
//
//  Created by Oleksii Kozlov on 23.12.11.
//  Copyright 2011 Oleksii Kozlov. All rights reserved.
//

#import "cocos2d.h"

@class Scene;

@interface LevelCompleteLayer : CCLayer {
    BOOL touched;
}

+ (Scene *)scene;

@end
