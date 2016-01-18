//
//  RootViewCollectionViewCell.m
//  HChi
//
//  Created by uniQue on 16/1/15.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "RootViewCollectionViewCell.h"
#import "HCGlobalVariable.h"

@interface RootViewCollectionViewCell ()



@end

@implementation RootViewCollectionViewCell

CGRect _rootViewCellRecoverRect;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:_imageView];
        
        _menuListLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _menuListLabel.textAlignment = NSTextAlignmentCenter;
        _menuListLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_menuListLabel];
    }
    return self;
}

- (void)setCellContentWithImageName:(NSString *)name withRow:(long int)row {
    if (row == 1) {
        _imageView.hidden = false;
        self.imageView.image = [UIImage imageNamed:name];
    } else {
        _imageView.hidden = true;
    }
}

- (void)setCellMenuListWithTitle:(NSString *)title withRow:(long int)row {
    
    if (row >= 3 && row < 12) {
        _menuListLabel.hidden = false;
        _menuListLabel.text = title;
    } else if (row == 12) {
        _menuListLabel.hidden = false;
        _menuListLabel.text = @"...";
    } else {
        _menuListLabel.hidden = true;
    }
    
}

- (void)setCellContentsWithData:(id)data withRow:(long int)row {
    if (row < 3) {
        return;
    } else if (row >= 3 && row <= 12) {
        _menuListLabel.text = (NSString *)data;
        if (row == 12) {
            _menuListLabel.text = @"...";
        }
    } else {
//        _menuListLabel.hidden = true;
        _menuListLabel.text = @"caonima";
    }
}

- (void)rootViewCellShowAnimate {
    CGRect rect = self.frame;
    _rootViewCellRecoverRect = rect;
    rect.origin = CGPointMake(rect.origin.x, rect.origin.y + 200);
    rect.size.height = _rootViewCellRecoverRect.size.height / 2;
    self.alpha = 0;
    if (RootViewCellShowingAnimate) {
        self.frame = rect;
    } else {
        self.frame = _rootViewCellRecoverRect;
    }
    
    [UIView animateWithDuration:0.5 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        if (rect.origin.y != _rootViewCellRecoverRect.origin.y) {
            self.frame = _rootViewCellRecoverRect;
        }
        self.alpha = 1;
    } completion:nil];
}

@end
