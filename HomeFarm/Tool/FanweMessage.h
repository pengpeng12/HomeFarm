//
//  FanweMessage.h
//  MShop
//
//  Created by 陈 福权 on 11-11-8.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

typedef void(^YesBlock)(void);
typedef void(^NoBlock)(void);
@interface FanweMessage : UIAlertView {

}
@property(nonatomic,copy)YesBlock YESblock;
@property(nonatomic,copy)NoBlock NOblock;

//需要自定义初始化方法，调用Block
- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
  otherButtonTitles:(NSString*)otherButtonTitles
cancelButtonTitle:(NSString *)cancelButtonTitle
           YESblock:(YesBlock)block
            NOblock:(NoBlock)NOblock
         alertStyle:(UIAlertViewStyle)style;

//系统自带的消息提示框
+(void) alert:(NSString *) message;

@end
