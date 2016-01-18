//
//  MenuListTableViewCell.m
//  HChi
//
//  Created by uniQue on 16/1/18.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "MenuListTableViewCell.h"

@implementation MenuListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)configureCellWithDic:(NSDictionary *)dic {
    NSString * title = dic[@"title"];
    self.textLabel.text = title;
    
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
