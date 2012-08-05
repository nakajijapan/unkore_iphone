//
//  EnemyEntity.h
//  unkore
//
//  Created by Daichi Nakajima on 12/07/18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity.h"
#import "SimpleAudioEngine.h"

typedef enum
{
	EnemyTypeSafe001 = 0,
	EnemyTypeSafe002,
	EnemyTypeSafe003,
    EnemyTypeSafe004,
    EnemyTypeSafe005,
    EnemyTypeSafe006,
    
    EnemyTypeOut001,
    EnemyTypeOut002,
    EnemyTypeOut003,
    EnemyTypeOut004,
	
	EnemyType_MAX,
} EnemyTypes;

@interface EnemyEntity : Entity <CCTargetedTouchDelegate>{
    int initialHitPoints;
	int hitPoints;
    int myScore;
    
    EnemyTypes type;
}
@property (readonly, nonatomic) int initialHitPoints;
@property (readonly, nonatomic) int hitPoints;
@property (readonly, nonatomic) int myScore;
@property (readonly, nonatomic) EnemyTypes type;

+(id) enemyWithType:(EnemyTypes)enemyType;

//+(int) getSpawnFrequencyForEnemyType:(EnemyTypes)enemyType;

-(void) spawn;

-(void) gotHit;

@end
