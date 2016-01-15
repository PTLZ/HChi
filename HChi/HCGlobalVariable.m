//
//  HCGlobalVariable.m
//  HChi
//
//  Created by uniQue on 16/1/11.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "HCGlobalVariable.h"
#import "HCTabBarView.h"

UIColor * HCColorForSubView = nil;
UIColor * HCColorForRootView = nil;
UIColor * HCColorForTheme = nil;

UIImageView * HCNCBackgroundForSubView = nil;
CAGradientLayer * HCNCBackgroundForRootView = nil;
CGSize ScreenSize;

HCTabBarView * HCNCTabBarView = nil;

int HCThemeFontSize;
int HCArticleFontSize;

BOOL RootViewCellShowingAnimate = true;
BOOL ClassificationViewCellShowAnimate = true;

void HCShowTabBarView(BOOL hidden) {
    CGRect rect = HCNCTabBarView.frame;
    if (!hidden) {
        rect.origin.y = ScreenSize.height;
    } else {
        rect.origin.y = ScreenSize.height - 49;
    }
    [UIView animateWithDuration:0.5 animations:^{
        HCNCTabBarView.frame = rect;
    }];
}

@implementation HCGlobalVariable


@end
