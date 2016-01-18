//
//  MenuListViewController.m
//  HChi
//
//  Created by uniQue on 16/1/18.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "MenuListViewController.h"
#import "HCGlobalVariable.h"
#import "TableViewDataSource.h"
#import "MenuListTableViewCell.h"


static NSString * const MenuListViewCellIdentifier = @"ListCell";

@interface MenuListViewController ()<UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) TableViewDataSource * tableViewDataSource;

@end

@implementation MenuListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self initView];
}

- (void)initView {
#pragma mark 创建navView
    UIVisualEffectView * effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    effectView.frame = CGRectMake(0, 0, ScreenSize.width, 64);
    [self.view addSubview:effectView];
    
    UIButton * backButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenSize.width - 60, 44/2 + 20 - 10, 60, 20)];
    [backButton setTitleColor:HCColorForTheme forState:UIControlStateNormal];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [backButton addTarget:self action:@selector(backViewController) forControlEvents:UIControlEventTouchUpInside];
    [effectView addSubview:backButton];
    
    UILabel * navTitle = [[UILabel alloc] initWithFrame:CGRectMake(ScreenSize.width / 2 - 60, 44/2 + 20 - 10, 120, 20)];
    navTitle.text = self.navTitleText;
    navTitle.font = [UIFont boldSystemFontOfSize:17];
    navTitle.textAlignment = NSTextAlignmentCenter;
    [effectView addSubview:navTitle];
#pragma mark 创建列表
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height) style:UITableViewStylePlain];
    
    _tableView.tableFooterView = [UIView new];
    _tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    _tableView.backgroundColor = [UIColor clearColor];
    
    TableViewCellConfigureBlock listCellConfigureBlock = ^(MenuListTableViewCell * listCell, NSDictionary * dic){
        [listCell configureCellWithDic:dic];
    };
    
    self.tableViewDataSource = [[TableViewDataSource alloc] initWithItems:@[@[@{@"title":@",,,,"}]] cellIdentifier:MenuListViewCellIdentifier cellBlock:listCellConfigureBlock];
    
    _tableView.delegate = self;
    _tableView.dataSource = self.tableViewDataSource;
    
    [_tableView registerClass:[MenuListTableViewCell class] forCellReuseIdentifier:MenuListViewCellIdentifier];
    [self.view insertSubview:_tableView atIndex:0];
    
}

- (void)backViewController {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
