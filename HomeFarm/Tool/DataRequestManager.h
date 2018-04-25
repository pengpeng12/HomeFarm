//
//  DataRequestManager.h
//  Photographer
//
//  Created by AA on 15/7/31.
//  Copyright (c) 2015年 AA. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFURLSessionManager.h"


typedef void (^HttpSuccessBlock)(id JSON);
typedef void (^HttpFailureBlock)(NSError *error);
typedef void (^HttpNetBlock) (BOOL flag);
//传入的URL返回数据通过代理传递
@protocol DataRequestManagerDelegate <NSObject>

- (void)passValue:(id)value;

@optional

//不是必须要实现的方法
- (void)passGetValue:(id)getValue;

@end
@interface DataRequestManager : NSObject
@property(nonatomic, assign)id DataDelegate;

//判断网络状态
+ (BOOL)isExistenceNetwork;


//GET请求调用
+ (void)methodGetWithURL:(NSString *)urlString HUDView:(UIViewController *)HUDView success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure;;

//POST请求调用
//+ (void)methodPostWithURL:(NSString *)urlString params:(NSDictionary *)params HUDView:(UIViewController *)HUDView success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure;
//;


//上传图片
//+ (void)methodUploadWithURL:(NSString *)urlString params:(NSDictionary *)params HUDView:(UIViewController *)HUDView image:(UIImage *)image;
//
//+ (void)upLoadPhoto:(UIImage *)image params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure;

//POST请求
+ (void)methodPostBody:(NSString *)urlString params:(NSString *)params HUDView:(UIViewController *)HUDView HUDText:(NSString *)text success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure;

//过期自动登录
+ (void)autoLogin:(NSString *)urlString params:(NSString *)params HUDView:(UIViewController *)HUDView HUDText:(NSString *)text success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure;
@end
