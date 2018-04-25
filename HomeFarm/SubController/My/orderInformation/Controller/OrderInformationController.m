//
//  OrderInformationController.m
//  ChatDemo-UI2.0
//
//  Created by apple  on 15/12/14.
//  Copyright © 2015年 apple . All rights reserved.
//

#import "OrderInformationController.h"
#import "orderInformationCell.h"
#import "orderGroup.h"
#import "orderHeaderView.h"
#import "orderFooterView.h"

#define segButtonW kScreen_Width/3
#define segButtonH 50
#define largeNumber 200000

@interface OrderInformationController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_segTitleArray;
    UIImageView *_redArticle;
    //订单数组
    NSArray *_groups;
}
@property (nonatomic,strong)UITableView *orderListTabView;
@end

@implementation OrderInformationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单信息";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gray_bg"]];
    //获取数据
    //[self requestListData];
    //
    [self loadSegement];
    //
    self.orderListTabView = [[UITableView alloc]initWithFrame:CGRectMake(0, segButtonH, kScreen_Width, kScreen_Height - 64 - segButtonH) style:UITableViewStyleGrouped];
    self.orderListTabView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gray_bg"]];
    self.orderListTabView.delegate = self;
    self.orderListTabView.dataSource = self;
    self.orderListTabView.rowHeight = cellHeight;
    self.orderListTabView.sectionHeaderHeight = headerH;
    self.orderListTabView.sectionFooterHeight = footerH;
    self.orderListTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.orderListTabView];
    [self.orderListTabView performSelector:@selector(reloadData) withObject:nil afterDelay:3];
}
- (void)loadSegement
{
    //添加控制button
    _segTitleArray = @[@"全部",@"待付款",@"待发货"];
    for (int i = 0; i< _segTitleArray.count; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(i*segButtonW, 0, segButtonW, segButtonH)];
        button.backgroundColor = [UIColor whiteColor];
        [button setTitle:_segTitleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:18];
        button.tag = i + largeNumber;
        [button addTarget:self action:@selector(segButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    //添加红色选中条
    _redArticle = [[UIImageView alloc]initWithFrame:CGRectMake(0 , segButtonH-3, segButtonW, 3)];
    //_redArticle.backgroundColor = RGB(221, 41, 97);
    _redArticle.backgroundColor = [UIColor redColor];
    [self.view addSubview:_redArticle];
    
}
//点击segmentButton
- (void)segButtonClick:(UIButton *)button
{
    long index = (button.tag - largeNumber);
    
    [UIView animateWithDuration:0.3 animations:^{
       self-> _redArticle.frame = CGRectMake( index * segButtonW, self->_redArticle.top, segButtonW, 3);
    }];

//        [_listTableView  reloadData];
    
}
- (void)requestListData
{

//    if ([code intValue] == 0 && dict) {
        NSDictionary *dict = nil;
        NSArray *arr = dict[@"data"];

        NSMutableArray *groupArray=[NSMutableArray array];
        for (NSDictionary *dict in arr) {
            orderGroup *group =[orderGroup GroupWithDict:dict];
            [groupArray addObject:group];
        }
        _groups = [NSArray arrayWithArray:groupArray];

//
//
//        // 刷新表格
//        [self.tableView reloadData];
//        
//        // 让刷新控件停止显示刷新状态
//        [self.tableView.footer endRefreshing];
//        
//        //判断没有更多数据时隐藏footer
//        if (statusArray.count <[[self.params objectForKey:@"limit"] intValue] && [[dict objectForKey:@"code"] intValue]==0) {
//            [self.tableView.footer noticeNoMoreData];
//            //提醒没有更多信息了
//        }
    
   
    
//    }else{
//        [self showHint:@"网络异常"];
//    }
}
#pragma mark - TableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建cell
    orderInformationCell *cell = [orderInformationCell cellWithTableView:tableView];
    
    //设置cell数据
    orderGroup *group = _groups[indexPath.section];
    cell.orderInfo = group.orderInfoArray[indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //return _groups.count;
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    orderGroup *group = _groups[section];
    //return group.orderInfoArray.count;
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return headerH;//自定义高度
}
 //段头／段尾
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    orderHeaderView *header =[orderHeaderView headerWithTableView:tableView];
    header.group = _groups[section];
    return header;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    orderFooterView *footer =[orderFooterView footerWithTableView:tableView];
    footer.group=_groups[section];
    return footer;
}
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//         
////        Person *person=[[Person alloc] init];
////        person=[self.servertableData objectAtIndex:indexPath.row];
//
//       // UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
//        
//    }
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
