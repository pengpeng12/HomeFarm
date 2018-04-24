//
//  orderFooterView.m
//  ChatDemo-UI2.0
//
//  Created by 宋鹏鹏 on 15/12/15.
//  Copyright © 2015年 宋鹏鹏. All rights reserved.
//

#import "orderFooterView.h"

@implementation orderFooterView

+ (instancetype)footerWithTableView:(UITableView *)tableView
{
    static NSString *ID=@"footer";
    orderFooterView *footer=[tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (footer==nil) {
        footer=[[orderFooterView alloc]initWithReuseIdentifier:ID];
    }
    return footer;
}
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        //添加子控件
        _footLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:_footLabel];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _footLabel.frame = CGRectMake(0, footerH*0.4, kScreen_Width-17, 20);
    _footLabel.font = [UIFont systemFontOfSize:14];
    _footLabel.textColor = [UIColor blackColor];
    _footLabel.textAlignment = NSTextAlignmentRight;
    _footLabel.text = @"共1件商品  合计:￥70.00(含运费￥0.00)";
    
}
@end
