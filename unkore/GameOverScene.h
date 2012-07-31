//
//  GameOverScene.h
//  unkore
//
//  Created by Daichi Nakajima on 12/07/16.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "SceneManager.h"
#import <Twitter/Twitter.h>

@interface GameOverScene : CCLayer {
    UIViewController* viewController;
}

@property(nonatomic, retain) UIViewController* viewController;
+(id) scene;

@end
