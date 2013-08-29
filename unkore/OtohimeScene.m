//
//  OtohimeScene.m
//  unkore
//
//  Created by Daichi Nakajima on 12/07/16.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "OtohimeScene.h"

@interface OtohimeScene (PrivateMethod)

@end


@implementation OtohimeScene {
    __strong CCMenuItemImage* menuImg2;
}

-(id) init
{
    self = [super init];
    if (self) {
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        // 背景画像
        CCSprite* uiframe = [CCSprite spriteWithFile:@"otohime_top_background.png"];
        uiframe.position = CGPointMake(0, screenSize.height);
        uiframe.anchorPoint = CGPointMake(0, 1);
        [self addChild:uiframe z:0];
        
        // メニュー
        CCMenuItemImage* menuMain1 = [CCMenuItemImage itemWithNormalImage:@"otohime_top_btn001.png" selectedImage:nil target:self selector:@selector(onPlayer1:)];
        CCMenuItemImage* menuMain2 = [CCMenuItemImage itemWithNormalImage:@"otohime_top_btn002.png" selectedImage:nil target:self selector:@selector(onPlayer2:)];
        CCMenuItemImage* menuMain3 = [CCMenuItemImage itemWithNormalImage:@"otohime_top_btn003.png" selectedImage:nil target:self selector:@selector(onPlayer3:)];
        CCMenu *menu = [CCMenu menuWithItems:menuMain1, menuMain2, menuMain3, nil];
        
        [menu alignItemsVerticallyWithPadding: 10.0f];

        // for iPhone5
        if (screenSize.height == 568) {
            menu.position = ccp(screenSize.width / 2  , screenSize.height * 0.3 + 70);
        }
        else {
            menu.position = ccp(screenSize.width / 2  , screenSize.height * 0.3 + 20);
        }

        [self addChild:menu z: 2];
        
        
        /*
        // 中央
        CCMenuItemImage* menuSoundStart = [CCMenuItemImage itemWithNormalImage:@"Icon.png" selectedImage:nil];
        //CCMenuItemImage* menuSoundStop = [CCMenuItemImage itemWithNormalImage:@"Icon@2x.png" selectedImage:nil];
        //CCMenuItemFont* menuSoundStart = [CCMenuItemFont itemWithString:@"hogehoge00000"];
        CCMenuItemFont* menuSoundStop = [CCMenuItemFont itemWithString:@"音姫を止める"];
        
        CCMenuItemToggle* menuToggle = [CCMenuItemToggle itemWithTarget:self 
                                                               selector:@selector(onSoundCallback:) 
                                                                  items:menuSoundStart, menuSoundStop, nil];
        CCMenu* menuMain = [CCMenu menuWithItems:menuToggle, nil];
        menuMain.position = ccp(screenSize.width / 2, screenSize.height / 2);
        [self addChild:menuMain z: 2];
         */

        // ホーム画像
        CCMenuItemImage* menuItemHome = [CCMenuItemImage itemWithNormalImage:@"game_top_btn_home.png" selectedImage:nil target:self selector:@selector(onBack:)];
        CCMenu* menuHome = [CCMenu menuWithItems:menuItemHome, nil];
        menuHome.position           = CGPointMake(5, screenSize.height - 5);
        menuItemHome.anchorPoint    = CGPointMake(0, 1);
        [self addChild:menuHome z: 2];
        
        // Musicのプレリロード
        //[[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"unkore_otohime001.mp3"];
        
    }
    return self;
}
+(id)scene
{
	CCScene* scene = [CCScene node];
	OtohimeScene* layer = [OtohimeScene node];
	[scene addChild:layer];
	return scene;
}

#pragma mark -
#pragma mark メニュー押下時の処理
-(void) onPlayer1:(id)sender
{
    CCTransitionSlideInR* trans = [CCTransitionSlideInR transitionWithDuration:1 scene:[OtohimePlayerScene1 scene]];
    [[CCDirector sharedDirector] replaceScene:trans];
}
-(void) onPlayer2:(id)sender
{
    CCTransitionSlideInR* trans = [CCTransitionSlideInR transitionWithDuration:1 scene:[OtohimePlayerScene2 scene]];
    [[CCDirector sharedDirector] replaceScene:trans];
    
}
-(void) onPlayer3:(id)sender
{
    CCTransitionSlideInR* trans = [CCTransitionSlideInR transitionWithDuration:1 scene:[OtohimePlayerScene3 scene]];
    [[CCDirector sharedDirector] replaceScene:trans];
}

-(void) onBack:(id)sender
{
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    [SceneManager goTopMenu:@"Fade"];
}



@end
