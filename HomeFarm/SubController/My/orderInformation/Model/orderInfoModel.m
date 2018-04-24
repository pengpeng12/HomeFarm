//
//  orderInfoModel.m
//  ChatDemo-UI2.0
//
//  Created by apple  on 15/12/14.
//  Copyright © 2015年 apple . All rights reserved.
//

#import "orderInfoModel.h"

@implementation orderInfoModel
+ (instancetype)ordersWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
