//
//  IssueView.m
//  HChi
//
//  Created by uniQue on 16/1/16.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "IssueView.h"
#import "HCGlobalVariable.h"

@interface IssueView ()

@end

@implementation IssueView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.alpha = 0;
        UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        self.effect = blur;
        self.frame = self.bounds;
        
#pragma mark 添加点击手势 消失
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(remove)];
        [self addGestureRecognizer:tap];
#pragma mark 添加按钮 左
        _uploadMenuButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenSize.width / 2 / 2 + ScreenSize.width/2/2/2 - ScreenSize.width / 4 /2 /2, ScreenSize.height - 49 - ScreenSize.width / 4 /2 - 60, ScreenSize.width / 4 / 2, ScreenSize.width / 4 / 2)];
        _uploadMenuButton.backgroundColor = [UIColor greenColor];
        [self addSubview:_uploadMenuButton];
        
        // 右
        _uploadProductButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenSize.width / 2 + ScreenSize.width/2/2/2 - ScreenSize.width / 4 /2 /2, ScreenSize.height - 49 - ScreenSize.width / 4 /2 - 60, ScreenSize.width / 4 / 2, ScreenSize.width / 4 / 2)];
        _uploadProductButton.backgroundColor = [UIColor greenColor];
        [self addSubview:_uploadProductButton];
        
    }
    return self;
}

- (void)remove {
    [self.removeDelegate removeSelf];
}


@end
