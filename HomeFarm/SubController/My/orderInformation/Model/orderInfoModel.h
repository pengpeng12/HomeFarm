//
//  orderInfoModel.h
//  ChatDemo-UI2.0
//
//  Created by apple  on 15/12/14.
//  Copyright © 2015年 apple . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface orderInfoModel : NSObject
////订单状态

////预览图
//UIImageView *_imgView;
////商品名
//UILabel *_titleLabel;
////优惠价格
//UILabel *_priceLabel;
////数量
//UILabel *_quantityLabel;
////总个数
//UILabel *_totolQuantLabel;
////总价
//UILabel *_totolPriceLabel;

+ (instancetype)ordersWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
