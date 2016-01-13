//
//  RootViewController.m
//  HChi
//
//  Created by uniQue on 16/1/11.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "RootViewController.h"
#import "HCGlobalVariable.h"
#import "TableViewDataSource.h"
#import "RootViewCell.h"
#import "GuessYouLikeViewController.h"

static NSString * const RootViewCellIdentifier = @"RootCell";

@interface RootViewController ()<UITableViewDelegate>

@property (nonatomic, strong) TableViewDataSource * rootViewCellDataSource;

@end

@implementation RootViewController

CGRect scrollViewRect;

#pragma mark 初始化 init
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"有雅兴";
    }
    return self;
}

#pragma mark 加载完毕 View did load
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = false;
    [self.navigationController.navigationBar.layer insertSublayer:HCNCBackgroundForRootView atIndex:0];
    [self initView];
}

- (void)initView {
    scrollViewRect = CGRectMake(0, 0, ScreenSize.width, 240);
    
    _rootTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height) style:UITableViewStyleGrouped];
    TableViewCellConfigureBlock rootViewCellConfigureBlock = ^(RootViewCell* rootCell, NSDictionary* dic) {
        [rootCell configureCellWithDic:dic];
    };
    self.rootViewCellDataSource = [[TableViewDataSource alloc] initWithItems:@[@[@{@"title":@"第一次"}]]
                                                                 cellIdentifier:RootViewCellIdentifier
                                                                      cellBlock:rootViewCellConfigureBlock];
    
    _rootTableView.delegate = self;
    _rootTableView.dataSource = self.rootViewCellDataSource;
    
    _rootTableView.contentInset = UIEdgeInsetsMake(0, 0, 47, 0);
    _rootTableView.separatorInset = UIEdgeInsetsMake(0, 0, 47, 0);
    
    [_rootTableView registerNib:[RootViewCell nib] forCellReuseIdentifier:RootViewCellIdentifier];
    [self.view addSubview:_rootTableView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(search)];
    
}

#pragma TODO
- (void)search {
    NSLog(@"点击了搜索按钮");
}

#pragma mark- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    if (indexPath.section == 0) {
        [self.navigationController pushViewController:[GuessYouLikeViewController new] animated:true];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return scrollViewRect.size.height + 10;
    } else {
        return 10;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        
        UIScrollView * guessYouLikeScrollView = [[UIScrollView alloc] initWithFrame:scrollViewRect];
        guessYouLikeScrollView.contentSize = CGSizeMake(ScreenSize.width * 4, scrollViewRect.size.height);
        guessYouLikeScrollView.pagingEnabled = true;
        guessYouLikeScrollView.bounces = false;
        guessYouLikeScrollView.showsHorizontalScrollIndicator = false;
        guessYouLikeScrollView.delegate = self;
        
        for (int i = 0; i<4; i++) {
            UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"img%d.jpg", i + 1]];
            UIImageView * imageView = [[UIImageView alloc] initWithImage:image];
            imageView.frame = CGRectMake(ScreenSize.width * i, 0, ScreenSize.width, scrollViewRect.size.height);
            [guessYouLikeScrollView addSubview:imageView];
        }
        
        return guessYouLikeScrollView;
        
    } else {
        
        return [UIView new];
        
    }
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
