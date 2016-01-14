//
//  HCTabBarView.m
//  HChi
//
//  Created by uniQue on 16/1/13.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "HCTabBarView.h"
#import "HCGlobalVariable.h"

@interface HCTabBarView ()

@property (nonatomic, strong) UILabel * labelForRootView;
@property (nonatomic, strong) UILabel * labelForIssueView;
@property (nonatomic, strong) UILabel * labelForPersonView;

@end

@implementation HCTabBarView


CGSize tabBarIconSize;
CGPoint tabBarIconPoint;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        tabBarIconSize = CGSizeMake(30, 30);
        tabBarIconPoint = CGPointMake(0, 2);
        // root View
        _selectRootViewButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenSize.width / 2 - ScreenSize.width / 4 - tabBarIconSize.width / 2, tabBarIconPoint.y, tabBarIconSize.width, tabBarIconSize.height)];
        _selectRootViewButton.backgroundColor = [UIColor blackColor];
        
        // issue View
        _selectIssueViewButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenSize.width / 2 - tabBarIconSize.width / 2, tabBarIconPoint.y, tabBarIconSize.width, tabBarIconSize.height)];
        _selectIssueViewButton.backgroundColor = [UIColor blackColor];
        
        // person View
        _selectPersonViewButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenSize.width / 2 + ScreenSize.width / 4 - tabBarIconSize.width / 2, tabBarIconPoint.y, tabBarIconSize.width, tabBarIconSize.height)];
        _selectPersonViewButton.backgroundColor = [UIColor blackColor];
        
        
        [self addSubview:_selectRootViewButton];
        [self addSubview:_selectIssueViewButton];
        [self addSubview:_selectPersonViewButton];
    }
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
