//
//  FHTabBarController.m
//  HomeFarm
//
//  Created by 易信 on 2018/4/12.
//  Copyright © 2018年 北京易信科技. All rights reserved.
//

#import "FHTabBarController.h"
#import "FHNavigationController.h"

#import "YXHomeViewController.h"
#import "YXSortViewController.h"
#import "YXShopCartController.h"
#import "YXFindViewController.h"
#import "YXMyViewController.h"
@interface FHTabBarController ()

@end

@implementation FHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 设置子控制器
    YXHomeViewController *home = [[YXHomeViewController alloc]init];
    [self addChildViewController:home title:@"首页" image:@"tabbar_home" selImage:@"tabbar_home_selected"];
    
    YXSortViewController *messageCenter = [[YXSortViewController alloc] init];
    [self addChildViewController:messageCenter title:@"分类" image:@"tabbar_message_center" selImage:@"tabbar_message_center_selected"];
    
    YXFindViewController *discover = [[YXFindViewController alloc] init];
    [self addChildViewController:discover title:@"发现" image:@"tabbar_discover" selImage:@"tabbar_discover_selected"];
    
    YXShopCartController *shopcart = [[YXShopCartController alloc] init];
    [self addChildViewController:shopcart title:@"购物车" image:@"tabbar_compose_button" selImage:@"tabbar_compose_button_highlighted"];
    
    YXMyViewController *profile = [[YXMyViewController alloc] init];
    [self addChildViewController:profile title:@"我" image:@"tabbar_profile" selImage:@"tabbar_profile_selected"];
}

#pragma mark - 添加子控制器
-(void)addChildViewController:(UIViewController *)childVc  title:(NSString *)title image:(NSString *)image selImage:(NSString *)selImage {
    static NSInteger index = 0;
    //设置子控制器的TabBarButton属性
    childVc.tabBarItem.title = title;
    childVc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.tag = index;
    index++;
    //让子控制器包装一个导航控制器
    FHNavigationController *nav = [[FHNavigationController alloc]initWithRootViewController:childVc];
    [self addChildViewController:nav];
}

+ (void)initialize
{
    //设置未选中的TabBarItem的字体颜色、大小
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    //设置选中了的TabBarItem的字体颜色、大小
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectedAttrs[NSForegroundColorAttributeName] =  [UIColor orangeColor];
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSLog(@"点击的item:%ld title:%@", item.tag, item.title);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
