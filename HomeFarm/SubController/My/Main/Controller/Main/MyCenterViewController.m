//
//  MyCenterViewController.m
//  HomeFarm
//
//  Created by 易信 on 2018/4/21.
//  Copyright © 2018年 北京易信科技. All rights reserved.
//

#import "MyCenterViewController.h"
#import "DCUserMgCell.h"

@interface MyCenterViewController ()<UITableViewDelegate,UITableViewDataSource>

/* tableView */
@property (strong , nonatomic)UITableView *tableView;
/* 数组 */
@property (nonatomic, copy) NSArray *myCenterItem;

@end

static NSString *const MyCenterCellID = @"myCenterCell";

@implementation MyCenterViewController

#pragma mark - LazyLoad
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.frame = CGRectMake(0, 0, kScreen_Width, kScreen_Height - DCTopNavH);
        [self.view addSubview:_tableView];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DCUserMgCell class]) bundle:nil] forCellReuseIdentifier:MyCenterCellID];
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = DCBGColor;
    self.tableView.backgroundColor = self.view.backgroundColor;
    self.title = @"个人中心";
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSArray *titleArray = @[@"头像",@"昵称",@"性别",@"出生日期",@"绑定手机号"];
    NSArray *subTitleArray = @[@"",@"克拉夫斯基",@"保密",@"",@""];
    self.myCenterItem = [NSArray arrayWithObjects:titleArray,subTitleArray, nil];
    
    UIView *footerView = [UIView new];
    footerView.height = 80;
    self.tableView.tableFooterView = footerView;
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = self.myCenterItem.firstObject;
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DCUserMgCell *cell = [tableView dequeueReusableCellWithIdentifier:MyCenterCellID forIndexPath:indexPath];
    cell.titleContent = _myCenterItem.firstObject[indexPath.row];
    cell.subTitleContent = _myCenterItem.lastObject[indexPath.row];
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        //头像
    }else if (indexPath.row == 1){
        //昵称
        
    }else if (indexPath.row == 2){
        //性别
    }else if (indexPath.row == 3){
        //出身日期
    }else if (indexPath.row == 4){
        //绑定手机号
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
