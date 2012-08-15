//
//  EnemyCache.h
//  unkore
//
//  Created by Daichi Nakajima on 12/07/18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface EnemyCache : CCNode {
    CCSpriteBatchNode* batch;
    CCArray* enemies;
    
    int updateCount;
}

+(EnemyCache*) sharedEnemyCache;

@property(readwrite) int updateCount;

@end
