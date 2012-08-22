//
//  RandomMoveComponent.m
//  unkore
//
//  Created by Daichi Nakajima on 12/08/06.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "RandomMoveComponent.h"

@implementation RandomMoveComponent
-(id) init
{
	if ((self = [super init]))
	{
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        velocity = CGPointMake(0,  - screenSize.height );
        
        // 更新開始
        [self scheduleUpdate];
        
        // 通常の移動フラグ
        isMoving = NO;
	}
    
	return self;
}
#pragma mark -
#pragma mark random
- (float) randomDuration
{
    return CCRANDOM_0_1() + 1.0;
}
- (float) randomBeteen
{
    // 0 - 2
    return (int)(CCRANDOM_0_1() * 100) % 3;
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
            
            isMoving = YES;

            // フェードインさせる
            [entity setOpacity:1.0];
            CGSize screenSize = [[CCDirector sharedDirector] winSize];
            moveType = [self randomBeteen];

            if (moveType == 0) {
                velocity = CGPointMake(screenSize.width * 3/4,  screenSize.height* 3/4);
            }
            else if (moveType == 1) {
                velocity = CGPointMake(screenSize.width * 1/4,  screenSize.height* 3/4);
            }
            else if (moveType == 2) {
                velocity = CGPointMake(screenSize.width / 2,  screenSize.height * 1.5);
            }
            else {
                [NSException exceptionWithName:@"RandomMove Exception" reason:@"no exist move type" userInfo:nil];
            }
            
            // 位置を初期化
            [entity setPosition:velocity];
            
            CCFadeTo *fadeIn = [CCFadeTo actionWithDuration:0.5 opacity:255];
            CCSequence* sequence = [CCSequence actions:fadeIn, nil];
            [entity runAction:sequence];

            [self runRandomMoveSequence:entity];
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
        /*
        else if (entity.position.y <= -200) {
            CCLOG(@"before-- entity.position = %@", NSStringFromCGPoint(entity.position));
            velocity.x *= 2;
            velocity.y *= 2;
            [entity setPosition:ccpAdd(entity.position, ccpMult(velocity,delta))];
            CCLOG(@"after-- entity.position = %@", NSStringFromCGPoint(entity.position));
        }
        */
	}
}
#pragma mark -
#pragma mark random
-(void) runRandomMoveSequence:(CCNode*)node
{
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    if (moveType == 0) {
        id move1 = [CCMoveTo actionWithDuration:[self randomDuration] position:CGPointMake(0, screenSize.height * 3 / 5)];
        id ease1 = [CCEaseBounceOut actionWithAction:move1];
        
        id move2 = [CCMoveTo actionWithDuration:[self randomDuration] position:CGPointMake(screenSize.width * 3 / 4, screenSize.height * 2 / 5)];
        id ease2 = [CCEaseBounceOut actionWithAction:move2];
        
        id move3 = [CCMoveTo actionWithDuration:[self randomDuration] position:CGPointMake(0, screenSize.height *  1 / 5)];
        id move4 = [CCMoveTo actionWithDuration:[self randomDuration] position:CGPointMake(screenSize.width * 3 / 4, screenSize.height * 1 / 5)];
        id move5 = [CCMoveTo actionWithDuration:[self randomDuration] position:CGPointMake(0, -300)];
        CCSequence* sequence = [CCSequence actions:ease1, ease2, move3, move4, move5, nil];
        [node runAction:sequence];
    }
    else if (moveType == 1) {
        id move1 = [CCMoveTo actionWithDuration:[self randomDuration] position:CGPointMake(screenSize.width * 3 / 4, screenSize.height * 3 / 5)];
        id ease1 = [CCEaseBounceOut actionWithAction:move1];
        
        id move2 = [CCMoveTo actionWithDuration:[self randomDuration] position:CGPointMake(0, screenSize.height * 2 / 5)];
        id ease2 = [CCEaseBounceOut actionWithAction:move2];
        
        id move3 = [CCMoveTo actionWithDuration:[self randomDuration] position:CGPointMake(screenSize.width * 3 / 4, screenSize.height *  1 / 5)];
        id move4 = [CCMoveTo actionWithDuration:[self randomDuration] position:CGPointMake(0, screenSize.height * 1 / 5)];
        id move5 = [CCMoveTo actionWithDuration:[self randomDuration] position:CGPointMake(screenSize.width * 3 / 4, -300)];
        CCSequence* sequence = [CCSequence actions:ease1, ease2, move3, move4, move5, nil];
        [node runAction:sequence];
    }
    else if (moveType == 2) {
        id moveTo       = [CCMoveTo actionWithDuration:.5f position:ccp(screenSize.width / 2, screenSize.height * 0.4 )];
        id delayOneSec  = [CCDelayTime actionWithDuration:2.0f];
        id scale        = [CCScaleBy actionWithDuration:2.0f scale:2.0];
        id spawn        = [CCSpawn actions:delayOneSec, scale, nil];
        id moveEnd      = [CCMoveTo actionWithDuration:.1f position:ccp(screenSize.width / 2, -300)];
        CCSequence* sequence = [CCSequence actions:moveTo, spawn, moveEnd, nil];
        [node runAction:sequence];
    }
}


@end
