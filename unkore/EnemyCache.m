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

// property
@synthesize updateCount;


// 敵発生用配列
static int      totalSpawnSize;
static CCArray* spawnFrequency;
static CCArray* spawnFrequencyInfo;


static EnemyCache* instanceOfEnemyCache;


#pragma mark - 
#pragma mark shared

+(EnemyCache*) sharedEnemyCache
{
	NSAssert(instanceOfEnemyCache != nil, @"GameScene instance not yet initialized!");
	return instanceOfEnemyCache;
}


+(id) cache
{
	return [[[self alloc] init] autorelease];
}




#pragma mark - 
#pragma mark init Enemy
-(id) init
{
	if ((self = [super init]))
	{
        // シングルトン
        instanceOfEnemyCache = self;
       
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
		[self scheduleUpdates];
        
        // ゲームモード移行時の処理フラグ
        cacheFlgForGameMode = NO;
        
	}
	
	return self;
}

-(void) initEnemies
{
	// create the enemies array containing further arrays for each type
	enemies = [[CCArray alloc] initWithCapacity:EnemyType_MAX];
	
    totalSpawnSize = 0;
    spawnFrequency = [[CCArray alloc] initWithCapacity:EnemyType_MAX];
    
	// create the arrays for each type
	for (int i = 0; i < EnemyType_MAX; i++)
	{
		// depending on enemy type the array capacity is set to hold the desired number of enemies
		int capacity;
        int fruquency;
		switch (i)
		{
			case EnemyTypeSafe001:
				capacity    = 10;
                fruquency   = 150;
				break;
			case EnemyTypeSafe002:
				capacity    = 10;
                fruquency   = 100;
				break;
			case EnemyTypeSafe003:
				capacity    = 10;
                fruquency   = 90;
				break;
			case EnemyTypeSafe004:
				capacity    = 10;
                fruquency   = 80;
				break;
			case EnemyTypeSafe005:
				capacity    = 10;
                fruquency   = 80;
				break;                
			case EnemyTypeSafe006:
				capacity    = 10;
                fruquency   = 70;
				break; 
			case EnemyTypeSafe100:
				capacity    = 10;
                fruquency   = 40;
				break;
			case EnemyTypeOut001:
				capacity    = 10;
                fruquency   = 70;
				break;
			case EnemyTypeOut002:
				capacity    = 10;
                fruquency   = 70;
				break;
			case EnemyTypeOut003:
				capacity    = 10;
                fruquency   = 70;
				break;
			case EnemyTypeOut004:
				capacity    = 10;
                fruquency   = 70;
				break;
			default:
				[NSException exceptionWithName:@"EnemyCache Exception" reason:@"unhandled enemy type" userInfo:nil];
				break;
		}
		
        // 敵毎の重みを設定（低いものほど発生しやすい）
        [spawnFrequency insertObject:[NSNumber numberWithInt:fruquency] atIndex: i];
        totalSpawnSize += fruquency;
        
		// no alloc needed since the enemies array will retain anything added to it
		CCArray* enemiesOfType = [CCArray arrayWithCapacity:capacity];
		[enemies addObject:enemiesOfType];
	}
    
    // 重み情報初期化
    //[spawnFrequencyInfo initWithCapacity:totalSpawnSize];
    spawnFrequencyInfo = [[CCArray alloc] initWithCapacity:totalSpawnSize];
    for (int i = 0; i < EnemyType_MAX; i++) {
        int enemyCount = [[spawnFrequency objectAtIndex:i] intValue];
        CCLOG(@"enemy %d : %d", i, enemyCount);
        for (int j = 0; j < enemyCount; j++) {
            [spawnFrequencyInfo addObject:[NSNumber numberWithInt:i]];
        }
    }
    
	CCLOG(@"enemyCacheSzie %d", totalSpawnSize);
    CCLOG(@"enemy max = %d", EnemyType_MAX);
    
    // 敵のキャッシュ情報を作成する
	for (int i = 0; i < EnemyType_MAX; i++)	{
        
        // capacity分配列を作成
		CCArray* enemiesOfType = [enemies objectAtIndex:i];
		int numEnemiesOfType = [enemiesOfType capacity];
		
		for (int j = 0; j < numEnemiesOfType; j++) {

            // 敵生成
            CCLOG(@"%s : enemyentity enemywithtype %d", __FUNCTION__, i);
			EnemyEntity* enemy = [EnemyEntity enemyWithType:i];

            // batchに追加
			[batch addChild:enemy z:0 tag:i];
            
			[enemiesOfType addObject:enemy];
		}
	}
}

#pragma mark -
#pragma mark スケジューラ関連

// スケジューラ更新
-(void) scheduleUpdates
{
    [self schedule:@selector(generateEnemy:) interval:UK_INTERVAL_ENEMY_GANERATE_NORMAL];
}


// 敵を発生させる（敵の種類も確定させる）
-(void) generateEnemy: (id)selector
{
    CCLOG(@"---- %s", __FUNCTION__);
    CCLOG(@"updatecount = %d", updateCount);
    CCLOG(@"difficultModeCount = %d", difficultModeCount);
    int maxSize = spawnFrequencyInfo.count;
    int enemyTypeOffset = (int)(CCRANDOM_0_1() * maxSize) % maxSize ;
    //CCLOG(@"show rand -----------------%d -> enemy = %d", enemyTypeOffset, [[spawnFrequencyInfo objectAtIndex:enemyTypeOffset] intValue]);
    
    // 重みに応じて敵を発生させる（あまりが0のときに敵発生）
    updateCount++;
    
    //--------------------------------------------------------
    // 激ムズモード(スコアで決定)
    //--------------------------------------------------------
    if ( ([[GameScene sharedGameScene] nowScore] >= UK_CHANGE_SCORE_TO_DIFFCULT && difficultModeCount < 1) || cacheFlgForGameMode == YES) {
        difficultModeCount++;
        
        // 使用中にする
        cacheFlgForGameMode = YES;
        
        // アニメーション処理
        if (1 <= difficultModeCount && difficultModeCount <= 7) {
            if (difficultModeCount == 1) {
                CCParticleSystem* system = [CCParticleFireworks node];// げり
                CGSize winSize = [[CCDirector sharedDirector] winSize];
                system.position = CGPointMake(winSize.width / 2, (winSize.height * 3 / 4) + 10 );
                system.texture = [[CCTextureCache sharedTextureCache] addImage: @"game_safe001.png"];
                system.duration = 2; // for 2 seccond
                // rotate
                id rotate = [CCRotateTo actionWithDuration:.0f angle:180];
                [system runAction:rotate];
                [[GameScene sharedGameScene] addChild:system z:100 tag:100];
                
                // sound
                [[SimpleAudioEngine sharedEngine] preloadEffect:@"unkore_gememode_difficult001.mp3"];
                [[SimpleAudioEngine sharedEngine] playEffect:@"unkore_gememode_difficult001.mp3"];
            }
            else if (difficultModeCount == 7) {
                // 発生サイクルを短くする
                [[GameScene sharedGameScene] removeChildByTag:100 cleanup:YES];
                
                // スケジューラ登録し直し
                [self unschedule:_cmd];
                [self schedule:_cmd interval:UK_INTERVAL_ENEMY_GANERATE_DIFFICULT];
                
                // 終了
                cacheFlgForGameMode = NO;
                difficultModeCount = 100;
            }
        }
    }
    //--------------------------------------------------------
    // 通常（敵を発生させる）
    //--------------------------------------------------------    
    else {
        [self spawnEnemyOfType: [[spawnFrequencyInfo objectAtIndex:enemyTypeOffset] intValue]];
    }
    
    /*
//TODO:Particleを自家製で作成しなければいけないかも
    // 激ムズモード(時間で決定)
    if (5 <= updateCount && updateCount <= 15) {
        if (updateCount == 5) {
        }
        else if (updateCount == 15) {
        }
    }
    else {
        [self spawnEnemyOfType: [[spawnFrequencyInfo objectAtIndex:enemyTypeOffset] intValue]];
    }
    */

}

-(void) spawnEnemyOfType:(EnemyTypes)enemyType
{
    CCLOG(@"---- %s", __FUNCTION__);
    
	CCArray* enemiesOfType = [enemies objectAtIndex:enemyType];
	EnemyEntity* enemy;
    
    // 利用されていない敵を発生（表示）させる
	CCARRAY_FOREACH(enemiesOfType, enemy) {
        
        //CCLOG(@"enemiesOfType = %d", enemiesOfType);
        
		// find the first free enemy and respawn it
		if (enemy.visible == NO) {
			[enemy spawn];
            
            //CCLOG(@"enemiesOfType = %s", __FUNCTION__);
			break;
		}
	}
}

#pragma mark -
#pragma mark lifecycle
-(void) initSpawnEnemies
{
    CCLOG(@"---- %s", __FUNCTION__);
    CCLOG(@"敵を初期位置へ戻します");
    EnemyEntity* enemy;
    CCArray* enemiesOfType;
    CCARRAY_FOREACH(enemies, enemiesOfType) {
        CCARRAY_FOREACH(enemiesOfType, enemy) {
            [enemy spawn];
        }
    }

}

-(void) dealloc
{
    // 敵を初期位置に戻す
    //[[EnemyCache sharedEnemyCache] initSpawnEnemies];
    [self initSpawnEnemies];
    
	[enemies release];
	[super dealloc];
}

@end
