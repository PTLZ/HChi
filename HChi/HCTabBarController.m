//
//  HCTabBarController.m
//  HChi
//
//  Created by uniQue on 16/1/13.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "HCTabBarController.h"
#import "HCGlobalVariable.h"
#import "HCTabBarView.h"
#import "IssueView.h"

@interface HCTabBarController ()<RemoveEffectViewProtocol>

@property (nonatomic, strong) IssueView * issueBackgroundView;
@end

@implementation HCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tabBar.hidden = true;
    [self.view addSubview:HCNCTabBarView];
    
    [HCNCTabBarView.selectRootViewButton addTarget:self action:@selector(rootViewButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [HCNCTabBarView.selectIssueViewButton addTarget:self action:@selector(issueViewButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [HCNCTabBarView.selectPersonViewButton addTarget:self action:@selector(personViewButtonAction) forControlEvents:UIControlEventTouchUpInside];
}
- (void)rootViewButtonAction {
    self.selectedIndex = 0;
}

CGRect _loadRect;
CGRect _recoverLoadRect;
CGRect _productRect;
CGRect _recoverProductRect;

- (void)issueViewButtonAction {
    
    if (!_issueBackgroundView) {
        _issueBackgroundView = [[IssueView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height)];
        _issueBackgroundView.removeDelegate = self;
        [self.view insertSubview:_issueBackgroundView atIndex:2];
        
        _loadRect = _issueBackgroundView.uploadMenuButton.frame;
        _recoverLoadRect = _loadRect;
        _loadRect.origin.y = ScreenSize.height;
        _loadRect.origin.x = ScreenSize.width/2/2 + ScreenSize.width/2/2/2;
        _loadRect.size = CGSizeMake(0, 0);
        _issueBackgroundView.uploadMenuButton.frame = _loadRect;
        
        _productRect = _issueBackgroundView.uploadProductButton.frame;
        _recoverProductRect = _productRect;
        _productRect.origin.y = ScreenSize.height;
        _issueBackgroundView.uploadProductButton.frame = _productRect;
        
        
        [UIView animateWithDuration:0.3 animations:^{
            _issueBackgroundView.alpha = 1;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                _issueBackgroundView.uploadMenuButton.frame = _recoverLoadRect;
                _issueBackgroundView.uploadProductButton.frame = _recoverProductRect;
            } completion:nil];
        }];
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            _issueBackgroundView.uploadMenuButton.frame = _loadRect;
            _issueBackgroundView.uploadProductButton.frame = _productRect;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                _issueBackgroundView.alpha = 0;
            } completion:^(BOOL finished) {
                [_issueBackgroundView removeFromSuperview];
                _issueBackgroundView = nil;
            }];
        }];
    }
    
}

- (void)removeSelf {
    [self issueViewButtonAction];
}

- (void)personViewButtonAction {
    self.selectedIndex = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
