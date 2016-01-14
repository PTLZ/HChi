//
//  CollectionViewLayout.m
//  HChi
//
//  Created by uniQue on 16/1/13.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "CollectionViewLayout.h"

@implementation CollectionViewLayout

// 瀑布流初始化方法
- (void)prepareLayout{
    [super prepareLayout];
    
    float x1 = self.sectionInset.left;
    float x2 = self.sectionInset.left;
    int list = 0;
    
    self.allAttributes = [NSMutableArray new];
    
    // 拿到cell个数
    long int allCount = [self.collectionView numberOfItemsInSection:0];
    
    // 创建自己的布局
    for (int i = 0; i < allCount; i++) {
        NSIndexPath * indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        UICollectionViewLayoutAttributes * attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        CGRect attRect = CGRectZero;
        
        attRect.size = [self.delegate reWithIndexPath:indexPath];
        
        if (indexPath.row < 3) {
            attRect.origin.x = x1;
            attRect.origin.y = self.maxY1 + self.sectionInset.top;
            self.maxY1 += attRect.size.height + self.minimumLineSpacing;
        } else if (indexPath.row >= 3 && indexPath.row < 18) {
            list++;
            attRect.origin.x = x1;
            attRect.origin.y = self.maxY1 - self.minimumLineSpacing;
            x1 = attRect.origin.x + attRect.size.width + self.minimumInteritemSpacing;
            if (list == 5) {
                list = 0;
                x1 = 0;
                self.maxY1 += attRect.size.height + 0.5;
            }
        } else {
            attRect.origin.x = x2;
            attRect.origin.y = self.maxY2 + self.sectionInset.top;
            self.maxY2 += attRect.size.height + self.minimumInteritemSpacing;
        }
        
        attributes.frame = attRect;
        
        [self.allAttributes addObject:attributes];
    }
}

//返回当前显示尺寸下布局信息
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    return self.allAttributes;
}

//返回可滑动内容的大小范围
- (CGSize)collectionViewContentSize{
    
    float maxY = 0;
    
    if (self.maxY1 > self.maxY2) {
        maxY = self.maxY1;
    }else{
        maxY = self.maxY2;
    }
    
    return CGSizeMake(320, maxY+self.sectionInset.top +self.sectionInset.bottom);
}


@end
