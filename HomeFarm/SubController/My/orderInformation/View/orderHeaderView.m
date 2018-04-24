//
//  orderHeaderView.m
//  ChatDemo-UI2.0
//
//  Created by 宋鹏鹏 on 15/12/15.
//  Copyright © 2015年 宋鹏鹏. All rights reserved.
//

#import "orderHeaderView.h"

@implementation orderHeaderView

+ (instancetype)headerWithTableView:(UITableView *)tableView
{
    static NSString *ID=@"header";
    orderHeaderView *header=[tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header==nil) {
        header=[[orderHeaderView alloc]initWithReuseIdentifier:ID];
    }
    return header;
}
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        //添加子控件
        _topline = [[UILabel alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:_topline];
        _topLeftLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:_topLeftLabel];
        _topMiddleImage = [[UIImageView alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:_topMiddleImage];
        _topRightLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:_topRightLabel];
        
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
   //
    _topline.frame = CGRectMake(0, 0, kScreen_Width, 7);
    _topline.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gray_bg"]];
    
    _topLeftLabel.frame = CGRectMake(kScreen_Width*0.07, (headerH-21)*0.5+7, 108,  21);
    _topLeftLabel.text = @"商城";
    _topLeftLabel.font = [UIFont systemFontOfSize:16];
    _topLeftLabel.textColor = [UIColor blackColor];
    
    _topMiddleImage.frame = CGRectMake(_topLeftLabel.right-7,_topLeftLabel.top+_topLeftLabel.height*0.21 , _topLeftLabel.height*0.4, _topLeftLabel.height*0.5);
    _topMiddleImage.image = [UIImage imageNamed:@"black_right"];
    _topRightLabel.frame = CGRectMake(kScreen_Width - 100 , _topLeftLabel.top -2, 100, _topLeftLabel.height);
    _topRightLabel.font = [UIFont systemFontOfSize:15];
    _topRightLabel.textColor = [UIColor redColor];
    _topRightLabel.textAlignment = NSTextAlignmentCenter;
    _topRightLabel.text = @"已收货";
    
}

@end
