//
//  orderInformationCell.h
//  ChatDemo-UI2.0
//
//  Created by apple  on 15/12/14.
//  Copyright © 2015年 apple . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "orderInfoModel.h"

#define topViewHeight 35
#define imageWH 100
#define bottomViewHeight 42
#define bottomButtonW kScreen_Width*0.22

#define cellHeight  7+100+5+2+7

@interface orderInformationCell : UITableViewCell
{
    //预览图
    UIImageView *_imgView;
    //商品名
    UILabel *_titleLabel;
    //优惠价格
    UILabel *_priceLabel;
//    //价格
//    UILabel *_prePriceLabel;
    //数量
    UILabel *_quantityLabel;
//    //line
//    UILabel *_line;
       //
//    UIView *_bottomView;
//    //取消／删除
//    UIButton *_bottomLeftButton;
//    //确认／评价
//    UIButton *_bottomRightButton;
    
}
+ (instancetype)cellWithTableView:(UITableView *)tableView;
//
@property (nonatomic, strong)orderInfoModel *orderInfo;
@end
