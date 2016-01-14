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
#import "CollectionViewLayout.h"
#import "RootViewCollectionViewCell.h"

static NSString * const RootViewCellIdentifier = @"RootCell";

@interface RootViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, CollectionViewFlowLayoutProtocol>

@property (nonatomic, strong) TableViewDataSource * rootViewCellDataSource;

@end

@implementation RootViewController

/// 每日推荐 scroll View
UIScrollView * dailyRecommendScrollView;
/// scrollView 的位置信息
CGRect scrollViewRect;
/// scrollView 的内容: UIImageView
NSMutableArray * dailyRecommendScrollViewContents;
/// scrollView 当前显示的Image
UIImageView * cureentImage;
/// 搜索框
UISearchBar * searchBar;
/// 搜索框位置信息
CGRect searchBarRect;

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

#pragma mark 初始化视图: 给视图添加内容
- (void)initView {
    // 初始化每日推荐的内容
    dailyRecommendScrollViewContents = [NSMutableArray new];
    // 定义每日推荐的位置信息
    scrollViewRect = CGRectMake(0, 0, ScreenSize.width, 280);
    
//    _rootTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height) style:UITableViewStyleGrouped];
//    TableViewCellConfigureBlock rootViewCellConfigureBlock = ^(RootViewCell* rootCell, NSDictionary* dic) {
//        [rootCell configureCellWithDic:dic];
//    };
//    self.rootViewCellDataSource = [[TableViewDataSource alloc] initWithItems:@[@[@{@"title":@"第一次"}]]
//                                                                 cellIdentifier:RootViewCellIdentifier
//                                                                      cellBlock:rootViewCellConfigureBlock];
//    
//    _rootTableView.delegate = self;
//    _rootTableView.dataSource = self.rootViewCellDataSource;
//    
//    _rootTableView.contentInset = UIEdgeInsetsMake(0, 0, 47, 0);
//    _rootTableView.separatorInset = UIEdgeInsetsMake(0, 0, 47, 0);
//    
//    [_rootTableView registerNib:[RootViewCell nib] forCellReuseIdentifier:RootViewCellIdentifier];
//    [self.view addSubview:_rootTableView];
    
    // 设置导航栏右边的按钮为搜索按钮🔍
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(search)];
    
    
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
    _rootCollectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    _rootCollectionView.contentSize = CGSizeMake(ScreenSize.width, ScreenSize.height*2);
    [_rootCollectionView registerClass:[RootViewCollectionViewCell class] forCellWithReuseIdentifier:RootViewCellIdentifier];
    [self.view addSubview:_rootCollectionView];
    
    #pragma mark 添加ScrollView: 每日推荐
    dailyRecommendScrollView = [[UIScrollView alloc] initWithFrame:scrollViewRect];
    dailyRecommendScrollView.contentSize = CGSizeMake(ScreenSize.width * 4, scrollViewRect.size.height);
    dailyRecommendScrollView.pagingEnabled = true;
    dailyRecommendScrollView.bounces = false;
    dailyRecommendScrollView.showsHorizontalScrollIndicator = false;
    dailyRecommendScrollView.delegate = self;
    
    for (int i = 0; i<4; i++) {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"img%d.jpg", i + 1]];
        UIImageView * imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(ScreenSize.width * i, 0, ScreenSize.width, scrollViewRect.size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = true;
        [dailyRecommendScrollView addSubview:imageView];
        [dailyRecommendScrollViewContents addObject:imageView];
    }
    [self.view addSubview:dailyRecommendScrollView];
    
    
    #pragma mark 添加搜索框
    CGSize searchBarSize = CGSizeMake(ScreenSize.width - 40, 40);
    searchBarRect = CGRectMake((ScreenSize.width - searchBarSize.width) / 2, scrollViewRect.size.height - searchBarSize.height - 10, searchBarSize.width, searchBarSize.height);
    searchBar = [[UISearchBar alloc] initWithFrame:searchBarRect];
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
//    searchBar.placeholder = @"搜索菜谱、食材、季节等";
    searchBar.translucent = false;
//    searchBar.tintColor = HCColorForTheme;
    searchBar.barTintColor = HCColorForTheme;
    
    // 遍历searchBar 中的子视图
    for (UIView * subview in [[searchBar.subviews lastObject] subviews]) {
        // 找到子视图中的 UITextField
        if ([subview isKindOfClass:[UITextField class]]) {
            UITextField * textField = (UITextField *)subview;
            textField.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
//            textField.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
//            textField.layer.borderColor = [[UIColor lightTextColor] colorWithAlphaComponent:0.5].CGColor;
//            textField.layer.borderWidth = 1;
//            textField.layer.cornerRadius = 5;
            textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索菜谱、食材、季节等" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
        } else if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [subview removeFromSuperview];
        }
    }
    
    [self.view addSubview:searchBar];
}

#pragma TODO
- (void)search {
    NSLog(@"点击了搜索按钮");
}

#pragma mark- UICollectionViewDataSource
#pragma mark 返回节
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
#pragma mark 返回行
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 50;
}
#pragma mark 渲染cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:RootViewCellIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor lightTextColor];
    return cell;
}


#pragma mark- UIScrollViewDelegate
#pragma mark 滚动停止后触发
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // scrollView 当前页面
    int cureentPage = (int)(dailyRecommendScrollView.contentOffset.x / ScreenSize.width);
    cureentImage = [self backScrollViewContent:cureentPage];
}

#pragma mark 边滚动边触发
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat y = _rootCollectionView.contentOffset.y;
    // 改变位置信息
    [self resetHeadViewFrame:y];
    /*
    // 改变导航栏
    if (y > scrollViewRect.size.height - 64) {
        UIColor * color = (UIColor *)HCNCBackgroundForRootView.backgroundColor;
        color = [color colorWithAlphaComponent:1.0];
        HCNCBackgroundForRootView.backgroundColor = color.CGColor;
    }
     */
}
- (UIImageView *)backScrollViewContent:(int)index {
    return dailyRecommendScrollViewContents[index];
}
#pragma mark 滑动时改变位置信息
- (void)resetHeadViewFrame:(CGFloat)y {
    
    if (cureentImage == nil) {
        cureentImage = [self backScrollViewContent:0];
    }
    //
    CGRect frame = dailyRecommendScrollView.frame;
    CGRect cureentImageFrame = cureentImage.frame;
    CGRect searchBarFrame = searchBar.frame;
    if (y < 0) {
        frame.origin.y = 0;
        frame.size.height = scrollViewRect.size.height - y;
        dailyRecommendScrollView.frame = frame;
        
        cureentImageFrame.origin.y = 0;
        cureentImageFrame.size.height = frame.size.height;
        cureentImage.frame = cureentImageFrame;
        
        searchBarFrame.origin.y = searchBarRect.origin.y + -y;
        searchBar.frame = searchBarFrame;
        
    } else if (y > scrollViewRect.size.height - 64) {
        
//        self.navigationController.navigationBar.hidden = true;
        frame.origin.y = -y;
        dailyRecommendScrollView.frame = frame;
        
        searchBarFrame.origin.y = searchBarRect.origin.y + -y;
        searchBar.frame = searchBarFrame;
    } else {
//        self.navigationController.navigationBar.hidden = false;
        frame.origin.y = -y;
        dailyRecommendScrollView.frame = frame;
        
        searchBarFrame.origin.y = searchBarRect.origin.y + -y;
        searchBar.frame = searchBarFrame;
    }
}


#pragma mark- 自定义协议方法实现CollectionViewFlowLayoutProtocol
- (CGSize)reWithIndexPath:(NSIndexPath *)indexPath {
    
    long int oddNumber = indexPath.row;
    if (oddNumber == 0) {
        return CGSizeMake(ScreenSize.width, scrollViewRect.size.height);
    } else if (oddNumber == 1) {
        return CGSizeMake(ScreenSize.width, 60);
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
