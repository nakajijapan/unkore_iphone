//
//  TopMenuScene.m
//  unkore
//
//  Created by Daichi Nakajima on 12/07/16.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "TopMenuScene.h"

#import "OtohimeScene.h"
#import "CreditsScene.h"
#import "GameMenuScene.h"

@interface TopMenuScene (Private)
-(void) onManage:(id) sender;
-(void) onGame:(id) sender;
-(void) onOthohime:(id) sender;
-(void) onCredits:(id) sender;
@end

@implementation TopMenuScene

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	TopMenuScene *layer = [TopMenuScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		// ask director the the window size
		CGSize screenSize = [[CCDirector sharedDirector] winSize];

        // 背景画像
        CCSprite* uiframe = [CCSprite spriteWithFile:@"background.png"];
		uiframe.position = CGPointMake(0, screenSize.height);
		uiframe.anchorPoint = CGPointMake(0, 1);
		[self addChild:uiframe z:0];
        
        
		// タイトル
        /*
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"ウンコレ トップ" fontName:@"Marker Felt" fontSize:32];
		label.position =  ccp( screenSize.width /2 , screenSize.height - 50 );
		[self addChild: label];
         */

        /*
        // メニュー（中央）
        CCMenuItemImage* menuItemCenter = [CCMenuItemImage itemWithNormalImage:@"btn_unkore.png" 
                                                                 selectedImage:@"btn_unkore_touch.png" target:self selector:@selector(onManage:)];
        CCMenu*         menuCenter = [CCMenu menuWithItems:menuItemCenter, nil];
        menuCenter.position = ccp(screenSize.width / 2, 95);
        [self addChild:menuCenter z: 2];
         */
        
        // メニュー(左右)
        CCMenuItemImage* menu1 = [CCMenuItemImage itemWithNormalImage:@"btn_game.png" selectedImage:@"btn_game_touch.png" target:self selector:@selector(onGame:)];
        CCMenuItemImage* menu2 = [CCMenuItemImage itemWithNormalImage:@"btn_oto.png" selectedImage:@"btn_oto_touch.png" target:self selector:@selector(onOtohime:)];
        
        CCMenu*         menu = [CCMenu menuWithItems:menu1, menu2, nil];
        menu.position = ccp(screenSize.width / 2, 70);
        //[menu alignItemsHorizontallyWithPadding: screenSize.width * 1.5 / 5];
        [menu alignItemsHorizontallyWithPadding: screenSize.width / 6];
        [self addChild:menu z: 2];
        
        // 右下
        /*
        CCMenuItemImage* menuImg1 = [CCMenuItemImage itemWithNormalImage:@"Icon.png" selectedImage:nil target:self selector:@selector(onCredit:)];
        CCMenu*          menuImg = [CCMenu menuWithItems:menuImg1, nil];
        menuImg.position = ccp(screenSize.width - 50, 50);
        [self addChild:menuImg z: 2];
         */
        
        
        // 蠅
        CCSpriteFrameCache* cache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [cache addSpriteFramesWithFile:@"hae.plist"];
        
        CCSprite* sprite2 = [CCSprite spriteWithSpriteFrameName:@"hae01.png"];
		sprite2.position = ccp(screenSize.width * 0.78, screenSize.height * 0.68 );
		[self addChild:sprite2];
        
        
		NSMutableArray *moreFrames = [NSMutableArray array];
		for( int i = 1; i <= 2; i++) {
			CCSpriteFrame *frame = [cache spriteFrameByName:[NSString stringWithFormat:@"hae%02d.png",i]];
			[moreFrames addObject:frame];
		}
        
		// append frames from another batch
		CCAnimation *animMixed = [CCAnimation animationWithSpriteFrames:moreFrames delay:0.3f];
        
		// 32 frames * 1 seconds = 32 seconds
		[sprite2 runAction:[CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:animMixed]]];
        
		// to test issue #732, uncomment the following line
		//sprite2.flipX = NO;
		//sprite2.flipY = NO;

        /*
        CCSpriteFrameCache* cache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [cache addSpriteFramesWithFile:@"hae.plist"];

        CCSprite* sprite2 = [CCSprite spriteWithSpriteFrameName:@"hae01.png"];
		sprite2.position = ccp(200, 200);
		[self addChild:sprite2];
        
        
		NSMutableArray *moreFrames = [NSMutableArray array];
		for( int i = 1; i <= 2; i++) {
			CCSpriteFrame *frame = [cache spriteFrameByName:[NSString stringWithFormat:@"hae%02d.png",i]];
			[moreFrames addObject:frame];
		}
        
		// append frames from another batch
		CCAnimation *animMixed = [CCAnimation animationWithSpriteFrames:moreFrames delay:0.3f];
        
		// 32 frames * 1 seconds = 32 seconds
		[sprite2 runAction:[CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:animMixed]]];
        
		// to test issue #732, uncomment the following line
		sprite2.flipX = NO;
		sprite2.flipY = NO;
        */


	}
	return self;
}

#pragma mark -
#pragma mark メニュー押下時の処理
-(void) onManage:(id) sender
{
    // none
}
-(void) onGame:(id) sender
{
    CCTransitionSlideInR* trans = [CCTransitionFade transitionWithDuration:2 scene:[GameMenuScene scene]];
    [[CCDirector sharedDirector] replaceScene:trans];
}
-(void) onOtohime:(id) sender
{
    CCTransitionSlideInR* trans = [CCTransitionFade transitionWithDuration:2 scene:[OtohimeScene scene]];
    [[CCDirector sharedDirector] replaceScene:trans];
}
-(void) onCredit:(id) sender
{
    CCTransitionJumpZoom* trans = [CCTransitionJumpZoom transitionWithDuration:2 scene:[CreditsScene scene]];
    [[CCDirector sharedDirector] replaceScene:trans];

}
@end
