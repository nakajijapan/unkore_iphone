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
		
		// Fake User Interface which does nothing.
        /*
		CCLabelTTF* label = [CCLabelTTF labelWithString:@"Hip" fontName:@"Courier" fontSize:22];
		label.color = ccBLACK;
		label.position = CGPointMake(screenSize.width / 2, screenSize.height);
		label.anchorPoint = CGPointMake(0.5f, 1);
		[self addChild:label];
         */
		
		self.isTouchEnabled = YES;
        
        //CCRepeatForever *repeat = [CCRepeatForever actionWithAction: [CCRotateBy actionWithDuration:1.0f angle:360]];
        
        // お尻を左右に振らせる
        CCMoveBy* move1 = [CCMoveBy actionWithDuration:.1f  position: ccp(5,0)];
        CCMoveBy* move2 = [CCMoveBy actionWithDuration:.1f  position: ccp(-5,0)];
        CCMoveBy* move3 = [CCMoveBy actionWithDuration:.1f  position: ccp(-5,0)];
        CCMoveBy* move4 = [CCMoveBy actionWithDuration:.1f  position: ccp(5,0)];
        CCDelayTime* delay = [CCDelayTime actionWithDuration:5.0f];
        CCSequence* sequence = [CCSequence actions:move1, move2, move3, move4, move1, move2, move3, move4, delay, nil];
        CCRepeatForever *repeat = [CCRepeatForever actionWithAction: sequence];
        /*
         id shaky = [CCShaky3D actionWithRange:1 shakeZ:NO grid:ccg(15,10) duration:2];
         CCRepeatForever *repeat = [CCRepeatForever actionWithAction: shaky];
         */
        
        [self runAction:repeat];
	}
	return self;
}

-(void) show
{
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCLOG(@"HipLayer show  : %f", screenSize.height);
    
    id action1 = [CCMoveBy actionWithDuration:2.0f  position: ccp(0, -250)];
    id action2 = [CCEaseElasticOut actionWithAction:action1 period:0.35f];
    [self runAction:action2];
}
@end
