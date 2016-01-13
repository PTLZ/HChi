//
//  CustomViewController.m
//  HChi
//
//  Created by uniQue on 16/1/11.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "CustomViewController.h"

@interface CustomViewController ()

@end

@implementation CustomViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated {
    self.hidesBottomBarWhenPushed = true;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.hidesBottomBarWhenPushed = false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
