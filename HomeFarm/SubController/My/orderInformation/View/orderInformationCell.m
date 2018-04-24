//
//  orderInformationCell.m
//  ChatDemo-UI2.0
//
//  Created by apple  on 15/12/14.
//  Copyright © 2015年 apple . All rights reserved.
//

#import "orderInformationCell.h"

@implementation orderInformationCell
#pragma mark - 初始化
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"orderInformationCell";
    orderInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[orderInformationCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initSubViews];
        
        //self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"gray_bg"]];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

- (void)initSubViews
{
    //预览图
    _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_imgView];
    
    //商品名
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_titleLabel];
    //优惠价格
    _priceLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_priceLabel];
//    //价格
//    _prePriceLabel = [[UILabel alloc]initWithFrame:CGRectZero];
//    [self.contentView addSubview:_prePriceLabel];
    //line
//    _line = [[UILabel alloc]initWithFrame:CGRectZero];
//    [_prePriceLabel addSubview:_line];
    //数量
    _quantityLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_quantityLabel];
    
    //
//    _bottomView = [[UIView alloc]initWithFrame:CGRectZero];
//    [self.contentView addSubview:_bottomView];
//    //取消／删除
//    _bottomLeftButton = [[UIButton alloc]initWithFrame:CGRectZero];
//    [_bottomView addSubview:_bottomLeftButton];
//    //确认／评价
//    _bottomRightButton = [[UIButton alloc]initWithFrame:CGRectZero];
//    [_bottomView addSubview:_bottomRightButton];
    
    //交易状态
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //预览图
    _imgView.frame = CGRectMake(10, 7, imageWH, imageWH);
    _imgView.image = [UIImage imageNamed:@"shop_item1"];
    
    //商品名
    _titleLabel.frame = CGRectMake(_imgView.right + 10, _imgView.top, kScreen_Width*0.4, imageWH);
    _titleLabel.numberOfLines = 0;
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.text = @"描述描述描述描述描述描述..........";
    //优惠价格
    _priceLabel.frame = CGRectMake(kScreen_Width-67, _imgView.top+10, 57, 20);
    _priceLabel.textColor = [UIColor redColor];
    _priceLabel.font = [UIFont systemFontOfSize:15];
    _priceLabel.text = @"￥70.00";
    //价格
//    _prePriceLabel.frame = CGRectMake(_priceLabel.left, _priceLabel.bottom, 57, 20);;
//    _prePriceLabel.textColor = [UIColor blackColor];
//    _prePriceLabel.font = [UIFont systemFontOfSize:15];
//    _prePriceLabel.text = @"￥85.00";
//    //line
//    _line.frame = CGRectMake(1, (_prePriceLabel.height-0.7)*0.5, _prePriceLabel.width-1, 0.7);
//    _line.backgroundColor = [UIColor blackColor];
    //数量
    _quantityLabel.frame = CGRectMake(_priceLabel.left, _priceLabel.bottom, 53, 20);
    _quantityLabel.textColor = [UIColor blackColor];
    _quantityLabel.font = [UIFont systemFontOfSize:15];
    _quantityLabel.textAlignment = NSTextAlignmentRight;
    _quantityLabel.text = @"x1";
    
    //
//    _bottomView.frame = CGRectMake(0, _middleView.bottom + 2, kScreen_Width, bottomViewHeight);
//    _bottomView.backgroundColor = [UIColor whiteColor];;
//    //取消／删除
//    _bottomLeftButton.frame = CGRectMake(kScreen_Width-2*bottomButtonW-27, bottomViewHeight*0.1, bottomButtonW, bottomViewHeight*0.8);
//    _bottomLeftButton.backgroundColor = [UIColor lightGrayColor];
//    [_bottomLeftButton setTitle:@"取消订单" forState:UIControlStateNormal];
//    [_bottomLeftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    _bottomLeftButton.titleLabel.font = [UIFont systemFontOfSize:15];
//    [_bottomLeftButton addTarget:self action:@selector(cancelOrDeleteAction) forControlEvents:UIControlEventTouchUpInside];
//    //确认／评价
//    _bottomRightButton.frame = CGRectMake(kScreen_Width-bottomButtonW-14, bottomViewHeight*0.1, bottomButtonW, bottomViewHeight*0.8);
//    _bottomRightButton.backgroundColor = [UIColor redColor];
//    [_bottomRightButton setTitle:@"确认收货" forState:UIControlStateNormal];
//    _bottomRightButton.titleLabel.font = [UIFont systemFontOfSize:15];
//    [_bottomRightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [_bottomRightButton addTarget:self action:@selector(sureOrevaluationAction) forControlEvents:UIControlEventTouchUpInside];
    
    
}
- (void)cancelOrDeleteAction
{
    
}
- (void)sureOrevaluationAction
{
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
