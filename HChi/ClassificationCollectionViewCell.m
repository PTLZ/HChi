//
//  ClassificationCollectionViewCell.m
//  HChi
//
//  Created by uniQue on 16/1/15.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "ClassificationCollectionViewCell.h"
#import "HCGlobalVariable.h"

@implementation ClassificationCollectionViewCell

CGRect _classificationCellRecoverRect;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        self.layer.cornerRadius = 5;
//        self.layer.masksToBounds = true;
        
        self.textLabel = [[UILabel alloc] initWithFrame:self.bounds];
        self.textLabel.font = [UIFont systemFontOfSize:HCThemeFontSize];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.autoresizingMask  = UIViewAutoresizingFlexibleWidth;
        [self addSubview:self.textLabel];
    }
    return self;
}

- (void)classificationVieCellShowAnimate {
    CGRect rect = self.frame;
    _classificationCellRecoverRect = rect;
    self.alpha = 0;
    if (ClassificationViewCellShowAnimate) {
        rect.origin = CGPointMake(rect.origin.x, rect.origin.y + 200);
        self.frame = rect;
    } else {
        rect.origin = CGPointMake(rect.origin.x, rect.origin.y - 10);
        self.frame = rect;
    }
    [UIView animateWithDuration:0.5 delay:0.1 options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction animations:^{
        if (rect.origin.y != _classificationCellRecoverRect.origin.y) {
            self.frame = _classificationCellRecoverRect;
        }
        self.alpha = 1;
    } completion:nil];
}

- (void)startAnimate {
    
}

@end
