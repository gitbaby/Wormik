//
//  Scene.m
//  Wormik
//
//  Created by Oleksii Kozlov on 25.12.11.
//  Copyright 2011 Oleksii Kozlov. All rights reserved.
//

#import "Scene.h"

@implementation Scene

@synthesize layer;

- (id)initWithLayer:(CCLayer *)aLayer
{
	if ((self = [super init])) {
		self.layer = aLayer;
		[self addChild:aLayer];
	}
	return self;
}

- (void)dealloc
{
	self.layer = nil;
	[super dealloc];
}

@end
