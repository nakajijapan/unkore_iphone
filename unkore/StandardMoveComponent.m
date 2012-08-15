//
//  StandardMoveComponent.m
//  unkore
//
//  Created by Daichi Nakajima on 12/07/18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "StandardMoveComponent.h"

@implementation StandardMoveComponent

-(id) init
{
	if ((self = [super init]))
	{
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        velocity = CGPointMake(0,  - screenSize.height);

        // 更新開始
        [self scheduleUpdate];

        // 通常の移動フラグ
        isMoving = NO;
	}
    
	return self;
}

#pragma mark -
#pragma mark update
-(void) update:(ccTime)delta
{
	if (self.parent.visible) {
		NSAssert([self.parent isKindOfClass:[Entity class]], @"node is not a Entity");
		
        EnemyEntity* entity = (EnemyEntity*)self.parent;
        
        // まだ移動がおこなわれていない
        if (isMoving == NO) {
            CGSize screenSize = [[CCDirector sharedDirector] winSize];
            isMoving = YES;
            id moveTo       = [CCMoveTo actionWithDuration:.5f position:ccp(screenSize.width / 2, screenSize.height * 0.4 )];
            id delayOneSec  = [CCDelayTime actionWithDuration:1.0f];
            id moveEnd      = [CCMoveTo actionWithDuration:.1f position:ccp(screenSize.width / 2, -200)];
            CCSequence* sequence = [CCSequence actions:moveTo, delayOneSec, moveEnd, nil];
            [entity runAction:sequence];
        }
        
        //CCLOG(@"----------------------entity.position = %@", NSStringFromCGPoint(entity.position));
        // 特定の位置にきた時点での操作
        if (entity.position.y <= -300) {
            
            CCLOG(@"set no visible");
            // 見えない位置へ
            [entity setPosition: CGPointMake(entity.position.x, -500)];
            entity.visible = NO;
            [self unscheduleUpdate];
            
            isMoving = NO;
            CCLOG(@"---- %@", NSStringFromCGPoint(entity.position));
            
            // タッチしてはいけない敵以外
            if (entity.type < EnemyTypeOut001) {
                // 最後までタッチしきれなかったらゲームオーバ
                if (entity.hitPoints >= 1) {
                    CCLOG(@"game over: タッチしきれなかった！");
                    [[GameScene sharedGameScene] onGameOver];
                }
            }
        }        
        else if (entity.position.y <= -200) {
            velocity.x *= 2;
            velocity.y *= 2;
            [entity setPosition:ccpAdd(entity.position, ccpMult(velocity,delta))];
            CCLOG(@"entity.position = %@", NSStringFromCGPoint(entity.position));
        }
	}
}

@end
