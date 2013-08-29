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
		
		CGSize screenSize = [[CCDirector sharedDirector] winSize];
		
        //-----------------------------------------------
        // 背景
        //-----------------------------------------------
		CCSprite* background = [CCSprite spriteWithFile:@"game_background.png"];
		background.position = CGPointMake(screenSize.width, screenSize.height);
        background.anchorPoint = ccp(1, 1);
		[self addChild:background z:0];
        
        
        //-----------------------------------------------
        // 雲
        //-----------------------------------------------
        int numClouds = 8;
        
        // バッチノードの初期化
        CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"game_cloud001.png"];
        spriteBatch = [CCSpriteBatchNode batchNodeWithTexture:frame.texture];
        
        
        //CCSpriteBatchNode貼付け
        [self addChild:spriteBatch];
        
        // speed
        speedFactors = [[CCArray alloc] initWithCapacity:numClouds];
        [speedFactors addObject:[NSNumber numberWithFloat:0.3f]];
        [speedFactors addObject:[NSNumber numberWithFloat:0.3f]];
		[speedFactors addObject:[NSNumber numberWithFloat:0.5f]];
		[speedFactors addObject:[NSNumber numberWithFloat:0.5f]];
		[speedFactors addObject:[NSNumber numberWithFloat:0.8f]];
		[speedFactors addObject:[NSNumber numberWithFloat:0.8f]];
		[speedFactors addObject:[NSNumber numberWithFloat:1.2f]];
		[speedFactors addObject:[NSNumber numberWithFloat:1.2f]];
        NSAssert([speedFactors count] == numClouds, @"speedFactors count does not match numClouds!");

		
        // cloud
        NSArray* positions = [NSArray arrayWithObjects:
                              [NSValue valueWithCGPoint:ccp(screenSize.width * 0.25, screenSize.height * 0.90)],
                              [NSValue valueWithCGPoint:ccp(screenSize.width * 0.75, screenSize.height * 0.90)],
                              [NSValue valueWithCGPoint:ccp(screenSize.width * 0.50, screenSize.height * 0.78)],

                              [NSValue valueWithCGPoint:ccp(screenSize.width * 0.25, screenSize.height * 0.65)],
                              [NSValue valueWithCGPoint:ccp(screenSize.width * 0.75, screenSize.height * 0.65)],
                              [NSValue valueWithCGPoint:ccp(screenSize.width * 0.40, screenSize.height * 0.5)],
                              
                              [NSValue valueWithCGPoint:ccp(screenSize.width * 0.20, screenSize.height * 0.35)],
                              [NSValue valueWithCGPoint:ccp(screenSize.width * 0.70, screenSize.height * 0.4)],
                              nil];
        NSAssert([positions count] == numClouds, @"positions count does not match numClouds!");


        for (int cnt=0; cnt < numClouds; cnt++) {
            NSValue* value = [positions objectAtIndex:cnt];
            NSString* imageName = [NSString stringWithFormat:@"game_cloud%03d.png", cnt + 1];
            CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:imageName];
            CCSprite* cloud001 = [CCSprite spriteWithSpriteFrame:frame];
            cloud001.position = [value CGPointValue];
            //[self addChild:cloud001];
            
            [spriteBatch addChild:cloud001 z:cnt tag:cnt];
            

        }
        
        for (int cnt=0; cnt < [positions count]; cnt++) {
            NSValue* value = [positions objectAtIndex:cnt];
            NSString* imageName = [NSString stringWithFormat:@"game_cloud%03d.png", cnt + 1];
            CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:imageName];
            CCSprite* cloud001 = [CCSprite spriteWithSpriteFrame:frame];
            
            CGPoint readyPosition = [value CGPointValue];
            readyPosition.x += screenSize.width;
            cloud001.position = readyPosition;
            [spriteBatch addChild:cloud001 z:cnt tag:cnt + numClouds];

        }

        //フレームごとにアップデート開始
        [self scheduleUpdate];
       
		self.isTouchEnabled = YES;
	}
	return self;
}

-(void) update:(ccTime)delta
{
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
	CCSprite* sprite;
	CCARRAY_FOREACH([spriteBatch children], sprite)	{
		NSNumber* factor = [speedFactors objectAtIndex:sprite.zOrder];
		
		CGPoint pos = sprite.position;
		pos.x -= 1.0 * [factor floatValue];
		
		// Reposition stripes when they're out of bounds
		if (pos.x < -screenSize.width) {
			pos.x += (screenSize.width * 2) - 2;
		}
		
		sprite.position = pos;
	}
}
@end
