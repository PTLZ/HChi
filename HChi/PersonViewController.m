//
//  PersonViewController.m
//  HChi
//
//  Created by uniQue on 16/1/11.
//  Copyright © 2016年 uniQue. All rights reserved.
//

#import "PersonViewController.h"
#import "HCGlobalVariable.h"
#import "TableViewDataSource.h"
#import "PersonViewCell.h"

static NSString * const PersonViewCellIdentifier = @"PersonCell";

@interface PersonViewController ()<UITableViewDelegate>

@property (nonatomic, strong) TableViewDataSource * personViewCellDataSource;

@end


@implementation PersonViewController

CGRect headViewRect;
/// 头部视图
UIView * headView;
/// 模糊背景图
UIImageView * imageView;
/// 模糊效果
UIVisualEffectView * effectView;
/// 用户头像
UIImageView * userHeadImage;
/// 用户昵称
UILabel * userNickName;


#pragma mark 初始化 init
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"个人";
    }
    return self;
}
#pragma mark 加载完毕 View did load
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = false;
    
    [self initView];
    [self createHeadView];
}

#pragma mark 创建头部视图
- (void)createHeadView {
    
    headView = [[UIView alloc] initWithFrame:headViewRect];
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img1.jpg"]];
    imageView.frame = headViewRect;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [self.view addSubview:headView];
    
    // 添加模糊效果. dark暗系风格, light 亮系风格, extra light 附加额外的亮光
    UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    effectView = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectView.frame = headViewRect;
    [imageView addSubview:effectView];
    [headView addSubview:imageView];
    
    // 用户头像
    userHeadImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img1.jpg"]];
    CGSize userHeadImageSize = CGSizeMake(80, 80);
    userHeadImage.frame = CGRectMake(ScreenSize.width / 2 - userHeadImageSize.width / 2, headView.frame.size.height - userHeadImageSize.height - 50, userHeadImageSize.width, userHeadImageSize.height);
    userHeadImage.layer.cornerRadius = userHeadImageSize.width/2;
    userHeadImage.layer.masksToBounds = true;
    [effectView addSubview:userHeadImage];
    
    // 用户昵称
    CGSize userNickNameSize = CGSizeMake(ScreenSize.width / 2, 21);
    userNickName = [[UILabel alloc] initWithFrame:CGRectMake(ScreenSize.width / 2 - userNickNameSize.width / 2, userHeadImage.frame.origin.y + userHeadImage.frame.size.height + 10, userNickNameSize.width, userNickNameSize.height)];
    userNickName.textAlignment = NSTextAlignmentCenter;
    userNickName.font = [UIFont systemFontOfSize:14];
    userNickName.textColor = [UIColor whiteColor];
    userNickName.text = @"菩提老祖";
    [effectView addSubview:userNickName];
}

#pragma mark 视图将要出现 view will appear
- (void)viewWillAppear:(BOOL)animated {
    
}

#pragma mark 初始化view
- (void)initView {
    
    headViewRect = CGRectMake(0, 0, ScreenSize.width, 200);
    
    #pragma mark 设置列表信息
    _personTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height) style:UITableViewStyleGrouped];
    
    TableViewCellConfigureBlock personViewCellConfigureBlock = ^(PersonViewCell * personCell, NSDictionary * dic){
        [personCell configureCellWithDic:dic];
    };
    
    self.personViewCellDataSource = [[TableViewDataSource alloc] initWithItems:@[@[@{@"title":@"nickName"}]]
                                                                cellIdentifier:PersonViewCellIdentifier
                                                                     cellBlock:personViewCellConfigureBlock];
    
    _personTableView.delegate = self;
    _personTableView.dataSource = self.personViewCellDataSource;
    
    [_personTableView registerClass:[PersonViewCell class] forCellReuseIdentifier:PersonViewCellIdentifier];
    
    [self.view addSubview:_personTableView];
    
    #pragma mark 设置导航栏左右button
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(settingsWithRightBarButton)];
}

- (void)settingsWithRightBarButton {
    NSLog(@"点击了设置");
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}


//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    if (section == 0) {
//        return [self createHeadView];
//    }
//    return [UIView new];
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return headViewRect.size.height + 20;
    }
    return 10;
}


#pragma mark- UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat y = _personTableView.contentOffset.y;
    if (y < 0) {
        [self resetHeadViewFrame:y];
    } else {
        CGRect frame = imageView.frame;
        frame.origin.y = -y;
        imageView.frame = frame;
    }
}

- (void)resetHeadViewFrame:(CGFloat)y {
    CGRect frame = imageView.frame;
    frame.origin.y = 0;
    frame.size.height = headViewRect.size.height + -y;
    effectView.frame = frame;
    imageView.frame = frame;
    
    userHeadImage.frame = CGRectMake(ScreenSize.width / 2 - userHeadImage.frame.size.width / 2, frame.size.height - 80 - 50, 80, 80);
    userNickName.frame = CGRectMake(ScreenSize.width / 2 - userNickName.frame.size.width / 2, userHeadImage.center.y + userHeadImage.frame.size.height / 2 + 10, userNickName.frame.size.width, userNickName.frame.size.height);
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
