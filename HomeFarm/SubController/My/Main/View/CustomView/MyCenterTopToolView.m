//
//  MyCenterTopToolView.m
//  HomeFarm
//
//  Created by 易信 on 2018/4/21.
//  Copyright © 2018年 北京易信科技. All rights reserved.
//

#import "MyCenterTopToolView.h"

@interface MyCenterTopToolView()
/* 右边Item */
@property (strong , nonatomic)UIButton *rightItemButton;
@end

@implementation MyCenterTopToolView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}


- (void)setUpUI
{
    self.backgroundColor = [UIColor clearColor];

    _rightItemButton = ({
        UIButton * button = [UIButton new];
        [button setImage:[UIImage imageNamed:@"setting_black"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(rightButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self addSubview:_rightItemButton];
    UILabel *titleLable =  [[UILabel alloc]initWithFrame:CGRectMake((kScreen_Width-100)*0.5, kStatusBar_Height+10, 100, 21)];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.textColor = [UIColor blackColor];
    titleLable.font = [UIFont systemFontOfSize:18];
    titleLable.text = @"我的";
    [self addSubview:titleLable];
    
    CGFloat lineH = 1.0/[UIScreen mainScreen].scale;
    UILabel *Line =  [[UILabel alloc]initWithFrame:CGRectMake(0, self.height-lineH, kScreen_Width, lineH)];
    Line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:Line];
//    CAGradientLayer * layer = [[CAGradientLayer alloc] init];
//    layer.frame = self.bounds;
//    layer.colors = @[(id)[UIColor colorWithWhite:0 alpha:0.2].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.15].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.1].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.05].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.03].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.01].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.0].CGColor];
//    [self.layer addSublayer:layer];
}
#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_rightItemButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_top).offset(kStatusBar_Height+20);
        make.right.equalTo(self.mas_right).offset(-5);
        make.height.equalTo(@44);
        make.width.equalTo(@44);
    }];
    
}

#pragma 自定义右边导航Item点击
- (void)rightButtonItemClick {
    !_rightItemClickBlock ? : _rightItemClickBlock();
}


@end
