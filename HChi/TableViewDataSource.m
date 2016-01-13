//
//  TableViewDataSource.m
//  HChi
//
//  Created by uniQue on 16/1/11.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "TableViewDataSource.h"
#import "HCGlobalVariable.h"

@interface TableViewDataSource ()

@property (nonatomic, strong) NSArray* items;
@property (nonatomic, copy) NSString* cellIdentifier;
@property (nonatomic, copy) TableViewCellConfigureBlock configureCellBlock;

@end

@implementation TableViewDataSource


- (id)init {
    return nil;
}

- (id)initWithItems:(NSArray *)aItems cellIdentifier:(NSString *)aCellIdentifier cellBlock:(TableViewCellConfigureBlock)aCellBlock {
    self = [super init];
    if (self) {
        self.items = aItems;
        self.cellIdentifier = aCellIdentifier;
        self.configureCellBlock = [aCellBlock copy];
    }
    return self;
}

- (NSInteger)numberOfSectionsInArray {
    return self.items.count;
}

- (NSInteger)numberOfRowsInArrayWithSection:(NSInteger)section {
    NSArray * dataArray = (NSArray *)self.items[section];
    return dataArray.count;
}

- (id)cellConfigureWithIndexPath:(NSIndexPath *)indexPath {
    NSArray * dataArray = (NSArray *)self.items[indexPath.section];
    NSDictionary * dic = (NSDictionary *)dataArray[indexPath.row];
    return dic;
}



#pragma mark- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self numberOfSectionsInArray];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self numberOfRowsInArrayWithSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    id item = (NSDictionary *)[self cellConfigureWithIndexPath:indexPath];
    
    self.configureCellBlock(cell, item);
    
    return cell;
}


@end


