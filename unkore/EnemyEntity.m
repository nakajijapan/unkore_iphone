//
//  EnemyEntity.m
//  unkore
//
//  Created by Daichi Nakajima on 12/07/18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "EnemyEntity.h"
#import "GameScene.h"
#import "StandardMoveComponent.h"
#import "RandomMoveComponent.h"

@interface EnemyEntity (PrivateMethods)
-(void) initSpawnFrequency;
@end

@implementation EnemyEntity
@synthesize initialHitPoints, hitPoints, myScore, type;

//@synthesize emitter=emitter_;

#pragma mark -
#pragma mark 指定された敵の初期化
-(id) initWithType:(EnemyTypes)enemyType
{
	type = enemyType;

    CCLOG(@"----- enemyType : %d", type);
	
	NSString* enemyFrameName;
	initialHitPoints = 1;
	
    // 敵のステータス
	switch (type)
	{
        //-----------------------------------------------
        // OKキャラ(unko)
		case EnemyTypeSafe001:
			enemyFrameName = @"game_safe001.png";
            myScore = 100;
            initialHitPoints = 1;
			break;
		case EnemyTypeSafe002:
			enemyFrameName = @"game_safe002.png";
            myScore = 200;
			initialHitPoints = 1;
			break;
		case EnemyTypeSafe003:
			enemyFrameName = @"game_safe003.png";
            myScore = 250;
			initialHitPoints = 1;
			break;
		case EnemyTypeSafe004:
			enemyFrameName = @"game_safe004.png";
            myScore = 300;
			initialHitPoints = 1;
			break;
		case EnemyTypeSafe005:
			enemyFrameName = @"game_safe005.png";
            myScore = 500;
			initialHitPoints = 1;
			break;
		case EnemyTypeSafe006:
			enemyFrameName = @"game_safe006.png";
            myScore = 1000;
			initialHitPoints = 1;
			break;              
		case EnemyTypeSafe100:
			enemyFrameName = @"game_safe100.png";
            myScore = 5000;
			initialHitPoints = 10;
			break;  
        //-----------------------------------------------
        // はずれ
        case EnemyTypeOut001:
			enemyFrameName = @"game_out001.png";
            myScore = 0;
			initialHitPoints = 1;
			break;
        case EnemyTypeOut002:
			enemyFrameName = @"game_out002.png";
            myScore = 0;
			initialHitPoints = 1;
			break;
        case EnemyTypeOut003:
			enemyFrameName = @"game_out003.png";
            myScore = 0;
			initialHitPoints = 1;
			break;
        case EnemyTypeOut004:
			enemyFrameName = @"game_out004.png";
            myScore = 0;
			initialHitPoints = 1;
			break;

		default:
			[NSException exceptionWithName:@"EnemyEntity Exception" reason:@"unhandled enemy type" userInfo:nil];
	}
    
    
    //self = [CCSprite spriteWithFile:enemyFrameName];
    self = [super initWithSpriteFrameName:enemyFrameName];
    if (self)
	{
        // パスの動きを確定させる
        if (type == EnemyTypeSafe100) {
            [self addChild:[RandomMoveComponent node]];
        }
        // 通常の敵の動き
        else {
            [self addChild:[StandardMoveComponent node]];
        }
               
		// Create the game logic components
		//[self addChild:[StandardMoveComponent node]];
		
		// enemies start invisible
		self.visible = NO;
        
        // Manually add this class as receiver of targeted touch events.
        [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:-1 swallowsTouches:YES];
        
        CCLOG(@"親の情報ありますた！");
        
	}else {
        CCLOG(@"親の情報ありませんでせいた！");
    }
	
	return self;
}

+(id) enemyWithType:(EnemyTypes)enemyType
{
	return [[[self alloc] initWithType:enemyType] autorelease];
}


#pragma mark -
#pragma mark 発生頻度の初期化
-(void) initSpawnFrequency
{
    // spawn one enemy immediately
    [self spawn];
    CCLOG(@"%s",__FUNCTION__);
}


-(void) dealloc
{
    // Must manually unschedule, it is not done automatically for us.
	[[[CCDirector sharedDirector] scheduler] unscheduleUpdateForTarget:self];
    
	// Must manually remove this class as touch input receiver!
	[[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
	
	[super dealloc];
}

#pragma mark メモリ上に待機している敵を生成させる
-(void) spawn
{
	// Select a spawn location just outside the right side of the screen, with random y position
	CGRect screenRect = [GameScene screenRect];
	//CGSize spriteSize = [self contentSize];
    
    CCLOG(@"spawn enemy %d ", screenRect.size);
    
    // 上から出現させる
    float xPos = screenRect.size.width / 2;
    float yPos = screenRect.size.height;
    
	self.position = CGPointMake(xPos, yPos);
	
	// Finally set yourself to be visible, this also flag the enemy as "in use"
	self.visible = YES;
	
	// reset health
	hitPoints = initialHitPoints;
}

#pragma mark -
#pragma mark 衝突したら消す
-(void) gotHit
{
	hitPoints--;
	if (hitPoints <= 0)
	{
        // music start
        NSString* soundName = [NSString stringWithFormat:@"unkore_vacume%03d.mp3", (rand() % 2 + 1)];
        [[SimpleAudioEngine sharedEngine] playEffect:soundName];
        CCLOG(@"soundname = %@", soundName);
        
        // 敵の動きをクリアさせる
        [self stopAllActions];
        id moveEnd = [CCMoveTo actionWithDuration:.1f position:ccp(160, -300)];
        CCSequence* sequence = [CCSequence actions:moveEnd, nil];
        [self runAction:sequence];
        
        // 点数を更新させる
        GameScene* gameScene = [GameScene sharedGameScene];
        
        // ラベルを表示させる
        int tag = rand() % 1000 + 1000;
        CCLabelTTF* label = [CCLabelTTF labelWithString:@"バキューム！！" fontName:@"Marker Felt" fontSize: rand() % 60 + 10];
        label.position = ccp(rand() % 200 + 10, rand() % 400 + 30);
        label.anchorPoint = ccp(0.5, 0.5);
        [gameScene addChild:label z:50 tag:tag];
        
        // フェードイン・アウトアニメーション
        CCFadeTo *fadeIn = [CCFadeTo actionWithDuration:0.7 ];
        CCFadeTo *fadeOut = [CCFadeTo actionWithDuration:0.7 ];
        CCSequence *pulseSequence = [CCSequence actionOne:fadeIn two:fadeOut];
        
        [label runAction:pulseSequence];
        [label removeChildByTag:tag cleanup:YES];
        
        [gameScene updateScore:myScore];
	}
}

#pragma mark -
#pragma mark タッチしたらヒット
-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    
	CGPoint touchLocation = [GameScene locationFromTouch:touch];
	
	// Check if this touch is on the Spider's sprite.
	BOOL isTouchHandled = CGRectContainsPoint([self boundingBox], touchLocation);

    // 敵をタッチしたかどうか
	if (isTouchHandled)	{
        CCLOG(@"--------- touched unko--------");
        CCLOG(@"%@", NSStringFromCGRect([self boundingBox]));
        CCLOG(@"%@", NSStringFromCGPoint(touchLocation));
        CCLOG(@"type = %d", type);
        CCLOG(@"self.visible = %d", self.visible);
        CCLOG(@"--------- touched unko end--------");
        if (self.visible == NO) {
            return isTouchHandled;
        }
        
        // うんこ以外をタッチしたらゲームオーバ処理
        if (type >= EnemyTypeOut001) {
            [[GameScene sharedGameScene] onGameOver];
        }
        else {
            // 点数を加算する
            [self gotHit];
        }
	}
	
	return isTouchHandled;
}
@end

