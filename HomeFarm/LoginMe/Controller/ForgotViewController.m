//
//  ForgotViewController.m
//  ChatDemo-UI2.0
//
//  Created by Richard Stewart on 3/7/15.
//  Copyright (c) 2015 Richard Stewart. All rights reserved.
//

#import "ForgotViewController.h"
#import "ASTextField.h"
#import "CommonMethod.h"
#import "APRoundedButton.h"
@interface ForgotViewController (){
    NSTimer *aTimer;
    int timer_Seconds;
}
@property (strong, nonatomic) IBOutlet APRoundedButton *verifyBtn;
@property (weak, nonatomic) IBOutlet UITextField *phonenumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *activatekeyTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *password2TextField;
//@property (nonatomic, retain) NSTimer *aTimer;
- (IBAction)verifyMobileButton:(UIButton *)sender;
- (IBAction)doRegister:(id)sender;
- (IBAction)doReset:(id)sender;

@end

@implementation ForgotViewController
@synthesize passwordTextField = _passwordTextField;
@synthesize phonenumberTextField = _phonenumberTextField;
@synthesize activatekeyTextField = _activatekeyTextField;
@synthesize password2TextField = _password2TextField;


- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setupForDismissKeyboard];
    // Do any additional setup after loading the view from its nib.
    self.title = @"忘记密码";
    /*
    设置圆角按钮
     */
    [CommonMethod setTextFieldLayer:self.phonenumberTextField cornerRadius:5];
    [CommonMethod setTextFieldLayer:self.passwordTextField cornerRadius:5];
    [CommonMethod setTextFieldLayer:self.password2TextField cornerRadius:5];
    [CommonMethod setTextFieldLayer:self.activatekeyTextField cornerRadius:5];
    [CommonMethod setButtonLayer:self.verifyBtn cornerRadius:5];
    [CommonMethod setButtonLayer:self.btnQR cornerRadius:5];
    timer_Seconds = 60;
    
}
- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField becomeFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if(textField==self.phonenumberTextField){
        
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        return !([newString length] > 11);
    }
    
    return YES;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == self.phonenumberTextField || textField == self.phonenumberTextField) {
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }
   
}

- (void)makeToast:(NSString*)toastString{
    
    
}

- (IBAction)verifyMobileButton:(UIButton *)sender {

    if(_phonenumberTextField.text.length < 11){
        NSString *message = [NSString stringWithFormat:NSLocalizedString(@"请输入11位手机号码", @"请输入11位手机号码")];
        //TTAlertNoTitle(message);
        [self makeToast:message];
        return;
    }

    timer_Seconds = 60;
    
//    if ([DataRequestManager isExistenceNetwork] == FALSE) {
//        AlertViewShow(@"请检查网络", @"确定", nil)
//        return;
//    }
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.exinol.com/yx/retrieve/verify/%@",_phonenumberTextField.text] ];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url]; //cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20.0];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    WEAKSELF
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         [SVProgressHUD dismiss];
         
         if (data.length > 0 && connectionError == nil)
         {
             @try{
             NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
             NSString *statusCode = [[result objectForKey:@"statusCode"] stringValue];
             
             if ([statusCode isEqualToString:@"200"]) {
//                 NSString *contents = [[result valueForKey:@"contents"] stringValue];
                 //self.activatekeyTextField.text = contents;
//                 [self makeToast:contents];
                 self->aTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(runScheduledTask) userInfo:nil repeats:YES];
             } else {
//                 self.activatekeyTextField.text = @"";
                 NSString *errorMessage = [[result objectForKey:@"errorMessage"] stringValue];
                 [weakSelf.view makeToast:errorMessage duration:0.5 position:CSToastPositionCenter];
             }
             }@catch(NSException *e){
                 NSLog(@"Forgot Error");
             }@finally{
                 
             }

         }
     }];
}
/* runScheduledTask */
- (void)runScheduledTask {
    // Do whatever u want
    
    timer_Seconds--;
    if (timer_Seconds < 1) {
        [_verifyBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
//        _activatekeyTextField.text=@"";
        [self->aTimer invalidate];
        
    }
    else{
        NSLog(@"timerSecond: %d", timer_Seconds);
        NSString *second_str=[NSString stringWithFormat:@"%d秒",timer_Seconds];
        [_verifyBtn setTitle:second_str forState:UIControlStateNormal];
        //aTimer = nil;
    }
}

- (IBAction)doRegister:(id)sender {
    if (![self isEmpty]) {
        //隐藏键盘
        [self.view endEditing:YES];
        //判断是否是中文，但不支持中英文混编
//        if ([self.usernameTextField.text isChinese]) {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"login.nameNotSupportZh", @"Name does not support Chinese")
//                                                            message:nil
//                                                           delegate:nil
//                                                  cancelButtonTitle:NSLocalizedString(@"ok", @"OK")
//                                                  otherButtonTitles:nil];
//            
//            [alert show];
//            
//            return;
//        }
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:kAlphaNum] invertedSet];
        
        NSString *filtered = [[self.passwordTextField.text componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""]; //按cs分离出数组,数组按@""分离出字符串
        
        BOOL canChange = [self.passwordTextField.text isEqualToString:filtered];
        BOOL canPass = [self.password2TextField.text isEqualToString:filtered];
        
        
        if(![_passwordTextField.text isEqualToString:_password2TextField.text]){
            [self.view makeToast:@"密码不一致，请检查" duration:0.5 position:CSToastPositionCenter];
            return;
        }else if (_password2TextField.text.length<6 || _password2TextField.text.length >30){
            [self.view makeToast:@"请设置密码长度为6-30位" duration:0.5 position:CSToastPositionCenter];
            return;
        }else if (canChange == NO || canPass == NO) {
            [self.view makeToast:@"密码只允许输入字母、数字及下划线" duration:0.5 position:CSToastPositionCenter];
            return;
        }
//        if ([DataRequestManager isExistenceNetwork] == FALSE) {
//            AlertViewShow(@"请检查网络", @"确定", nil)
//            return;
//        }
        //========================Yidashi register 20150320 inserted by unje
        NSString *params = [NSString stringWithFormat:@"{\"phone\":\"%@\",\"pwd\":\"%@\",\"valiNumber\":\"%@\"}",_phonenumberTextField.text,_passwordTextField.text,_activatekeyTextField.text];
        
//        [DataRequestManager methodPostBody:[NSString stringWithFormat:@"%@yds/retrieve",YXRequestUrl] params:params HUDView:self HUDText:@"" success:^(id JSON){
//            NSLog(@"---login----%@",JSON);
//
//            if([[JSON valueForKey:@"statusCode"] intValue] == 200){
//                [self  makeToast:@"密码修改成功"];
//
//                [self.navigationController popToRootViewControllerAnimated:YES];
//
//            } else {
//                NSString *errorMessage = [[JSON objectForKey:@"errorMessage"] stringValue];
//                TTAlertNoTitle(errorMessage);
//                return;
//            }
//        }failure:^(NSError *error){
//
//        }];
        

    }
}
- (IBAction)doReset:(id)sender {
    _phonenumberTextField.text = @"";
    _activatekeyTextField.text = @"";
    _passwordTextField.text = @"";
    _password2TextField.text = @"";
    
}
//判断账号和密码是否为空
- (BOOL)isEmpty{
    
    if([_phonenumberTextField.text isEqualToString:@""]){
        [self.view makeToast:@"请输入手机号码" duration:0.5 position:CSToastPositionCenter];
        return YES;
    }
    
    if([_activatekeyTextField.text isEqualToString:@""]){
        [self.view makeToast:@"请输入验证码" duration:0.5 position:CSToastPositionCenter];
        return YES;
    }
    
    if([_passwordTextField.text isEqualToString:@""]){
        [self.view makeToast:@"请输入密码" duration:0.5 position:CSToastPositionCenter];
        return YES;
    }
    if([_password2TextField.text isEqualToString:@""]){
        [self.view makeToast:@"请确认密码" duration:0.5 position:CSToastPositionCenter];
        return YES;
    }
    
    return NO;
}
@end
