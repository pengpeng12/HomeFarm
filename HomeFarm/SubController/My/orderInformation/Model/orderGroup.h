//
//  orderGroup.h
//  ChatDemo-UI2.0
//
//  Created by 宋鹏鹏 on 15/12/15.
//  Copyright © 2015年 宋鹏鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "orderInfoModel.h"
@interface orderGroup : NSObject
//订单状态
@property (nonatomic,copy)NSString *ctime;
@property (nonatomic,strong)NSArray *orderInfoArray;

+ (instancetype)GroupWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
