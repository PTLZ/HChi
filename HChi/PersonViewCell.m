//
//  PersonViewCell.m
//  HChi
//
//  Created by uniQue on 16/1/12.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "PersonViewCell.h"

@implementation PersonViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)configureCellWithDic:(NSDictionary *)dic {
    NSString * title = dic[@"title"];
    self.textLabel.text = title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
