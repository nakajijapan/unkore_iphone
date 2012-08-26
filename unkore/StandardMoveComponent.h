//
//  StandardMoveComponent.h
//  unkore
//
//  Created by Daichi Nakajima on 12/07/18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "Entity.h"
#import "GameScene.h"
#import "EnemyEntity.h"
#import "EnemyCache.h"

// Why is it derived from CCSprite? Because enemies use a SpriteBatch, and CCSpriteBatchNode requires that all
// child nodes added to it are CCSprite. Under other circumstances I would use a CCNode as parent class of course, since
// the components won't have a texture and everything else that a Sprite has.
@interface StandardMoveComponent : CCSprite 
{
	CGPoint velocity;
    bool isMoving;
}

@end