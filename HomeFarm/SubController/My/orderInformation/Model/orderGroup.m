//
//  orderGroup.m
//  ChatDemo-UI2.0
//
//  Created by 宋鹏鹏 on 15/12/15.
//  Copyright © 2015年 宋鹏鹏. All rights reserved.
//

#import "orderGroup.h"

@implementation orderGroup
+ (instancetype)GroupWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dict];
        //
        NSMutableArray *ordersArray=[NSMutableArray array];
        for (NSDictionary *dict in self.orderInfoArray) {
            orderInfoModel *orderinfo=[orderInfoModel ordersWithDict:dict];
            [ordersArray addObject:orderinfo];
        }
        self.orderInfoArray=ordersArray;
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
}
@end
