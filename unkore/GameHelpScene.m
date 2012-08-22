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
        
		//----------------------------------------
        // ヘルプ１
        spriteHelp01 = [CCSprite spriteWithFile:@"play_background.png"];
		spriteHelp01.position = CGPointMake(0, screenSize.height);
		spriteHelp01.anchorPoint = CGPointMake(0, 1);
		[self addChild:spriteHelp01 z:0 tag:3];
        
        //----------------------------------------
        // ヘルプ２
        spriteHelp02 = [CCSprite spriteWithFile:@"play_background02.png"];
		spriteHelp02.position = CGPointMake(screenSize.width * 2, screenSize.height);
		spriteHelp02.anchorPoint = CGPointMake(0, 1);
		[self addChild:spriteHelp02 z:0 tag:4];
        
        //----------------------------------------
        // メニュー
        menuArrow = [CCMenuItemImage itemWithNormalImage:@"play_btn_next.png" selectedImage:nil target:self selector:@selector(onMoveRight:)];
        CCMenu *menu = [CCMenu menuWithItems:menuArrow, nil];
        menu.position = ccp(screenSize.width / 2, 50);
        menu.anchorPoint = ccp(0.5, 0.5);
        [menu alignItemsVerticallyWithPadding:0.0f];
        [self addChild:menu z: 2];
        
        
        // page
        page = 1;
    }

    return self;
}

#pragma mark -
#pragma mark 画面遷移
-(void) onBack:(id)sender
{
    [SceneManager goGameMenu:@"Fade"];
}

-(void) onMoveRight:(id)sender
{
    CCLOG(@"%s",__FUNCTION__);
    CGSize screenSize = [[CCDirector sharedDirector] winSize];

    id move1;
    id move2;
    id move3;

    // to 2 page
    if (page == 1) {
        move1 = [CCMoveTo actionWithDuration:.2f  position: ccp(-screenSize.width,screenSize.height)];
        move2 = [CCMoveTo actionWithDuration:.2f  position: ccp(0,screenSize.height)];
        
        [spriteHelp01 runAction:move1];
        [spriteHelp02 runAction:move2];
        
        page = 2;
    }
    // to 1 page
    else if (page == 2) {
        move1 = [CCMoveTo actionWithDuration:.2f  position: ccp(0,screenSize.height)];
        move2 = [CCMoveTo actionWithDuration:.2f  position: ccp(screenSize.width,screenSize.height)];
        
        [spriteHelp01 runAction:move1];
        [spriteHelp02 runAction:move2];
        page = 1;
    }
    
    move3 = [CCRotateBy actionWithDuration:.2f angle: 180];
    [menuArrow runAction:move3];
}

#pragma mark -
#pragma mark lifecycle

@end
