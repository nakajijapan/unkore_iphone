//
//  HipLayer.m
//  unkore
//
//  Created by Daichi Nakajima on 12/07/18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "HipLayer.h"

@implementation HipLayer
-(id) init
{
	if ((self = [super init]))
	{
		CGSize screenSize = [[CCDirector sharedDirector] winSize];
		
		CCSprite* uiframe = [CCSprite spriteWithFile:@"game_hip001.png"];
		uiframe.position = CGPointMake(0, screenSize.height + 250);
		uiframe.anchorPoint = CGPointMake(0, 1);
		[self addChild:uiframe z:0 tag:UILayerTagFrameSprite];
		
		self.isTouchEnabled = YES;
        
        // お尻を左右に振らせる
        CCMoveBy* move1 = [CCMoveBy actionWithDuration:.3f  position: ccp(5,0)];
        CCMoveBy* move2 = [CCMoveBy actionWithDuration:.3f  position: ccp(-5,0)];
        CCMoveBy* move3 = [CCMoveBy actionWithDuration:.3f  position: ccp(-5,0)];
        CCMoveBy* move4 = [CCMoveBy actionWithDuration:.3f  position: ccp(5,0)];
        CCDelayTime* delay = [CCDelayTime actionWithDuration:5.0f];
        
        
        CCSequence* sequence = [CCSequence actions:move1, move2, move3, move4, move1, move2, move3, move4, delay, nil];
        CCRepeatForever *repeat = [CCRepeatForever actionWithAction: sequence];
        
        [self runAction:repeat];
	}
	return self;
}

-(void) show
{
    id action1 = [CCMoveBy actionWithDuration:2.0f  position: ccp(0, -250)];
    id action2 = [CCEaseElasticOut actionWithAction:action1 period:0.35f];
    [self runAction:action2];
}


@end
