//
//  ClassificationViewController.m
//  HChi
//
//  Created by uniQue on 16/1/14.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "ClassificationViewController.h"
#import "HCGlobalVariable.h"
#import "TableViewDataSource.h"
#import "ClassificationTableViewCell.h"
#import "ClassificationCollectionViewCell.h"

static NSString * const ClassificationTableViewCellIdentifier = @"ClassificationTableViewCell";
static NSString * const ClassificationCollectionViewCellIdentifier = @"ClassificationCollectionViewCell";

@interface ClassificationViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UITableView * classificationTableView;
@property (nonatomic, strong) UICollectionView * classificationCollectionView;
@property (nonatomic, strong) TableViewDataSource * cTableViewDataSource;

@end

@implementation ClassificationViewController

NSArray * _collectionViewCellDataArray;
/// 用于判断tableView向上还是向下滑动
CGFloat _classificationViewOldOffset = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self initView];
}

- (void)initView {
    _collectionViewCellDataArray = [NSArray new];
    
#pragma mark 创建navView(UIView)
    UIView * navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 64)];
    navView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4];

    UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView * effectView = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectView.frame = navView.frame;

    [self.view addSubview:effectView];
    [self.view addSubview:navView];
    
#pragma mark 创建navView中的内容 返回按钮
    UIButton * backButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenSize.width - 60 - 5, 44/2 + 20 - 10, 60, 20)];
    [backButton setTitleColor:HCColorForTheme forState:UIControlStateNormal];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:HCThemeFontSize];
    [backButton addTarget:self action:@selector(backViewController) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:backButton];
    
#pragma mark 创建搜索框
#pragma mark 创建tableView
    CGRect cTableViewRect = CGRectMake(0, 64, ScreenSize.width / 4, ScreenSize.height);
    _classificationTableView = [[UITableView alloc] initWithFrame:cTableViewRect style:UITableViewStylePlain];
    
    NSString * path = [[NSBundle mainBundle] pathForResource:@"Classification" ofType:@"plist"];
    _cellConfigureData = [[NSArray alloc] initWithContentsOfFile:path];
    
    _classificationTableView.tableFooterView = [UIView new];
    _classificationTableView.delegate = self;
    _classificationTableView.dataSource = self;
    _classificationTableView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
    _classificationTableView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    [_classificationTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:true scrollPosition:UITableViewScrollPositionNone];
    [self reloadCollectionView:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    [_classificationTableView registerClass:[ClassificationTableViewCell class] forCellReuseIdentifier:ClassificationTableViewCellIdentifier];
    [self.view insertSubview:_classificationTableView atIndex:0];
    
#pragma mark 创建CollectionView
    _classificationCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(ScreenSize.width/4, 0, ScreenSize.width/4*3, ScreenSize.height) collectionViewLayout:[UICollectionViewFlowLayout new]];
    UICollectionViewFlowLayout * layout = [UICollectionViewFlowLayout new];
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    
    _classificationCollectionView.collectionViewLayout = layout;
    
    _classificationCollectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _classificationCollectionView.delegate = self;
    _classificationCollectionView.dataSource = self;
    _classificationCollectionView.showsVerticalScrollIndicator = false;
    _classificationCollectionView.alwaysBounceVertical = true;
    _classificationCollectionView.contentInset = UIEdgeInsetsMake(64, 10, 10, 10);
    
    [_classificationCollectionView registerClass:[ClassificationCollectionViewCell class] forCellWithReuseIdentifier:ClassificationCollectionViewCellIdentifier];
    [self.view insertSubview:_classificationCollectionView atIndex:0];
}
- (void)backViewController {
    [self dismissViewControllerAnimated:true completion:nil];
}

#pragma mark- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellConfigureData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ClassificationTableViewCell*  cell = [tableView dequeueReusableCellWithIdentifier:ClassificationTableViewCellIdentifier];
    NSArray * array = _cellConfigureData[indexPath.row];
    NSDictionary * dic = array[0];
    [cell configureCellTitleWithDic:dic];
    return cell;
}

#pragma mark- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self reloadCollectionView:indexPath];
}

- (void) reloadCollectionView:(NSIndexPath *)indexPath {
    NSArray * array = _cellConfigureData[indexPath.row];
    NSArray * dataArray = array[1];
    _collectionViewCellDataArray = dataArray;
    [_classificationCollectionView reloadData];
}

#pragma mark- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _collectionViewCellDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ClassificationCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ClassificationCollectionViewCellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = _collectionViewCellDataArray[indexPath.row];
    
    [cell classificationVieCellShowAnimate];
    
    return cell;
}

#pragma mark- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:true];
    ClassificationCollectionViewCell * cell = (ClassificationCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * fontAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:HCThemeFontSize]};
    NSString * text = _collectionViewCellDataArray[indexPath.row];
    CGSize textSize = [text sizeWithAttributes:fontAttributes];
    return CGSizeMake(textSize.width + 10, 44);
}


#pragma mark 边滚动边触发
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat y = _classificationCollectionView.contentOffset.y;
    
    if (y > _classificationViewOldOffset && y > 0) {
        ClassificationViewCellShowAnimate = true;
    } else {
        ClassificationViewCellShowAnimate = false;
    }
    
    _classificationViewOldOffset = y;
    // 改变导航栏
    /*
     if (y > scrollViewRect.size.height - 64) {
     UIColor * color = (UIColor *)HCNCBackgroundForRootView.backgroundColor;
     color = [color colorWithAlphaComponent:1.0];
     HCNCBackgroundForRootView.backgroundColor = color.CGColor;
     }
     */
}


- (void)viewWillDisappear:(BOOL)animated {
    HCShowTabBarView(true);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
