//
//  TableViewDataSource.h
//  HChi
//
//  Created by uniQue on 16/1/11.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TableViewCellConfigureBlock)(id cell, id item);

@interface TableViewDataSource : NSObject<UITableViewDataSource>

- (id)initWithItems:(NSArray *)aItems
        cellIdentifier:(NSString *)aCellIdentifier
             cellBlock:(TableViewCellConfigureBlock)aCellBlock;

@end
