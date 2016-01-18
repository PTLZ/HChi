//
//  PersonViewCell.m
//  HChi
//
//  Created by uniQue on 16/1/12.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "PersonViewCell.h"
#import "HCGlobalVariable.h"

@implementation PersonViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)configureCellWithDic:(NSDictionary *)dic {
    self.textLabel.font = [UIFont systemFontOfSize:14];
    NSString * title = dic[@"title"];
    self.textLabel.text = title;
    if ([title isEqualToString:@"退出"]) {
        self.textLabel.textColor = [UIColor redColor];
    } else {
        self.textLabel.textColor = [UIColor blackColor];
    }
    
    NSString * subTitle = dic[@"subTitle"];
    self.detailTextLabel.text = subTitle;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
