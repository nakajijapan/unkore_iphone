//
//  SceneManager.m
//  cocos2d-menu
//
//  Created by Daichi Nakajima on 12/07/03.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "SceneManager.h"
#define TRANSITION_DURATION (0.6f)

@interface SceneManager(PrivateMethods)
+(void) go:(CCLayer*) layer;
+(void) go:(CCLayer*) layer trasition:(NSString*)transName;

+(CCScene*) wrap: (CCLayer*) layer;
@end

@implementation SceneManager

+(void) goTopMenu
{
    CCLayer* layer = [TopMenuScene node];
    [SceneManager go:layer];
}
+(void) goTopMenu:(NSString*)transName
{
    CCLayer* layer = [TopMenuScene node];
    [SceneManager go:layer trasition:transName];
}

+(void) goGameMenu
{
    CCLayer* layer = [GameMenuScene node];
    [SceneManager go:layer];
}
+(void) goGameMenu:(NSString*)transName
{
    CCLayer* layer = [GameMenuScene node];
    [SceneManager go:layer trasition:transName];
}

+(void) goGameStart:(NSString*)transName
{
    CCLayer* layer = [GameScene node];
    [SceneManager go:layer trasition:transName];
}
+(void) goOtohimeMenu:(NSString*)transName
{
    CCLayer* layer = [OtohimeScene node];
    [SceneManager go:layer trasition:transName];
}

#pragma mark -
#pragma mark PrivateMethods
+(void) go:(CCLayer *)layer
{
    CCDirector *director = [CCDirector sharedDirector];
    CCScene* newScene = [SceneManager wrap:layer];
    if ([director runningScene]) {
        [director replaceScene: newScene];
    }
    else {
        [director runWithScene: newScene];
    }
}

+(void) go:(CCLayer *)layer trasition:(NSString*)transName
{
	CCDirector *director = [CCDirector sharedDirector];
	CCScene *newScene = [SceneManager wrap:layer];
	id trans;
	if ([director runningScene]) {
        if (transName == @"Fade") {
            trans = [CCTransitionFade transitionWithDuration:TRANSITION_DURATION scene:newScene];
        }
        else if (transName == @"JumpZoom") {
            trans = [CCTransitionJumpZoom transitionWithDuration:TRANSITION_DURATION scene:newScene];
        }
        else if (transName == @"RotoZoom") {
            trans = [CCTransitionRotoZoom transitionWithDuration:TRANSITION_DURATION scene:newScene];
        }
        else if (transName == @"SlideL") {
            trans = [CCTransitionSlideInL transitionWithDuration:TRANSITION_DURATION scene:newScene];
        }
        else {
            trans = newScene;
        }

        // 現在のシーンを削除して新しいシーンを表示
        [director replaceScene:trans];
	}else {
        // プログラム起動時
		[director runWithScene:newScene];		
	}
}

+(CCScene*) wrap: (CCLayer *) layer
{
    CCScene *newScene = [CCScene node];
    [newScene addChild: layer];
    return newScene;
}


@end
