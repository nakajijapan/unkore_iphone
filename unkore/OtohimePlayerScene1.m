//
//  OtohimePlayerScene1.m
//  unkore
//
//  Created by Daichi Nakajima on 12/07/22.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "OtohimePlayerScene1.h"


@implementation OtohimePlayerScene1


-(id) init
{
    self = [super init];
    if (self) {
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        // Musicのプレリロード
        [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"unkore_otohime002.mp3"];
        
        // 背景画像
        CCSprite* uiframe = [CCSprite spriteWithFile:@"ogawa_background.png"];
        uiframe.position = CGPointMake(0, screenSize.height);
        uiframe.anchorPoint = CGPointMake(0, 1);
        [self addChild:uiframe z:0];
        
        // back画像
        CCMenuItemImage* menuItemHome = [CCMenuItemImage itemWithNormalImage:@"otohime_btn_back.png" selectedImage:nil target:self selector:@selector(onBack:)];
        CCMenu* menuHome = [CCMenu menuWithItems:menuItemHome, nil];
        menuHome.position       = CGPointMake(5, screenSize.height - 5);
        menuItemHome.anchorPoint    = CGPointMake(0, 1);
        [self addChild:menuHome z: 2];
        
        
        // 再生ボタン
        CCMenuItemImage* menuSoundStart = [CCMenuItemImage itemWithNormalImage:@"ogawa_btn_start.png" selectedImage:nil];
        _menuSoundStop = [CCMenuItemImage itemWithNormalImage:@"ogawa_btn_stop.png" selectedImage:nil];
        CCMenuItemToggle* menuToggle = [CCMenuItemToggle itemWithTarget:self 
                                                               selector:@selector(onSoundCallback:) 
                                                                  items:menuSoundStart, _menuSoundStop, nil];
        CCMenu* menuMain = [CCMenu menuWithItems:menuToggle, nil];
        menuMain.position = ccp(screenSize.width / 2, screenSize.height / 2);
        [self addChild:menuMain z: 2];
        
    }
    return self;
}

+(id)scene
{
	CCScene* scene = [CCScene node];
	OtohimePlayerScene1* layer = [OtohimePlayerScene1 node];
	[scene addChild:layer];
	return scene;
}


-(void) onSoundCallback:(id)sender
{
    NSLog(@"selected item: %@ index:%u", [sender selectedItem], (unsigned int) [sender selectedIndex] );
    
    // 再生(0 -> 1)
    if ([sender selectedIndex] == 1) {
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"unkore_otohime002.mp3"];
        id action = [CCRotateBy actionWithDuration:1.5f  angle: 360];
        id sequence = [CCSequence actions:action, nil];
        id repeat = [CCRepeatForever actionWithAction: sequence];
        [_menuSoundStop runAction:repeat];
    }
    // 停止
    else {
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        [_menuSoundStop unscheduleAllSelectors];
    }
    
}

-(void) onBack:(id)sender
{
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    [SceneManager goOtohimeMenu:@"SlideL"];
}
@end
