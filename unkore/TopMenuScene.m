//
//  TopMenuScene.m
//  unkore
//
//  Created by Daichi Nakajima on 12/07/16.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "TopMenuScene.h"

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
		uiframe.position    = ccp(0, screenSize.height);
		uiframe.anchorPoint = ccp(0, 1);
		[self addChild:uiframe z:0];
        
        
        // メニュー(左右)
        CCMenuItemImage* menu1 = [CCMenuItemImage itemWithNormalImage:@"btn_game.png" selectedImage:@"btn_game_touch.png" target:self selector:@selector(onGame:)];
        CCMenuItemImage* menu2 = [CCMenuItemImage itemWithNormalImage:@"btn_oto.png" selectedImage:@"btn_oto_touch.png" target:self selector:@selector(onOtohime:)];
        
        CCMenu*         menu = [CCMenu menuWithItems:menu1, menu2, nil];
        menu.anchorPoint = CGPointMake(0.0, 1.0);
        if (screenSize.height == 568) {
            menu.position    = ccp(screenSize.width / 2, screenSize.height * 0.30 );
        }
        else {
            menu.position    = ccp(screenSize.width / 2, screenSize.height * 0.17 );
        }
        [menu alignItemsHorizontallyWithPadding: 25];
        [self addChild:menu z: 2];
        
       
        // 蠅
        CCSpriteFrameCache* cache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [cache addSpriteFramesWithFile:@"hae.plist"];
        
        CCSprite* sprite2 = [CCSprite spriteWithSpriteFrameName:@"hae01.png"];
        sprite2.anchorPoint = ccp(0, 1);
        sprite2.ignoreAnchorPointForPosition = NO;
        if (screenSize.height == 568) {
            sprite2.position = ccp(screenSize.width * 0.80, screenSize.height * 0.74 );
        }
        else {
            sprite2.position = ccp(screenSize.width * 0.87, screenSize.height * 0.68 );
        }

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
    CCTransitionSlideInR* trans = [CCTransitionFade transitionWithDuration:TRANSITION_DURATION scene:[GameMenuScene scene]];
    [[CCDirector sharedDirector] replaceScene:trans];
}
-(void) onOtohime:(id) sender
{
    CCTransitionSlideInR* trans = [CCTransitionFade transitionWithDuration:TRANSITION_DURATION scene:[OtohimeScene scene]];
    [[CCDirector sharedDirector] replaceScene:trans];
}
-(void) onCredit:(id) sender
{
    CCTransitionJumpZoom* trans = [CCTransitionJumpZoom transitionWithDuration:TRANSITION_DURATION scene:[CreditsScene scene]];
    [[CCDirector sharedDirector] replaceScene:trans];

}
@end
