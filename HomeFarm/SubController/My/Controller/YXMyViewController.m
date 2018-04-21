//
//  YXMyViewController.m
//  YXCalendar
//
//  Created by 易信 on 2018/4/9.
//  Copyright © 2018年 易信. All rights reserved.
//

#import "YXMyViewController.h"
#import "MyCenterTopToolView.h"
#import "DCLoginViewController.h"
#import "MyCenterViewController.h"
#import "DCSettingViewController.h"

// Controllers
#import "DCReceivingAddressViewController.h" //收货地址
// Models

// Views
#import "DCUserMgCell.h"
// Vendors
#import "SVProgressHUD.h"

@interface YXMyViewController ()<UITableViewDelegate,UITableViewDataSource>

/* 顶部Nva */
@property (strong , nonatomic)MyCenterTopToolView *topToolView;

/* tableView */
@property (strong , nonatomic)UITableView *tableView;
/* 数组 */
@property (nonatomic, copy) NSArray *myItem;

@end

static NSString *const MyCellID = @"myCell";

@implementation YXMyViewController

#pragma mark - LazyLoad
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.frame = CGRectMake(0, DCTopNavH, kScreen_Width, kScreen_Height - DCTopNavH);
        [self.view addSubview:_tableView];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DCUserMgCell class]) bundle:nil] forCellReuseIdentifier:MyCellID];
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = DCBGColor;
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = self.view.backgroundColor;
    self.title = @"我的";
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSArray *titleArray = @[@"个人中心",@"地址管理",@"我的订单",@"清除缓存",@"关于我们",@"意见反馈"];
    NSArray *subTitleArray = @[@"",@"",@"",@"1.7M",@"",@""];
    self.myItem = [NSArray arrayWithObjects:titleArray,subTitleArray, nil];
    
    self.tableView.tableFooterView = [UIView new]; //去除多余分割线
    
    [self setUpNavTopView];
}
#pragma mark - 导航栏处理
- (void)setUpNavTopView
{
    _topToolView = [[MyCenterTopToolView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, DCTopNavH)];
    WEAKSELF
    
    _topToolView.rightItemClickBlock = ^{ //点击设置
        DCSettingViewController *dcSetVc = [DCSettingViewController new];
        [weakSelf.navigationController pushViewController:dcSetVc animated:YES];
    };
    
    [self.view addSubview:_topToolView];
    
}


#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = self.myItem.firstObject;
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DCUserMgCell *cell = [tableView dequeueReusableCellWithIdentifier:MyCellID forIndexPath:indexPath];
    cell.titleContent = _myItem.firstObject[indexPath.row];
    cell.subTitleContent = _myItem.lastObject[indexPath.row];
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        //个人中心
        MyCenterViewController *mycenterVc = [MyCenterViewController new];
        [self.navigationController pushViewController:mycenterVc animated:YES];
    }else if (indexPath.row == 1){
        //地址管理
        DCReceivingAddressViewController *dcRaVc = [DCReceivingAddressViewController new];
        [self.navigationController pushViewController:dcRaVc animated:YES];
    }else if (indexPath.row == 2){
        //我的订单
        
    }else if (indexPath.row == 3){
        //清除缓存
    }else if (indexPath.row == 4){
        //关于我们
    }else if (indexPath.row == 5){
        //意见反馈
       
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
