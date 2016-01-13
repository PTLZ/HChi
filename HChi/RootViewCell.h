//
//  RootViewCell.h
//  HChi
//
//  Created by uniQue on 16/1/11.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewCell : UITableViewCell

+ (UINib *)nib;

- (void)configureCellWithDic:(NSDictionary *)dic;

@property (weak, nonatomic) IBOutlet UILabel *rootTitleLabel;

@end
