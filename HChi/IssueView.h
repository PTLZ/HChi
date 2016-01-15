//
//  IssueView.h
//  HChi
//
//  Created by uniQue on 16/1/16.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RemoveEffectViewProtocol <NSObject>

- (void)removeSelf;

@end

@interface IssueView : UIVisualEffectView

@property (nonatomic, strong) id<RemoveEffectViewProtocol> removeDelegate;

@property (nonatomic, strong) UIButton * uploadMenuButton;
@property (nonatomic, strong) UIButton * uploadProductButton;

@end
