//
//  CreditsScene.m
//  unkore
//
//  Created by Daichi Nakajima on 12/07/16.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CreditsScene.h"
#import "SceneManager.h"

@implementation CreditsScene

-(id) init
{
    self = [super init];
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    // message
    CCLabelTTF* labelProgrammer = [CCLabelTTF labelWithString:@"Program and Music" fontName:@"Marker Felt" fontSize:32];
    labelProgrammer.position = ccp(labelProgrammer.contentSize.width / 2, size.height - 50);
    [self addChild: labelProgrammer];
    
    CCLabelTTF* labelProgrammerName = [CCLabelTTF labelWithString:@"Daichi Nakajima" fontName:@"Marker Felt" fontSize:32];
    labelProgrammerName.position = ccp(labelProgrammerName.contentSize.width / 2, size.height - 100);
    [self addChild: labelProgrammerName];
    
    // message
    CCLabelTTF* labelDesigner = [CCLabelTTF labelWithString:@"Design and Produce" fontName:@"Marker Felt" fontSize:32];
    labelDesigner.position = ccp(labelDesigner.contentSize.width / 2, size.height - 150);
    [self addChild: labelDesigner];
    
    CCLabelTTF* labelDesignerName = [CCLabelTTF labelWithString:@"Misato Yamaguchi" fontName:@"Marker Felt" fontSize:32];
    labelDesignerName.position = ccp(labelDesignerName.contentSize.width / 2, size.height - 200);
    [self addChild: labelDesignerName];
    
    // back
    CCMenuItemFont *labelBack = [CCMenuItemFont itemWithString:@"back" target:self selector: @selector(onBack:)];
    CCMenu *menuBack = [CCMenu menuWithItems:labelBack, nil];
    menuBack.position = ccp(size.width - labelBack.contentSize.width / 2, 20);
    [self addChild:menuBack];
    
    return self;
}

+(id) scene
{
	CCScene* scene = [CCScene node];
	CreditsScene* layer = [CreditsScene node];
	[scene addChild:layer];
	return scene;
}


#pragma mark -
#pragma mark メニュー押下時の処理
-(void) onBack:(id)sender
{
    [SceneManager goTopMenu:@"JumpZoom"];
}
@end
