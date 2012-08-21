//
//  GameHelpScene.m
//  unkore
//
//  Created by Daichi Nakajima on 12/08/18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameHelpScene.h"
//#import "GameLayer.h"


@implementation GameHelpScene

+(id) scene
{
	CCScene* scene = [CCScene node];
	GameHelpScene* layer = [GameHelpScene node];
	[scene addChild:layer];
	return scene;
}

-(id) init 
{
    self = [super init];
    if (self) {
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
		
        //----------------------------------------
        // back画像
        CCMenuItemImage* menuItemHome = [CCMenuItemImage itemWithNormalImage:@"otohime_btn_back.png" selectedImage:nil target:self selector:@selector(onBack:)];
        CCMenu* menuHome = [CCMenu menuWithItems:menuItemHome, nil];
        menuHome.position       = CGPointMake(5, screenSize.height - 5);
        menuItemHome.anchorPoint    = CGPointMake(0, 1);
        [self addChild:menuHome z: 100];
        
        
        //----------------------------------------
        // 背景画像
        /*
		//GameLayer* gameLayer = [GameLayer node];
		//[self addChild:gameLayer z:10 tag:1];

        //UIScrollView* helpScrollView;
        helpScrollView = [[UIScrollView alloc] init];
        helpScrollView.frame = CGRectMake(0, 100, screenSize.width, screenSize.height -100);
        helpScrollView.backgroundColor = [UIColor blackColor];
        helpScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        helpScrollView.pagingEnabled = YES;
        helpScrollView.contentSize   = CGSizeMake(screenSize.width * 3, screenSize.height);
        //helpScrollView.contentInset = UIEdgeInsetsMake(0,0,0,100 );
        [helpScrollView flashScrollIndicators];
        
        helpScrollView.showsHorizontalScrollIndicator = YES;
        helpScrollView.scrollsToTop = NO;
        
        //UIViewController* vc = [[UIViewController alloc] init];
        //vc.view = helpScrollView;
        
        // init
        CGFloat x = 0;
        for (int i=0; i < 3; i++) {
            // content
            CGRect rect = CGRectMake(x, 0, screenSize.width, screenSize.height -100);
            //UIImage *image = [UIImage imageNamed:[[NSString alloc] initWithFormat:@"background.png", i+1]];
            UIImage *image = [UIImage imageNamed:@"background.png"];
            UIImageView *view = [[[UIImageView alloc] initWithImage:image] autorelease];
            
            view.frame = rect;
            [helpScrollView addSubview:view];
            x += rect.size.width;
        }
        
        //[[CCDirector sharedDirector] addChildViewController:vc];
        [[[CCDirector sharedDirector] openGLView] addSubview:helpScrollView];
         */

        //----------------------------------------
        // 枠画像
        CCSprite* sideframe = [CCSprite spriteWithFile:@"game_waku.png"];
        sideframe.position = CGPointMake(0, screenSize.height);
        sideframe.anchorPoint = CGPointMake(0, 1);
        [self addChild:sideframe z:31];
    }

    
    return self;
}

#pragma mark -
#pragma mark 画面遷移
-(void) onBack:(id)sender
{
    //[[[CCDirector sharedDirector] openGLView] removeFromSuperview];
    [SceneManager goTopMenu:@"Fade"];
}

#pragma mark -
#pragma mark lifecycle

@end
