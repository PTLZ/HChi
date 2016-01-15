//
//  RootViewCollectionViewCell.m
//  HChi
//
//  Created by uniQue on 16/1/15.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "RootViewCollectionViewCell.h"
#import "HCGlobalVariable.h"

@implementation RootViewCollectionViewCell

CGRect _rootViewCellRecoverRect;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)rootViewCellShowAnimate {
    CGRect rect = self.frame;
    _rootViewCellRecoverRect = rect;
    rect.origin = CGPointMake(rect.origin.x, rect.origin.y + 200);
    rect.size.height = _rootViewCellRecoverRect.size.height / 2;
    self.alpha = 0;
    if (RootViewCellShowingAnimate) {
        self.frame = rect;
    } else {
        self.frame = _rootViewCellRecoverRect;
    }
    
    [UIView animateWithDuration:0.5 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        if (rect.origin.y != _rootViewCellRecoverRect.origin.y) {
            self.frame = _rootViewCellRecoverRect;
        }
        self.alpha = 1;
    } completion:nil];
}

@end
