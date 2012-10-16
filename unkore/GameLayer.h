//
//  GameLayer.h
//  unkore
//
//  Created by Daichi Nakajima on 12/07/18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameLayer : CCLayer {
    CCSpriteBatchNode* spriteBatch;
    CCArray* speedFactors;
}

@end
