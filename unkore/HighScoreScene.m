//
//  HighScoreScene.m
//  unkore
//
//  Created by Daichi Nakajima on 12/07/16.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "HighScoreScene.h"


@implementation HighScoreScene

-(id) init
{
    self = [super init];
    
    if (self) {
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        // 背景画像
        CCSprite* uiframe = [CCSprite spriteWithFile:@"hiscore_background.png"];
        uiframe.position = CGPointMake(0, screenSize.height);
        uiframe.anchorPoint = CGPointMake(0, 1);
        [self addChild:uiframe z:0];    
        
        
        // back画像
        CCMenuItemImage* menuItemHome = [CCMenuItemImage itemWithNormalImage:@"otohime_btn_back.png" selectedImage:nil target:self selector:@selector(onBack:)];
        CCMenu* menuHome = [CCMenu menuWithItems:menuItemHome, nil];
        menuHome.position       = CGPointMake(5, screenSize.height - 5);
        menuItemHome.anchorPoint    = CGPointMake(0, 1);
        [self addChild:menuHome z: 2];
        
        // highscore
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        int highScore = [defaults integerForKey:@"HIGH_SCORE"];
        
        CCLOG(@"hight score : %d", highScore);
        
        NSString* string = [NSString stringWithFormat:@"%d Kg", highScore];
        CCLabelTTF* label = [CCLabelTTF labelWithString:string fontName:@"Marker Felt" fontSize:32];
        label.color = ccc3(66, 33, 00);
        label.position = ccp(screenSize.width / 2, screenSize.height * 0.5);
        label.anchorPoint = ccp(0.5f, 0.5f);
        [self addChild:label z:10];        
    }
    
    return self;
}


+(id)scene
{
	CCScene* scene = [CCScene node];
	HighScoreScene* layer = [HighScoreScene node];
	[scene addChild:layer];
	return scene;
}

#pragma mark -
#pragma mark メニュー押下時の処理
-(void) onBack:(id)sender
{
    [SceneManager goGameMenu:@"Fade"];
}

@end
