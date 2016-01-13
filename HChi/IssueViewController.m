//
//  IssueViewController.m
//  HChi
//
//  Created by uniQue on 16/1/11.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "IssueViewController.h"
#import "HCGlobalVariable.h"

@interface IssueViewController ()

@end

@implementation IssueViewController

#pragma mark 初始化 init
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"发布";
    }
    return self;
}

#pragma mark 加载完毕 View did load
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar addSubview:HCNCBackgroundForSubView];
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
