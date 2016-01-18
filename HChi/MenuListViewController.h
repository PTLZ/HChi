//
//  MenuListViewController.h
//  HChi
//
//  Created by uniQue on 16/1/18.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol getTitleLabelTextProtocol <NSObject>

- (void)getTitleLabelText;

@end

@interface MenuListViewController : UIViewController

@property NSString * navTitleText;

@end
