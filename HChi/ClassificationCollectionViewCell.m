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
    self.textLabel.alpha = 0;
    if (ClassificationViewCellShowAnimate) {
        rect.origin = CGPointMake(rect.origin.x, rect.origin.y + 100);
        self.frame = rect;
    } else {
        rect.origin = CGPointMake(rect.origin.x, rect.origin.y - 100);
    }
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        if (rect.origin.y != _classificationCellRecoverRect.origin.y) {
            self.frame = _classificationCellRecoverRect;
        }
        self.textLabel.alpha = 1;
    } completion:nil];
//    NSThread* thread = [[NSThread alloc] initWithTarget:self selector:@selector(startAnimate) object:nil];
//    [thread start];
}

- (void)startAnimate {
    
}

@end
