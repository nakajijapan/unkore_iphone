//
//  SceneManager.h
//  cocos2d-menu
//
//  Created by Daichi Nakajima on 12/07/03.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "TopMenuScene.h"
#import "GameMenuScene.h"
#import "GameScene.h"
#import "OtohimeScene.h"

#define TRANSITION_DURATION (0.6f)

@interface SceneManager : NSObject {
    
}


+(void) goTopMenu;
+(void) goTopMenu:(NSString*)transName;
+(void) goGameMenu;
+(void) goGameMenu:(NSString*)transName;

+(void) goGameStart:(NSString*)transName;


+(void) goOtohimeMenu:(NSString*)transName;
@end