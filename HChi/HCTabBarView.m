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
        tabBarIconPoint = CGPointMake(0, 0);
        
        CGRect rootViewButtonRect = CGRectMake(ScreenSize.width / 2 - ScreenSize.width / 4 - tabBarIconSize.width / 2, tabBarIconPoint.y, tabBarIconSize.width, tabBarIconSize.height);
        CGRect issueViewButtonRect = CGRectMake(ScreenSize.width / 2 - tabBarIconSize.width / 2, tabBarIconPoint.y, tabBarIconSize.width, tabBarIconSize.height);
        CGRect personViewButtonRect = CGRectMake(ScreenSize.width / 2 + ScreenSize.width / 4 - tabBarIconSize.width / 2, tabBarIconPoint.y, tabBarIconSize.width, tabBarIconSize.height);
        // root View
        _selectRootViewButton = [[UIButton alloc] initWithFrame:rootViewButtonRect];
        _selectRootViewButton.backgroundColor = [UIColor blackColor];
        
        // issue View
        _selectIssueViewButton = [[UIButton alloc] initWithFrame:issueViewButtonRect];
        _selectIssueViewButton.backgroundColor = [UIColor blackColor];
        
        // person View
        _selectPersonViewButton = [[UIButton alloc] initWithFrame:personViewButtonRect];
        _selectPersonViewButton.backgroundColor = [UIColor blackColor];
        
        
        [self addSubview:_selectRootViewButton];
        [self addSubview:_selectIssueViewButton];
        [self addSubview:_selectPersonViewButton];
        
        _selectRootViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(rootViewButtonRect.origin.x, rootViewButtonRect.origin.y + rootViewButtonRect.size.height, 40, 22)];
        _selectRootViewLabel.textColor = HCColorForTheme;
        [self setFontWithLabel:_selectRootViewLabel withTitle:@"有雅兴"];
        [self addSubview:_selectRootViewLabel];
        
        _selectPersonViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(personViewButtonRect.origin.x, rootViewButtonRect.origin.y + rootViewButtonRect.size.height, 40, 22)];
        _selectPersonViewLabel.textColor = HCColorForTheme;
        [self setFontWithLabel:_selectPersonViewLabel withTitle:@"个人"];
        [self addSubview:_selectPersonViewLabel];
    }
    return self;
}

- (void)setFontWithLabel:(UILabel *)label withTitle:(NSString *)title {
    label.font = [UIFont systemFontOfSize:10];
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
