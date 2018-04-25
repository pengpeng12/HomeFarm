//
//  FanweMessage.m
//  MShop
//
//  Created by 陈 福权 on 11-11-8.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FanweMessage.h"
@interface FanweMessage()<UIAlertViewDelegate>
@end

@implementation FanweMessage



- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
  otherButtonTitles:(NSString*)otherButtonTitles
cancelButtonTitle:(NSString *)cancelButtonTitle
           YESblock:(YesBlock)block
            NOblock:(NoBlock)NOblock
            alertStyle:(UIAlertViewStyle)style
{
    self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];//注意这里初始化父类的
    self.alertViewStyle = style;
    if(self){
        //将回调赋值给我们自定义的block方法
        self.YESblock = block;
        self.NOblock = NOblock;
    }
    return self;
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //这里调用函数指针_block(要传进来的参数);
    if(buttonIndex == 0){
        if(_NOblock != nil){
            _NOblock();
        }
    }else if (buttonIndex == 1){
        if(_YESblock != nil){
            _YESblock();
        }
    }
}


+(void) alert:(NSString *) message{
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:message delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
	[alert show];
}




@end
