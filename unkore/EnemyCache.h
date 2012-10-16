//
//  EnemyCache.h
//  unkore
//
//  Created by Daichi Nakajima on 12/07/18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#define UK_INTERVAL_ENEMY_GANERATE_NORMAL    1.2f
#define UK_INTERVAL_ENEMY_GANERATE_DIFFICULT 0.5f
#define UK_CHANGE_SCORE_TO_DIFFCULT 500

@interface EnemyCache : CCNode {
    CCSpriteBatchNode* batch;
    CCArray* enemies;
    
    int updateCount;
    int difficultModeCount;

    // ゲームモード変更時のアニメーションフラグ
    // フラグが経っている間にアニメーションが実行される
    bool cacheFlgForGameMode;
}

+(EnemyCache*) sharedEnemyCache;

-(void) initSpawnEnemies;

@property(readwrite) int updateCount;
@property(readwrite) int difficultModeCount;

@end
