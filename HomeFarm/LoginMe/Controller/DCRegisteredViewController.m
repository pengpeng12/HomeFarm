//
//  DCRegisteredViewController.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/28.
//Copyright © 2017年 STO. All rights reserved.
//

#import "DCRegisteredViewController.h"
#import "AgreementViewController.h"

// Controllers

// Models

// Views
#import "DCVerificationView.h"
// Vendors

// Categories

// Others

@interface DCRegisteredViewController ()

/* 手机注册 */
@property (strong , nonatomic)DCVerificationView *verificationView;

@end

@implementation DCRegisteredViewController

#pragma mark - LazyLoad


#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpBase];
}

- (void)setUpBase
{
    self.view.backgroundColor = [UIColor whiteColor];
//    self.title = @"手机注册";
    //返回按钮
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(20, kStatusBar_Height + 10, 30, 30)];
    backButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [backButton setTitle:@"X" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [self.view addSubview:backButton];
    [backButton addTarget:self action:@selector(dissmissClick) forControlEvents:UIControlEventTouchUpInside];
    
    _verificationView = [DCVerificationView dc_viewFromXib];
    [_verificationView.loginButton setTitle:@"注册" forState:0];
    _verificationView.frame = CGRectMake(0, DCTopNavH + DCMargin, kScreen_Width, 400);
//    @"《用户协议》"
    UIImageView *agreeImage = [[UIImageView alloc]initWithFrame:CGRectMake(_verificationView.loginButton.left, _verificationView.loginButton.bottom + 5, 20, 20)];
    agreeImage.backgroundColor = [UIColor greenColor];
    [_verificationView addSubview:agreeImage];
    UIButton *agreeButton = [[UIButton alloc]initWithFrame:CGRectMake(agreeImage.right, agreeImage.top, 100, 20)];
    agreeButton.titleLabel.font = [UIFont systemFontOfSize:13];
    agreeButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    [agreeButton setTitle:@"《用户协议》" forState:UIControlStateNormal];
    [agreeButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [agreeButton setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [_verificationView addSubview:agreeButton];
    [agreeButton addTarget:self action:@selector(agreementClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_verificationView];
}
- (void)dissmissClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)agreementClick
{
    AgreementViewController *agreeVC = [[AgreementViewController alloc]init];
    [self presentViewController:agreeVC animated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
