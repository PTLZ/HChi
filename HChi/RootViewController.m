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
#import "RootViewCollectionViewCell.h"
#import "CollectionViewLayout.h"
#import "ClassificationViewController.h"

static NSString * const RootViewCellIdentifier = @"RootCell";

@interface RootViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, CollectionViewFlowLayoutProtocol>

@property (nonatomic, strong) TableViewDataSource * rootViewCellDataSource;

@end

@implementation RootViewController

/// 每日推荐 scroll View
UIScrollView * _dailyRecommendScrollView;
/// scrollView 的位置信息
CGRect _scrollViewRect;
/// scrollView 的内容: UIImageView
NSMutableArray * _dailyRecommendScrollViewContents;
/// scrollView 当前显示的Image
UIImageView * _cureentImage;
/// 搜索框
UISearchBar * _searchBar;
/// 搜索框位置信息
CGRect _searchBarRect;
/// 用于判断tableView向上还是向下滑动
CGFloat _rootViewOldOffset = 0;

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
    [UIView animateWithDuration:0.5 animations:^{
        CGRect rect = HCNCTabBarView.frame;
        rect.origin.y = ScreenSize.height - 49;
        HCNCTabBarView.frame = rect;
    }];
}

#pragma mark 初始化视图: 给视图添加内容
- (void)initView {
    // 初始化每日推荐的内容
    _dailyRecommendScrollViewContents = [NSMutableArray new];
    // 定义每日推荐的位置信息
    _scrollViewRect = CGRectMake(0, 0, ScreenSize.width, 280);
    
    #pragma mark 设置导航栏右边的按钮为分类按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(calassification)];
    
    #pragma mark 创建CollectionView: 根视图
    _rootCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height) collectionViewLayout:[UICollectionViewFlowLayout new]];
    _rootCollectionView.delegate = self;
    _rootCollectionView.dataSource = self;
    
    CollectionViewLayout * layout = [CollectionViewLayout new];
    layout.delegate = self;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 0.5;
    
    _rootCollectionView.collectionViewLayout = layout;
    // 内容滚动范围
    _rootCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 49 + 10, 0);
    // 右侧滑动条滚动范围
    _rootCollectionView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 49, 0);
    // 设置collectionView 总是可以上下滑动
    _rootCollectionView.alwaysBounceVertical = true;
    // 隐藏右侧滚动条
    _rootCollectionView.showsVerticalScrollIndicator = false;
    _rootCollectionView.backgroundColor = [UIColor redColor];
    
    _rootCollectionView.contentSize = CGSizeMake(ScreenSize.width, ScreenSize.height*2);
    [_rootCollectionView registerClass:[RootViewCollectionViewCell class] forCellWithReuseIdentifier:RootViewCellIdentifier];
    [self.view addSubview:_rootCollectionView];
    
    #pragma mark 添加ScrollView: 每日推荐
    _dailyRecommendScrollView = [[UIScrollView alloc] initWithFrame:_scrollViewRect];
    _dailyRecommendScrollView.contentSize = CGSizeMake(ScreenSize.width * 4, _scrollViewRect.size.height);
    _dailyRecommendScrollView.pagingEnabled = true;
    _dailyRecommendScrollView.bounces = false;
    _dailyRecommendScrollView.showsHorizontalScrollIndicator = false;
    _dailyRecommendScrollView.delegate = self;
    
    for (int i = 0; i<3; i++) {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"img%d.jpg", i + 1]];
        UIImageView * imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(ScreenSize.width * i, 0, ScreenSize.width, _scrollViewRect.size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = true;
        [_dailyRecommendScrollView addSubview:imageView];
        [_dailyRecommendScrollViewContents addObject:imageView];
    }
    UIImageView * imageView = (UIImageView *)_dailyRecommendScrollViewContents[0];
    imageView.image =[UIImage imageNamed:@"img1.jpg"];
    imageView.frame = CGRectMake(ScreenSize.width * 3, 0, ScreenSize.width, _scrollViewRect.size.height);
    [_dailyRecommendScrollView addSubview:imageView];
    [_dailyRecommendScrollViewContents addObject:imageView];
    [self.view addSubview:_dailyRecommendScrollView];
    
    
    #pragma mark 添加搜索框
    CGSize searchBarSize = CGSizeMake(ScreenSize.width - 40, 40);
    _searchBarRect = CGRectMake((ScreenSize.width - searchBarSize.width) / 2, _scrollViewRect.size.height - searchBarSize.height - 10, searchBarSize.width, searchBarSize.height);
    _searchBar = [[UISearchBar alloc] initWithFrame:_searchBarRect];
    _searchBar.searchBarStyle = UISearchBarStyleMinimal;
    _searchBar.translucent = false;
    _searchBar.barTintColor = HCColorForTheme;
    
    // 遍历searchBar 中的子视图
    for (UIView * subview in [[_searchBar.subviews lastObject] subviews]) {
        // 找到子视图中的 UITextField
        if ([subview isKindOfClass:[UITextField class]]) {
            UITextField * textField = (UITextField *)subview;
            textField.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
            textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索菜谱、食材、季节等" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
        } else if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [subview removeFromSuperview];
        }
    }
    
    [self.view addSubview:_searchBar];
}

#pragma TODO
- (void)calassification {
    NSLog(@"点击了分类按钮");
    HCShowTabBarView(false);
    [self.navigationController presentViewController:[ClassificationViewController new] animated:true completion:nil];
}

#pragma mark- UICollectionViewDataSource
#pragma mark 返回节
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
#pragma mark 返回行
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}
#pragma mark 渲染cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RootViewCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:RootViewCellIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor lightTextColor];
    
    [cell rootViewCellShowAnimate];
    return cell;
}


#pragma mark- UIScrollViewDelegate
#pragma mark 滚动停止后触发
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // scrollView 当前页面
    int cureentPage = (int)(_dailyRecommendScrollView.contentOffset.x / ScreenSize.width);
    _cureentImage = [self backScrollViewContent:cureentPage];
    
    if (cureentPage >= 3) {
        _dailyRecommendScrollView.contentOffset = CGPointMake(0, 0);
    }
    
}

#pragma mark 边滚动边触发
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat y = _rootCollectionView.contentOffset.y;
    // 改变位置信息
    [self resetHeadViewFrame:y];
    
    
    // 改变导航栏
    /*
    if (y > scrollViewRect.size.height - 64) {
        UIColor * color = (UIColor *)HCNCBackgroundForRootView.backgroundColor;
        color = [color colorWithAlphaComponent:1.0];
        HCNCBackgroundForRootView.backgroundColor = color.CGColor;
    }
     */
}
- (UIImageView *)backScrollViewContent:(int)index {
    return _dailyRecommendScrollViewContents[index];
}
#pragma mark 滑动时改变位置信息
- (void)resetHeadViewFrame:(CGFloat)y {
    
    if (_cureentImage == nil) {
        _cureentImage = [self backScrollViewContent:0];
    }
    //
    CGRect frame = _dailyRecommendScrollView.frame;
    CGRect cureentImageFrame = _cureentImage.frame;
    CGRect searchBarFrame = _searchBar.frame;
    if (y < 0) {
        frame.origin.y = 0;
        frame.size.height = _scrollViewRect.size.height - y;
        _dailyRecommendScrollView.frame = frame;
        
        cureentImageFrame.origin.y = 0;
        cureentImageFrame.size.height = frame.size.height;
        _cureentImage.frame = cureentImageFrame;
        
        searchBarFrame.origin.y = _searchBarRect.origin.y + -y;
        _searchBar.frame = searchBarFrame;
        
    } else if (y > _scrollViewRect.size.height - 64) {
        
        frame.origin.y = -y;
        _dailyRecommendScrollView.frame = frame;
        
        searchBarFrame.origin.y = _searchBarRect.origin.y + -y;
        _searchBar.frame = searchBarFrame;
        
    } else {
        
        frame.origin.y = -y;
        _dailyRecommendScrollView.frame = frame;
        
        searchBarFrame.origin.y = _searchBarRect.origin.y + -y;
        _searchBar.frame = searchBarFrame;
    }
    
    
    if (y > _rootViewOldOffset && y > 0) {
        RootViewCellShowingAnimate = true;
    } else {
        RootViewCellShowingAnimate = false;
    }
    
    _rootViewOldOffset = y;
}


#pragma mark- 自定义协议方法实现CollectionViewFlowLayoutProtocol
- (CGSize)reWithIndexPath:(NSIndexPath *)indexPath {
    
    long int oddNumber = indexPath.row;
    if (oddNumber == 0) {
        return CGSizeMake(ScreenSize.width, _scrollViewRect.size.height);
    } else if (oddNumber == 1) {
        return CGSizeMake(ScreenSize.width, 80);
    } else if (oddNumber == 2) {
        return CGSizeMake(ScreenSize.width, 20);
    } else if (oddNumber >=3 && oddNumber < 18){
        return CGSizeMake(ScreenSize.width / 5, 34);
    } else {
        return CGSizeMake(ScreenSize.width, 60);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
