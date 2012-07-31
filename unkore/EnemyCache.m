//
//  EnemyCache.m
//  unkore
//
//  Created by Daichi Nakajima on 12/07/18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "EnemyCache.h"
#import "EnemyEntity.h"
#import "GameScene.h"

@interface EnemyCache (PrivateMethods)
-(void) initEnemies;
@end


@implementation EnemyCache

+(id) cache
{
	return [[[self alloc] init] autorelease];
}

-(id) init
{
	if ((self = [super init]))
	{
		// get any image from the Texture Atlas we're using
        // テクスチャアトラスからいずれかの画像を取得する
		CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"game_safe001.png"];
        batch = [CCSpriteBatchNode batchNodeWithTexture:frame.texture];
        
        //CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage:@"monster-a.png"];
        //batch = [CCSpriteBatchNode batchNodeWithTexture:texture];
		[self addChild:batch];
		
        // 敵初期化
		[self initEnemies];
        
        // スケジュールアップデート
		[self scheduleUpdate];
	}
	
	return self;
}

-(void) initEnemies
{
	// create the enemies array containing further arrays for each type
	enemies = [[CCArray alloc] initWithCapacity:EnemyType_MAX];
	
	// create the arrays for each type
	for (int i = 0; i < EnemyType_MAX; i++)
	{
		// depending on enemy type the array capacity is set to hold the desired number of enemies
		int capacity;
		switch (i)
		{
			case EnemyTypeSafe001:
				capacity = 100;
				break;
			case EnemyTypeSafe002:
				capacity = 30;
				break;
			case EnemyTypeSafe003:
				capacity = 30;
				break;
			case EnemyTypeSafe004:
				capacity = 30;
				break;
			case EnemyTypeSafe005:
				capacity = 10;
				break;                
			case EnemyTypeSafe006:
				capacity = 10;
				break; 
			case EnemyTypeOut001:
				capacity = 30;
				break;
			case EnemyTypeOut002:
				capacity = 30;
				break;
			case EnemyTypeOut003:
				capacity = 20;
				break;
			case EnemyTypeOut004:
				capacity = 10;
				break;

			default:
				[NSException exceptionWithName:@"EnemyCache Exception" reason:@"unhandled enemy type" userInfo:nil];
				break;
		}
		
		// no alloc needed since the enemies array will retain anything added to it
		CCArray* enemiesOfType = [CCArray arrayWithCapacity:capacity];
		[enemies addObject:enemiesOfType];
	}
	
    CCLOG(@"enemy max = %d", EnemyType_MAX);
    
    // 敵のキャッシュ情報を作成する
	for (int i = 0; i < EnemyType_MAX; i++)	{
        
        // capacity分配列を作成
		CCArray* enemiesOfType = [enemies objectAtIndex:i];
		int numEnemiesOfType = [enemiesOfType capacity];
		
		for (int j = 0; j < numEnemiesOfType; j++) {
            // 敵生成
			EnemyEntity* enemy = [EnemyEntity enemyWithType:i];
            // batchに追加
			[batch addChild:enemy z:0 tag:i];
            
			[enemiesOfType addObject:enemy];
		}
	}
}

-(void) dealloc
{
	[enemies release];
	[super dealloc];
}


-(void) spawnEnemyOfType:(EnemyTypes)enemyType
{
	CCArray* enemiesOfType = [enemies objectAtIndex:enemyType];
	EnemyEntity* enemy;
    
    // 利用されていない敵を発生（表示）させる
	CCARRAY_FOREACH(enemiesOfType, enemy) {
		// find the first free enemy and respawn it
		if (enemy.visible == NO) {
			//CCLOG(@"spawn enemy type %i", enemyType);
			[enemy spawn];
			break;
		}
	}
}
/*
 -(void) checkForBulletCollisions
 {
 EnemyEntity* enemy;
 CCARRAY_FOREACH([batch children], enemy)
 {
 if (enemy.visible)
 {
 BulletCache* bulletCache = [[GameScene sharedGameScene] bulletCache];
 CGRect bbox = [enemy boundingBox];
 if ([bulletCache isPlayerBulletCollidingWithRect:bbox])
 {
 // This enemy got hit ...
 [enemy gotHit];
 }
 }
 }
 }
 */




-(void) scheduleUpdate
{
    [self schedule:@selector(generateEnemy:) interval:.1f];
}
// 敵を発生させる
-(void) generateEnemy: (id)selector
{
    // 敵の種類分操作
	updateCount++;
	for (int i = EnemyType_MAX - 1; i >= 0; i--) {
        
        // 発生頻度取得（配列に格納されている分が重みとなる）
		int spawnFrequency = [EnemyEntity getSpawnFrequencyForEnemyType:i];
        //CCLOG(@"[enemy: %d] %d no watta amari %d = %d", i, updateCount, spawnFrequency, (updateCount % spawnFrequency) );
        
        // 重みに応じて敵を発生させる（あまりが0のときに敵発生）
		if (updateCount % spawnFrequency == 0) {
            [self spawnEnemyOfType:i];
			break;
		}
	}
    
}

/*
 -(void) update:(ccTime)delta
 {
 updateCount++;
 for (int i = EnemyType_MAX - 1; i >= 0; i--) {
 int spawnFrequency = [EnemyEntity getSpawnFrequencyForEnemyType:i];
 CCLOG(@"[enemy: %d] %d no watta amari %d = %d", i, updateCount, spawnFrequency, (updateCount % spawnFrequency) );
 if (updateCount % spawnFrequency == 0) {
 [self spawnEnemyOfType:i];
 break;
 }
 }
 }
 */

@end
