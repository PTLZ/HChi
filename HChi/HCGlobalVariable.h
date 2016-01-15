//
//  HCGlobalVariable.h
//  HChi
//
//  Created by uniQue on 16/1/11.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCTabBarView.h"


extern UIColor * HCColorForSubView;
extern UIColor * HCColorForRootView;
extern UIColor * HCColorForTheme;

extern UIImageView * HCNCBackgroundForSubView;
extern CAGradientLayer * HCNCBackgroundForRootView;
extern CGSize ScreenSize;

extern HCTabBarView * HCNCTabBarView;

extern int HCThemeFontSize;
extern int HCArticleFontSize;

extern BOOL RootViewCellShowingAnimate;
extern BOOL ClassificationViewCellShowAnimate;

void HCShowTabBarView(BOOL hidden);


@interface HCGlobalVariable : NSObject

@end
