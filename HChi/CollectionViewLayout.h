//
//  CollectionViewLayout.h
//  HChi
//
//  Created by uniQue on 16/1/13.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CollectionViewFlowLayoutProtocol <NSObject>

- (CGSize)reWithIndexPath:(NSIndexPath *)indexPath;

@end

@interface CollectionViewLayout : UICollectionViewFlowLayout

@property (nonatomic, strong) id<CollectionViewFlowLayoutProtocol> delegate;

@property NSMutableArray * allAttributes;

@property CGFloat maxY1;
@property CGFloat maxY2;

@end
