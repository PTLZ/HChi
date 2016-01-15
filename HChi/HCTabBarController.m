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

@interface HCTabBarController ()

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

- (void)issueViewButtonAction {
//    self.selectedIndex = 0;
    NSLog(@"点击了发布按钮");
}

- (void)personViewButtonAction {
    self.selectedIndex = 2;
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
