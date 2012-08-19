//
//  GameMenuScene.m
//  unkore
//
//  Created by Daichi Nakajima on 12/07/16.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameMenuScene.h"

@implementation GameMenuScene

-(id) init {
    self = [super init];
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    // 背景画像
    CCSprite* uiframe = [CCSprite spriteWithFile:@"game_top_background.png"];
    uiframe.position = CGPointMake(0, screenSize.height);
    uiframe.anchorPoint = CGPointMake(0, 1);
    [self addChild:uiframe z:0];
    
    // ホーム画像
    CCMenuItemImage* menuItemHome = [CCMenuItemImage itemWithNormalImage:@"game_top_btn_home.png" selectedImage:nil target:self selector:@selector(onBack:)];
    CCMenu* menuHome = [CCMenu menuWithItems:menuItemHome, nil];
    menuHome.position       = CGPointMake(5, screenSize.height - 5);
    menuItemHome.anchorPoint    = CGPointMake(0, 1);
    [self addChild:menuHome z: 2];
    
    
    // ヘルプ画像 & GameCenter
    CCMenuItemImage* menuItemHelp = [CCMenuItemImage itemWithNormalImage:@"game_top_btn_how.png" selectedImage:nil target:self selector:@selector(onHelp:)];
    CCMenuItemImage* menuItemGameCenter = [CCMenuItemImage itemWithNormalImage:@"game_center.png" selectedImage:nil target:self selector:@selector(onGameCenter:)];
    CCMenu* menuHelp = [CCMenu menuWithItems:menuItemGameCenter, menuItemHelp, nil];
    menuHelp.position = CGPointMake(screenSize.width - 30, screenSize.height - 5);
    menuHelp.anchorPoint = ccp(1, 1);
    menuItemHelp.anchorPoint = CGPointMake(1, 1);
    menuItemGameCenter.anchorPoint = CGPointMake(1, 1);
    [menuHelp alignItemsHorizontallyWithPadding:5.0f];
    [self addChild:menuHelp z: 2];
    
    
    // メニュー
    CCMenuItemImage* menuMain1 = [CCMenuItemImage itemWithNormalImage:@"game_top_btn_play.png" selectedImage:nil target:self selector:@selector(onNewGame:)];
    CCMenuItemImage* menuMain2 = [CCMenuItemImage itemWithNormalImage:@"game_top_btn_hiscore.png" selectedImage:nil target:self selector:@selector(onHighScore:)];
    CCMenu *menu = [CCMenu menuWithItems:menuMain1, menuMain2, nil];
    menu.position = ccp(screenSize.width / 2, 90);
    [menu alignItemsVerticallyWithPadding:10.0f];
    [self addChild:menu z: 2];
    
    // back
    /*
    CCMenuItemFont *labelBack = [CCMenuItemFont itemWithString:@"back" target:self selector: @selector(onBack:)];
    CCMenu *menuBack = [CCMenu menuWithItems:labelBack, nil];
    menuBack.position = ccp(screenSize.width - labelBack.contentSize.width / 2, 20);
    [self addChild:menuBack];
     */
    
    // Musicのプレリロード
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"unkore_game_start.mp3"];
    
    return self;
    
}

+(id) scene
{
	CCScene* scene = [CCScene node];
	GameMenuScene* layer = [GameMenuScene node];
	[scene addChild:layer];
	return scene;
}

#pragma mark -
#pragma mark メニュー押下時の処理
-(void) onNewGame:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"unkore_game_start.mp3"];
    CCTransitionSplitRows* trans = [CCTransitionSplitRows transitionWithDuration:2 scene:[GameScene scene]];
    [[CCDirector sharedDirector] replaceScene:trans];
    
}
-(void) onHighScore:(id)sender
{
    CCTransitionSlideInR* trans = [CCTransitionFade transitionWithDuration:TRANSITION_DURATION scene:[HighScoreScene scene]];
    [[CCDirector sharedDirector] replaceScene:trans];
}
-(void) onBack:(id)sender
{
    [SceneManager goTopMenu:@"Fade"];
}
-(void) onHelp:(id)sender
{
    CCTransitionSlideInR* trans = [CCTransitionFade transitionWithDuration:TRANSITION_DURATION scene:[GameHelpScene scene]];
    [[CCDirector sharedDirector] replaceScene:trans];
}
// LeaderBoad
-(void) onGameCenter:(id)sender
{
    GKLeaderboardViewController *leaderboardViewController = [[GKLeaderboardViewController alloc] init];
    leaderboardViewController.leaderboardDelegate = self;
    
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    [[app navController] presentModalViewController:leaderboardViewController animated:YES];
    [leaderboardViewController release];
}

#pragma mark GameKit delegate
-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

@end
