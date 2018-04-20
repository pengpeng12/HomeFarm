//
//  YXMyViewController.m
//  YXCalendar
//
//  Created by 易信 on 2018/4/9.
//  Copyright © 2018年 易信. All rights reserved.
//

#import "YXMyViewController.h"
#import "DCLoginViewController.h"
#import "DCCenterTopToolView.h"
#import "DCSettingViewController.h"

@interface YXMyViewController ()

/* 顶部Nva */
@property (strong , nonatomic)DCCenterTopToolView *topToolView;
@end

@implementation YXMyViewController

#pragma mark - 导航栏处理

- (void)setUpNavTopView
{
    _topToolView = [[DCCenterTopToolView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, DCTopNavH)];
    WEAKSELF
    _topToolView.leftItemClickBlock = ^{ //点击了扫描
        
    };
    _topToolView.rightItemClickBlock = ^{ //点击设置
        DCSettingViewController *dcSetVc = [DCSettingViewController new];
        [weakSelf.navigationController pushViewController:dcSetVc animated:YES];
    };
    
    [self.view addSubview:_topToolView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    self.title = @"我的";
    self.navigationController.navigationBar.hidden = YES;
    [self setUpNavTopView];
    
//    if (![[DCObjManager dc_readUserDataForKey:@"isLogin"] isEqualToString:@"1"]) {
//
//        DCLoginViewController *dcLoginVc = [DCLoginViewController new];
//        [self.navigationController pushViewController:dcLoginVc animated:YES];
//    }
    
    
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
