//
//  DataRequestManager.m
//  Photographer
//
//  Created by AA on 15/7/31.
//  Copyright (c) 2015年 AA. All rights reserved.
//

#import "DataRequestManager.h"
#import "AFHTTPSessionManager.h"

@implementation DataRequestManager
/***
 * 此函数用来判断是否网络连接服务器正常
 * 需要导入Reachability类
 */
+ (BOOL)isExistenceNetwork
{
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus <= 0) {
        NSLog(@"%ld",(long)[AFNetworkReachabilityManager sharedManager].networkReachabilityStatus);
        return FALSE;
    }
    
    return TRUE;
}

//实现GET请求方法
+ (void)methodGetWithURL:(NSString *)urlString HUDView:(UIViewController *)HUDView success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure;{
    if ([DataRequestManager isExistenceNetwork] == FALSE) {
        AlertViewShow(@"请检查网络", @"提示", nil)
        return;
    }
    MBProgressHUD *hud = [CommonMethod hud:HUDView.view lableText:@"加载中..."];
    
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    [session GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    }
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             
             NSError *error;
             NSDictionary *dict = [ NSJSONSerialization JSONObjectWithData :responseObject options : NSJSONReadingMutableLeaves error :&error];
             
             hud.hidden = YES;
             success(dict);
             NSLog(@"这里打印请求成功要做的事");
             
         }
     
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             if (error.code == -1001) {
                 
                 hud.label.text = @"请求超时";
                 [hud hideAnimated:YES afterDelay:1];
                 
             }else{
                 hud.hidden = YES;
             }
             
             
             failure(error);
             NSLog(@"%@",error);  //这里打印错误信息
             
         }];
    
}

+ (void)publicAlertDeal:(NSString *)urlString params:(NSString *)params HUDView:(UIViewController *)HUDView HUDText:(NSString *)text success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure{
    
    FanweMessage *alerView = [[FanweMessage alloc]initWithTitle:@"网络异常,请重试" message:nil otherButtonTitles:nil cancelButtonTitle:@"重试" YESblock:^{
        
    } NOblock:^{
        [DataRequestManager methodPostBody:urlString params:params HUDView:HUDView HUDText:text success:success failure:failure];
    } alertStyle:UIAlertViewStyleDefault];
    [alerView show];
    
}

+ (void)methodPostBody:(NSString *)urlString params:(NSString *)params HUDView:(UIViewController *)HUDView HUDText:(NSString *)text success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure
{
    if ([DataRequestManager isExistenceNetwork] == FALSE) {
        
        [DataRequestManager publicAlertDeal:urlString params:params HUDView:HUDView HUDText:text success:success failure:failure];
        
        return;
    }
    
    
    //urlString = [urlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSString *newurlString = [urlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:newurlString] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20.0];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    MBProgressHUD *hud;
    if (HUDView != nil) {
        hud = [CommonMethod hud:HUDView.view lableText:@"加载中..."];
    }
    
    
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
         
         //cookie过期
         if (httpResponse.statusCode == 401 || connectionError.code == -1012) {
             [hud hideAnimated:YES afterDelay:0.1];
             [DataRequestManager autoLogin:urlString params:params HUDView:HUDView HUDText:text success:success failure:failure];
             
         }else{
             
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];

                 
                 hud.label.text = text;
                 [hud hideAnimated:YES afterDelay:0.1];
                 
                 
                 success(result);
                 
             }else{
                 
                 if (connectionError.code == -1001) {
                     
                     hud.label.text = @"请求超时";
                     [hud hideAnimated:YES afterDelay:1.5];
                     
                 }else{
                     NSLog(@"error ========= %@---",[connectionError description]);
                     hud.hidden = YES;
                 }
                 [DataRequestManager publicAlertDeal:urlString params:params HUDView:HUDView HUDText:text success:success failure:failure];
                 
                 failure(connectionError);
             }
         }
         
     }];

}

////实现POST请求方法
//+ (void)methodPostWithURL:(NSString *)urlString params:(NSDictionary *)params HUDView:(UIViewController *)HUDView success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure
//{
//    //若url中含有中文时处理
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSLog(@"posturl----%@",urlString);
//    if ([DataRequestManager isExistenceNetwork] == FALSE) {
//        AlertViewShow(@"请检查网络", @"确定", nil)
//        return;
//    }
//    MBProgressHUD *hud = [CommonMethod hud:HUDView.view lableText:@"加载中..."];
//    AFHTTPRequestOperationManager *manager;//创建请求
//    
//    if (manager) {
//        manager = nil;//abaacacabccaaaacbccaccbcb2122
//    }
//    
//    //创建请求
//    manager = [AFHTTPRequestOperationManager manager];
//    
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    
//    
//    
//
//    manager.requestSerializer.timeoutInterval = 10.0;
//    //发送POST请求
//    [manager POST:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject){
//
//            NSError *error;
//
//            NSDictionary *dict = [ NSJSONSerialization JSONObjectWithData :responseObject options : NSJSONReadingMutableLeaves error :&error];
//        
//        /**/
////        NSDictionary *fields = [httpResponse allHeaderFields];
//        NSString *cookie = [operation.response.allHeaderFields valueForKey:@"Set-Cookie"];
//
//        NSString *valueToSave = cookie;
//        if (cookie.length > 0) {
//            [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"cookie"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//        }
//            NSLog(@"dic ---- %@\n%@－－－－%@",params,urlString,cookie);
//
//        
//
//        hud.hidden = YES;
//            success(dict);
//        }
//        failure :^( AFHTTPRequestOperation *operation, NSError *error)
//        {
//            NSLog(@"dic ---- %@\n",operation);
//            if (operation.response.statusCode == 401) {// || httpResponse.code == -1012
//                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cookie"];
//                [[NSUserDefaults standardUserDefaults] synchronize];
//                [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
//            }
//
//            if (error.code == -1001) {
//                
//                hud.labelText = @"请求超时";
//                [hud hide:YES afterDelay:1.5];
//                
//            }else{
//                hud.hidden = YES;
//            }
//            
//            
//            failure(error);
//            NSLog ( @"error description:%@" ,[error description ]);
//        }];
//}


//过期自动登录
+ (void)autoLogin:(NSString *)urlString params:(NSString *)params HUDView:(UIViewController *)HUDView HUDText:(NSString *)text success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure{
    
    NSString *username = [[NSUserDefaults standardUserDefaults] stringForKey:@"UserName"];
    NSString *userpassword = [[NSUserDefaults standardUserDefaults] stringForKey:@"UserPassword"];
    
    if (username.length > 0 && userpassword.length > 0) {
        [DataRequestManager methodPostBody:[NSString stringWithFormat:@"%@yds/login/%@/%@",YXRequestUrl,username,userpassword] params:nil HUDView:nil HUDText:@"" success:^(id JSON){
            NSLog(@"-///%@",JSON);
            
            if([[JSON valueForKey:@"statusCode"] intValue] == 200){
                
             [self methodPostBody:urlString params:params HUDView:HUDView HUDText:text success:success failure:failure];
            }
        }failure:^(NSError *error){
            
        }];
    }
}
@end
