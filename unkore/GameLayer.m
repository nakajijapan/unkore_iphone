//
//  GameLayer.m
//  unkore
//
//  Created by Daichi Nakajima on 12/07/18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"


@implementation GameLayer
-(id) init
{
	if ((self = [super init]))
	{
		self.isTouchEnabled = YES;
		
		//gameLayerPosition = self.position;
		
		CGSize screenSize = [[CCDirector sharedDirector] winSize];
		
        // background
		CCSprite* background = [CCSprite spriteWithFile:@"game_background.png"];
		background.position = CGPointMake(screenSize.width / 2, screenSize.height / 2);
		[self addChild:background];
		
        
        // string
        /*
		CCLabelTTF* label = [CCLabelTTF labelWithString:@"GameLayer" fontName:@"Marker Felt" fontSize:44];
		label.color = ccBLACK;
		label.position = CGPointMake(screenSize.width / 2, screenSize.height / 2);
		label.anchorPoint = CGPointMake(0.5f, 1);
		[self addChild:label];
         */
        
		self.isTouchEnabled = YES;
	}
	return self;
}

@end
