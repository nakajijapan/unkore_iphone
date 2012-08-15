//
//  GameMenuScene.h
//  unkore
//
//  Created by Daichi Nakajima on 12/07/16.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "SimpleAudioEngine.h"
#import "SceneManager.h"
#import "GameScene.h"
#import "HighScoreScene.h"

// GK
#import <GameKit/GameKit.h>
// Needed to obtain the Navigation Controller
#import "AppDelegate.h"


@interface GameMenuScene : CCLayer <GKLeaderboardViewControllerDelegate> 
{
    
}
+(id) scene;


@end
