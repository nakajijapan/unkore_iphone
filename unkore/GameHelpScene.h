//
//  GameHelpScene.h
//  unkore
//
//  Created by Daichi Nakajima on 12/08/18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SceneManager.h"

@interface GameHelpScene : CCLayer {
    //UIScrollView* helpScrollView;
    
    CCSprite* spriteHelp01;
    CCSprite* spriteHelp02;
    CCMenuItemImage* menuArrow;
    int page;
}
+(id)scene;
@end
