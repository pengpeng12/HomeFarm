//
//  YXHomeViewController.m
//  YXCalendar
//
//  Created by 易信 on 2018/4/9.
//  Copyright © 2018年 易信. All rights reserved.
//

#import "YXHomeViewController.h"
#import "SignTestViewController.h"


@interface YXHomeViewController ()

@end

@implementation YXHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"首页";
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    UIButton *rightBtn = [[UIButton alloc] init];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_pop"] forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] forState:UIControlStateHighlighted];
    [rightBtn addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    UIButton *leftBtn = [[UIButton alloc] init];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"compose_camerabutton_background"] forState:UIControlStateNormal];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"compose_camerabutton_background_highlighted"] forState:UIControlStateHighlighted];
    [leftBtn addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
}

- (void)rightAction
{
    SignTestViewController *signVc = [[SignTestViewController alloc]init];
    [self.navigationController pushViewController:signVc animated:YES];
}

- (void)leftAction
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
