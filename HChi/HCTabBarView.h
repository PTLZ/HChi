//
//  HCTabBarView.h
//  HChi
//
//  Created by uniQue on 16/1/13.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HCTabBarView : UIView

/// root View 按钮 与 标签
@property (nonatomic, strong) UIButton * selectRootViewButton;
@property (nonatomic, strong) UILabel * selectRootViewLabel;
/// issue View 按钮 与 标签
@property (nonatomic, strong) UIButton * selectIssueViewButton;
@property (nonatomic, strong) UILabel * selectIssueViewLabel;
/// person View 按钮 与 标签
@property (nonatomic, strong) UIButton * selectPersonViewButton;
@property (nonatomic, strong) UILabel * selectPersonViewLabel;



@end
