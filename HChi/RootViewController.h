//
//  RootViewController.h
//  HChi
//
//  Created by uniQue on 16/1/11.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomViewController.h"

@interface RootViewController : CustomViewController

@property (nonatomic, strong) UITableView * rootTableView;

@property (nonatomic, strong) UICollectionView * rootCollectionView;

@end
