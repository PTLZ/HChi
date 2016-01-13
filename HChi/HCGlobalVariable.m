//
//  HCGlobalVariable.m
//  HChi
//
//  Created by uniQue on 16/1/11.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "HCGlobalVariable.h"

UIColor * HCColorForSubView = nil;
UIColor * HCColorForRootView = nil;
UIColor * HCColorForTheme = nil;

UIImageView * HCNCBackgroundForSubView = nil;
CAGradientLayer * HCNCBackgroundForRootView = nil;
CGSize ScreenSize;



@implementation HCGlobalVariable

//- (id)init {
//    self = [super init];
//    if (self) {
//        _ScreenFrame = [UIScreen mainScreen].bounds;
//        _NCBackgroundColor = [UIColor colorWithRed:0.69 green:1.00 blue:0.59 alpha:1.00];
//    }
//    return self;
//}
//
//- (UIImageView *)NCBackground {
//    if (!_NCBackground) {
//        _NCBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, -20, _ScreenFrame.size.width, 64)];
//        _NCBackground.backgroundColor = _NCBackgroundColor;
//        return _NCBackground;
//    }
//    return _NCBackground;
//}
//
//- (UIView *)NCBackgroundView {
//    if (!_NCBackgroundView) {
//        
//        _NCBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, _ScreenFrame.size.width, 64)];
//        CAGradientLayer* bgLayer = [CAGradientLayer new];
//        bgLayer.frame = CGRectMake(0, 0, _ScreenFrame.size.width, 64);
//        bgLayer.colors = @[_NCBackgroundColor, [UIColor clearColor]];
//        [_NCBackgroundView.layer insertSublayer:bgLayer atIndex:0];
//        
//        return _NCBackgroundView;
//    }
//    return _NCBackgroundView;
//}

@end
