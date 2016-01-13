//
//  RootViewCell.m
//  HChi
//
//  Created by uniQue on 16/1/11.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "RootViewCell.h"

@implementation RootViewCell

+ (UINib *)nib {
    return [UINib nibWithNibName:@"RootViewCell" bundle:nil];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)configureCellWithDic:(NSDictionary *)dic {
    NSString * title = dic[@"title"];
    self.rootTitleLabel.text = title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
