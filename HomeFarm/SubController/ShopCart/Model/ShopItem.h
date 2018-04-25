//
//  ShopItem.h
//  ChatDemo-UI2.0
//
//  Created by Alex Lee on 8/9/15.
//  Copyright (c) 2015 Alex Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopItem : NSObject
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sales;
@property (nonatomic, copy) NSString *money;
@property (nonatomic, copy) NSString *point;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *standard;
@property (nonatomic, copy) NSString *desp;
@property (nonatomic, copy) NSString *despImgUrl;
@property (nonatomic, copy) NSString *mainImgUrl;
@property (nonatomic, strong) UIImage *mainImg;
@property (nonatomic, strong) NSMutableArray *mainImgUrls;
@property (nonatomic, strong) NSMutableArray *fiveCodes;
@property (nonatomic, strong) NSMutableArray *fiveNames;
@property (assign, nonatomic) int itemCount;

@end