//
//  GameScene.m
//  unkore
//
//  Created by Daichi Nakajima on 12/07/16.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"

// layer
#import "HipLayer.h"
#import "GameLayer.h"

// enamy
#import "EnemyCache.h"

// scene
#import "GameOverScene.h"


@implementation GameScene

static GameScene* instanceOfGameScene;

static CGRect screenRect;


+(GameScene*) sharedGameScene
{
	NSAssert(instanceOfGameScene != nil, @"GameScene instance not yet initialized!");
	return instanceOfGameScene;
}

+(CGRect) screenRect
{
	return screenRect;
}

+(id) scene
{
	CCScene* scene = [CCScene node];
	GameScene* layer = [GameScene node];
	[scene addChild:layer];
	return scene;
}

-(id) init
{
	if ((self = [super init]))
	{
		NSAssert(instanceOfGameScene == nil, @"another MultiLayerScene is already in use!");
		instanceOfGameScene = self;
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
		
        //----------------------------------------
        // 背景画像
		GameLayer* gameLayer = [GameLayer node];
		[self addChild:gameLayer z:10 tag:LayerTagGameLayer];
		
        //----------------------------------------
        // お尻画像
        /*
		_hipLayer = [HipLayer node];
		[self addChild:_hipLayer z:30 tag:LayerTagHipLayer];
         */
		_hipLayer = [CCSprite spriteWithFile:@"game_hip001.png"];
		_hipLayer.position = CGPointMake(0, screenSize.height + 250);
		_hipLayer.anchorPoint = CGPointMake(0, 1);
		[self addChild:_hipLayer z:20 tag:UILayerTagFrameSprite];        
        
        // お尻を左右に振らせる
        CCMoveBy* hipMove1 = [CCMoveBy actionWithDuration:.1f  position: ccp(5,0)];
        CCMoveBy* hipMove2 = [CCMoveBy actionWithDuration:.1f  position: ccp(-5,0)];
        CCMoveBy* hipMove3 = [CCMoveBy actionWithDuration:.1f  position: ccp(-5,0)];
        CCMoveBy* hipMove4 = [CCMoveBy actionWithDuration:.1f  position: ccp(5,0)];
        CCDelayTime* hipDelay = [CCDelayTime actionWithDuration:5.0f];
        CCSequence* hipSequence = [CCSequence actions:hipMove1, hipMove2, hipMove3, hipMove4, hipMove1, hipMove2, hipMove3, hipMove4, hipDelay, nil];
        CCRepeatForever *hipRepeat = [CCRepeatForever actionWithAction: hipSequence];
        [_hipLayer runAction:hipRepeat];
        
        //----------------------------------------
        // 枠画像
        CCSprite* sideframe = [CCSprite spriteWithFile:@"game_waku.png"];
        sideframe.position = CGPointMake(0, screenSize.height);
        sideframe.anchorPoint = CGPointMake(0, 1);
        [self addChild:sideframe z:31];
        
        //----------------------------------------
        // スコアラベル
        _scoreLabel = [CCLabelTTF labelWithString:@"0 Kg" fontName:@"Marker Felt" fontSize:48];
        _scoreLabel.position = CGPointMake(screenSize.width - 30, screenSize.height - 30);
        _scoreLabel.anchorPoint = CGPointMake(1, 1); // 左下上に設定
        [self addChild:_scoreLabel z:35];
        
        // taouch enable
        self.isTouchEnabled = YES;
        
        // rect
        screenRect = CGRectMake(0, 0, screenSize.width, screenSize.height);
        
        //----------------------------------------
        // Load all of the game's artwork up front.
        /*
        screenRect = CGRectMake(0, 0, screenSize.width, screenSize.height);
		CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
		[frameCache addSpriteFramesWithFile:@"game-art.plist"];
        EnemyCache* enemyCache = [EnemyCache node];
		[self addChild:enemyCache z:20 tag:GameSceneNodeTagEnemyCache];
        */

        //--------------------
        //_labelComment = [CCLabelTTF labelWithString:@"ボキューム！！" fontName:@"Marker Felt" fontSize: 32];
        //[self addChild:_labelComment z:7];
        
        //----------------------------------------
        // 車表示
        CCSprite* carFrame = [CCSprite spriteWithFile:@"game_car.png"];
        //carFrame.position = CGPointMake(25, 15);
        carFrame.position = CGPointMake(screenSize.width, 15);
        carFrame.anchorPoint = CGPointMake(0, 0);
        [self addChild:carFrame z:20];
        
        id delay = [CCDelayTime actionWithDuration:4.0f];
        id action = [CCMoveTo actionWithDuration:0.5 position:ccp(25,15)];
        id ease = [CCEaseIn actionWithAction:action rate:0.3];
        //id ease = [CCEaseElasticIn actionWithAction:action period:0.3f];
        id actions = [CCSequence actions:delay, ease, nil];
        
        // call back method
        id actionCallback  = [CCCallFunc actionWithTarget:self selector:@selector(onStartGameStep1)];
        //[carFrame runAction: actions];
        [carFrame runAction:[CCSequence actionOne:actions two:actionCallback]];
        
        //----------------------------------------
        // ゲームスタートボタン
        /*
        _menuItemGameStart = [CCMenuItemImage itemWithNormalImage:@"game_ikuyo.png" selectedImage:nil target:self selector:@selector(onGameStart:)];
        //_menuItemGameStart = [CCMenuItemFont itemWithString:@"ゲームスタート！" target:self selector:@selector(onGameStart:)];
        CCMenu* menuStart = [CCMenu menuWithItems:_menuItemGameStart, nil];
        menuStart.position = ccp( screenSize.width/2, screenSize.height/2);
        //[menu alignItemsVertically]; 
        _menuItemGameStart.visible = NO;
        [self addChild:menuStart z:40 tag:GameSceneNodeTagLabelStart];
         */
        
        
        //----------------------------------------
        // サウンドのプレリロード
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"unkore_vacume001.mp3"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"unkore_vacume002.mp3"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"unkore_gameover.mp3"];
        [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"unkore_background.mp3"];
        
        //----------------------------------------
        // 現在のスコアを初期化
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue:0 forKey:@"NOW_SCORE"];
	}
	
	return self;
}

#pragma mark -
#pragma mark ゲーム開始前処理
-(void) onStartGameStep1
{
    //[_hipLayer show];
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCLOG(@"HipLayer show  : %f", screenSize.height);
    
    id action1 = [CCMoveBy actionWithDuration:2.0f  position: ccp(0, -250)];
    id action2 = [CCEaseElasticOut actionWithAction:action1 period:0.35f];
    //[_hipLayer runAction:action2];
    // call back method
    //id delay = [CCDelayTime actionWithDuration:2.0f];
    id actionCallback  = [CCCallFunc actionWithTarget:self selector:@selector(onGameStart:)];
    [_hipLayer runAction:[CCSequence actionOne:action2 two:actionCallback]];
    
}
    

#pragma mark -
#pragma mark ゲーム開始処理
-(void) onGameStart:(id)sender
{
    CCLOG(@"onGameStart");
    
    // music start
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"unkore_background.mp3"];
    
    
    // animation
    /*
    _menuItemGameStart.visible = YES;
    id action1 = [CCScaleBy actionWithDuration:.5 scale:2.0];
    id action2 = [CCFadeOut actionWithDuration:.5];
    //id action3 = [CCRotateBy actionWithDuration:.5  angle: 2160];
    //id actions = [CCSpawn actions:action1, action2, action3, nil];
    id actions_after = [CCSpawn actions:action1, action2, nil];
    id action_back = [CCFadeIn actionWithDuration:0.5];
    id actions = [CCSequence actions:action_back, actions_after, nil];

    // call back method
    id actionCallback  = [CCCallFunc actionWithTarget:self selector:@selector(onStartredGame)];
    */
    
    //--------------------
    // アートワークに保存してある情報を画面にロードする
    _frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    [_frameCache addSpriteFramesWithFile:@"game-art.plist"];
    EnemyCache* enemyCache = [EnemyCache node];
    [self addChild:enemyCache z:19 tag:GameSceneNodeTagEnemyCache];
    
    
    //[_menuItemGameStart runAction:action];
    //[_menuItemGameStart runAction:[CCSequence actionOne:actions two:actionCallback]];
    
    
}
-(void) onStartredGame
{
    // ラベル削除
    [self removeChildByTag:GameSceneNodeTagLabelStart cleanup:YES];
}

#pragma mark -
#pragma mark ゲームオーバー処理
-(void) onGameOver
{
    CCLOG(@"onGameOver : high score");
    

    // 音楽を止める
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    
    // サウンドを再生
    [[SimpleAudioEngine sharedEngine] playEffect:@"unkore_game_over.mp3"];
    
    // ハイスコア保存
    [self setHighScore:_nowScore];
    
    // 画面遷移
    CCTransitionTurnOffTiles* trans = [CCTransitionTurnOffTiles transitionWithDuration:1 scene:[GameOverScene scene]];
    [[CCDirector sharedDirector] replaceScene:trans];
}

#pragma mark タッチの制御
+(CGPoint) locationFromTouch:(UITouch*)touch
{
	CGPoint touchLocation = [touch locationInView: [touch view]];
	return [[CCDirector sharedDirector] convertToGL:touchLocation];
}

+(CGPoint) locationFromTouches:(NSSet*)touches
{
	return [self locationFromTouch:[touches anyObject]];
}

#pragma mark - 
#pragma mark スコア関連

// ゲーム中にスコアを更新するごとに呼び出される
-(void)updateScore:(int)score {
    
    CCLOG(@"now score %d : score %d",_nowScore, score);
    
    _nowScore += score;
    [_scoreLabel setString:[NSString stringWithFormat:@"%d Kg",_nowScore]];
}

// ゲ-ムが終わったときにハイスコアを保存する。
-(void)setHighScore:(int)score
{
    CCLOG(@"%s", __FUNCTION__);

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    int highScore = [defaults integerForKey:@"HIGH_SCORE"];
    
    CCLOG(@"hight : now = %d : %d", highScore, _nowScore);
    
    // 現在のスコアを保存
    [defaults setInteger:_nowScore forKey:@"NOW_SCORE"];
    
    // ハイスコア
    if (highScore < _nowScore) {
        
        [defaults setInteger:_nowScore forKey:@"HIGH_SCORE"];
        [defaults synchronize];
        
        CCLOG(@"high score now!!!!!!!!!!!! > %d", [defaults integerForKey:@"HIGH_SCORE"]);
    }
    
    // メッソドのscoreは後で、GameCenterにスコアを送るように使います。間違いではありません。
}

#pragma mark -
#pragma mark lifecycle
-(void) dealloc
{
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
	
	// The Layer will be gone now, to avoid crashes on further access it needs to be nil.
	instanceOfGameScene = nil;
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
