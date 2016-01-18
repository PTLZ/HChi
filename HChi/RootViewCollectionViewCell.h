//
//  RootViewCollectionViewCell.h
//  HChi
//
//  Created by uniQue on 16/1/15.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewCollectionViewCell : UICollectionViewCell

@property UIImageView * imageView;
@property (nonatomic, strong) UILabel * menuListLabel;


- (void)rootViewCellShowAnimate;
- (void)setCellContentWithImageName:(NSString *)name withRow:(long int)row;
- (void)setCellMenuListWithTitle:(NSString *)title withRow:(long int)row;

- (void)setCellContentsWithData:(id)data withRow:(long int)row;

@end
