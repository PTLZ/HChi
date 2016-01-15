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
    if (RootViewCellShowingAnimate) {
        CGRect rect = self.frame;
        _rootViewCellRecoverRect = rect;
        rect.origin = CGPointMake(rect.origin.x, rect.origin.y + 100);
        self.frame = rect;
        self.alpha = 0;
        
        [UIView animateWithDuration:0.5 animations:^{
            self.frame = _rootViewCellRecoverRect;
            self.alpha = 1;
        }];
    } else {
        return;
    }
}

@end
