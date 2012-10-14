//
//  Scene.h
//  Wormik
//
//  Created by Oleksii Kozlov on 25.12.11.
//  Copyright 2011 Oleksii Kozlov. All rights reserved.
//

#import "cocos2d.h"

@interface Scene : CCScene {
    CCLayer *layer;
}

@property (nonatomic, retain) CCLayer *layer;

- (id)initWithLayer:(CCLayer *)layer;

@end
