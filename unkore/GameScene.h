//
//  GameScene.h
//  unkore
//
//  Created by Daichi Nakajima on 12/07/16.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

typedef enum {
    LayerTagGameLayer,
    LayerTagHipLayer
} MultiLayerSceneTags;

typedef enum
{
	GameSceneNodeTagEnemyCache = 1,
    GameSceneNodeTagLabelStart = 2,
    
} GameSceneNodeTags;

@class GameLayer;
@class HipLayer;


@interface GameScene : CCLayer {
    // スコア関係
    CCLabelTTF *_scoreLabel;
    int _nowScore;
    //CCLabelTTF *_labelComment;
    
    // game start
    CCMenuItemImage* _menuItemGameStart;
    
    // 敵の管理
    CCSpriteFrameCache* _frameCache;
    
    CCSprite* _hipLayer;
    CCSprite* _firstHelp;
}
+(id) scene;

+(GameScene*) sharedGameScene;

//@property (readonly) GameLayer* gameLayer;
//@property (readonly) HipLayer* hipLayer;

+(CGRect) screenRect;


#pragma mark タッチの制御
+(CGPoint) locationFromTouch:(UITouch*)touch;
+(CGPoint) locationFromTouches:(NSSet*)touches;


#pragma mark スコア関係
//-(void)setScore;
-(void)updateScore:(int)score;
-(void)setHighScore:(int)score;
-(int)nowScore;

#pragma mark ゲームオーバ処理
-(void)onGameOver;


@end

