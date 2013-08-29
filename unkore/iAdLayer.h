//
//  iAdLayer.h
//  nakajima
//
//  Created by Nakajima Daichi on 12/12/06.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import <iAd/iAd.h>

@interface iAdLayer : NSObject  {
    ADBannerView *bannerView;
    UINavigationController *navControllers;
}

@property (nonatomic, retain) ADBannerView *bannerView;

+(iAdLayer *)sharedInstance;
-(void)createAdView;

@end