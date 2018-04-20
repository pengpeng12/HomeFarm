//
//  FHTabBarController.m
//  HomeFarm
//
//  Created by 易信 on 2018/4/12.
//  Copyright © 2018年 北京易信科技. All rights reserved.
//

#import "FHTabBarController.h"
#import "FHNavigationController.h"
#import "DCLoginViewController.h"

#import "YXHomeViewController.h"
#import "DCHandPickViewController.h"
#import "YXSortViewController.h"
#import "YXShopCartController.h"
#import "YXFindViewController.h"
#import "YXMyViewController.h"
#import "CommodityViewController.h"

@interface FHTabBarController ()<UITabBarDelegate,UITabBarControllerDelegate>

@end

@implementation FHTabBarController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // 添加通知观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateBadgeValue) name:DCMESSAGECOUNTCHANGE object:nil];
    
    // 添加badgeView
//    [self addBadgeViewOnTabBarButtons];
    
    self.selectedViewController = [self.viewControllers objectAtIndex:0]; //默认选择商城index为0
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    // 设置子控制器
//    YXHomeViewController *home = [[YXHomeViewController alloc]init];
    DCHandPickViewController *home = [[DCHandPickViewController alloc]init];
    [self addChildViewController:home title:@"首页" image:@"tabbar_home" selImage:@"tabbar_home_selected"];
    
    YXSortViewController *dcComVc = [[YXSortViewController alloc] init];
//    DCCommodityViewController *dcComVc = [[DCCommodityViewController alloc]init];
    [self addChildViewController:dcComVc title:@"分类" image:@"tabbar_message_center" selImage:@"tabbar_message_center_selected"];
    
    YXFindViewController *discover = [[YXFindViewController alloc] init];
    [self addChildViewController:discover title:@"发现" image:@"tabbar_discover" selImage:@"tabbar_discover_selected"];
    
    YXShopCartController *shopcart = [[YXShopCartController alloc] init];
    [self addChildViewController:shopcart title:@"购物车" image:@"tabbar_discover" selImage:@"tabbar_discover_selected"];
    
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

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    if(viewController == [tabBarController.viewControllers objectAtIndex:4]){
        
        if (![[DCObjManager dc_readUserDataForKey:@"isLogin"] isEqualToString:@"1"]) {
            
            DCLoginViewController *dcLoginVc = [DCLoginViewController new];
            [self presentViewController:dcLoginVc animated:YES completion:nil];
            return NO;
        }
    }
    return YES;
}
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSLog(@"点击了第%ld个item", item.tag);
}

#pragma mark - <UITabBarControllerDelegate>
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    //点击tabBarItem动画
//    [self tabBarButtonClick:[self getTabBarButton]];
//    if ([self.childViewControllers.firstObject isEqual:viewController]) { //根据tabBar的内存地址找到美信发通知jump
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"jump" object:nil];
//    }
    
}

#pragma mark - 更新badgeView
- (void)updateBadgeValue
{
//    _beautyMsgVc.tabBarItem.badgeValue = [DCObjManager dc_readUserDataForKey:@"isLogin"];
}

#pragma mark - 添加所有badgeView
- (void)addBadgeViewOnTabBarButtons {
    
    // 设置初始的badegValue
//    _beautyMsgVc.tabBarItem.badgeValue = [DCObjManager dc_readUserDataForKey:@"isLogin"];
//
//    int i = 0;
//    for (UITabBarItem *item in self.tabBarItems) {
//
//        if (i == 0) {  // 只在美信上添加
//            [self addBadgeViewWithBadgeValue:item.badgeValue atIndex:i];
//            // 监听item的变化情况
//            [item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
//            _item = item;
//        }
//        i++;
//    }
}

- (void)addBadgeViewWithBadgeValue:(NSString *)badgeValue atIndex:(NSInteger)index {
    
//    DCTabBadgeView *badgeView = [DCTabBadgeView buttonWithType:UIButtonTypeCustom];
//
//    CGFloat tabBarButtonWidth = self.tabBar.dc_width / self.tabBarItems.count;
//
//    badgeView.dc_centerX = index * tabBarButtonWidth + 40;
//
//    badgeView.tag = index + 1;
//
//    badgeView.badgeValue = badgeValue;
//
//    [self.tabBar addSubview:badgeView];
}

#pragma mark - 只要监听的item的属性一有新值，就会调用该方法重新给属性赋值
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
//    for (UIView *subView in self.tabBar.subviews) {
//        if ([subView isKindOfClass:[DCTabBadgeView class]]) {
//            if (subView.tag == 1) {
//                DCTabBadgeView *badgeView = (DCTabBadgeView *)subView;
//                badgeView.badgeValue = _beautyMsgVc.tabBarItem.badgeValue;
//            }
//        }
//    }
    
}

#pragma mark - 移除通知
- (void)dealloc {
//    [_item removeObserver:self forKeyPath:@"badgeValue"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
