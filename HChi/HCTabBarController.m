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
    
    CGRect tabBarViewFrame = CGRectMake(0, ScreenSize.height - 49, ScreenSize.width, 49);
    HCTabBarView * tabBarView = [[HCTabBarView alloc] initWithFrame:tabBarViewFrame];
    [self.view addSubview:tabBarView];
    
    [tabBarView.selectRootViewButton addTarget:self action:@selector(rootViewButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [tabBarView.selectIssueViewButton addTarget:self action:@selector(issueViewButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [tabBarView.selectPersonViewButton addTarget:self action:@selector(personViewButtonAction) forControlEvents:UIControlEventTouchUpInside];
}
- (void)rootViewButtonAction {
    self.selectedIndex = 0;
}

- (void)issueViewButtonAction {
    self.selectedIndex = 1;
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
