//
//  HCTabBarView.h
//  HChi
//
//  Created by uniQue on 16/1/13.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HCTabBarView : UIView

/// root View 按钮
@property (nonatomic, strong) UIButton * selectRootViewButton;
/// issue View 按钮
@property (nonatomic, strong) UIButton * selectIssueViewButton;
/// person View 按钮
@property (nonatomic, strong) UIButton * selectPersonViewButton;

@end
