//
//  YXFindViewController.m
//  YXCalendar
//
//  Created by 易信 on 2018/4/9.
//  Copyright © 2018年 易信. All rights reserved.
//

#import "YXFindViewController.h"
#import "YXSearchView.h"

@interface YXFindViewController ()

@end

@implementation YXFindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
//    self.title = @"发现";
    [self customNavItem];
}

#pragma mark - 定制导航条内容
- (void) customNavItem {
    YXSearchView *searchBar = [YXSearchView searchBar];
    searchBar.width = 375;
    searchBar.height = 30;
    self.navigationItem.titleView = searchBar;
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
