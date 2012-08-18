//
//  EnemyCache.h
//  unkore
//
//  Created by Daichi Nakajima on 12/07/18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#define UK_INTERVAL_ENEMY_GANERATE_NORMAL    1.1f
#define UK_INTERVAL_ENEMY_GANERATE_DIFFICULT 0.7f
#define UK_CHANGE_SCORE_TO_DIFFCULT 5000

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

@property(readwrite) int updateCount;

@end
