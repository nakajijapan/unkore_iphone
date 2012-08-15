//
//  RandomMoveComponent.h
//  unkore
//
//  Created by Daichi Nakajima on 12/08/06.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Entity.h"
#import "GameScene.h"
#import "EnemyEntity.h"

@interface RandomMoveComponent : CCSprite 
{
    CGPoint velocity;
    bool isMoving;
    
    int moveType;
}
@end
