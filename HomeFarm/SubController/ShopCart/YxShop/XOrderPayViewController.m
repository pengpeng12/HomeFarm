 //
//  XOrderPayViewController.m
//  ChatDemo-UI2.0
//
//  Created by dfbe on 15/12/24.
//  Copyright © 2015年 dfbe. All rights reserved.
//

#import "XOrderPayViewController.h"
#import "APOrderInfo.h"
#import "APRSASigner.h"

//#import "UPPayPlugin.h"
//#import "UPPaymentControl.h"
@interface XOrderPayViewController ()<UITableViewDataSource,UITableViewDelegate,xchangeImmediatelyDelegate>{
    NSMutableArray *gotoPayArr;
    NSMutableArray *sectionArr;
    NSMutableArray *addressArr;
    
    NSString *isNullWithRefresh;
    NSString *payType, *logCoded, *itemsParam;
    int immedetialyCell;//立即购买进入时增加一个xchangeimmedetialy表格
}

@end

@implementation XOrderPayViewController


/*
 从后一个界面返回时刷新数据
 */
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];
    if (isNullWithRefresh.length == 0) {
        [self publicRefreshAddress:nil];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"确认订单";
    
    self.view.backgroundColor = RGB(247, 247, 247);
    self.myTableView.frame = CGRectMake(0, 0, kScreen_Width, kScreen_Height -DCTopNavH-44);
    self.bottomView.frame = CGRectMake(0, kScreen_Height - DCTopNavH - 44, kScreen_Width, 44);
    //frame
    self.topLine.frame = CGRectMake(0, 0, kScreen_Width, 1.0/[UIScreen mainScreen].scale);
    self.hejiLabel.frame = CGRectMake(0, 14, kScreen_Width/2*0.6, 20);
    self.labHJ.frame = CGRectMake(self.hejiLabel.right, 14, kScreen_Width/2*0.4, 20);
    self.btnBuy.frame = CGRectMake(self.labHJ.right, 0, kScreen_Width*0.5, self.bottomView.height);
    
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorColor = [UIColor clearColor];
    
    gotoPayArr = [[NSMutableArray alloc] initWithCapacity:0];
    
    if ([self.immdetilyBtnStr isEqualToString:@"临时结算物品"]) {
        gotoPayArr = self.tempPlistArr;
        immedetialyCell = 1;
    }else{
        immedetialyCell = 0;
        NSMutableArray *plistArr = [NSMutableArray arrayWithContentsOfFile:[CommonMethod getFilePath]];
        for (int i=0; i<plistArr.count; i++) {
            if ([[[plistArr objectAtIndex:i] objectForKey:@"selected"] boolValue] == YES) {
                [gotoPayArr addObject:[plistArr objectAtIndex:i]];
            }
        }
    }
    
    self->payType = @"ZF";
    
    [self publicRefreshAddress:nil];
    
    sectionArr = [[NSMutableArray alloc] initWithCapacity:0];
    [sectionArr addObject:[NSMutableArray arrayWithObjects:@"1", nil]];
    [sectionArr addObject:gotoPayArr];
    [sectionArr addObject:[NSMutableArray arrayWithObjects:@"3", nil]];
    [sectionArr addObject:[NSMutableArray arrayWithObjects:@"4", nil]];
    
    if (immedetialyCell == 1) {
        [sectionArr addObject:[NSMutableArray arrayWithObjects:@"5", nil]];
    }
}

- (NSString *)postItem{
    NSMutableArray *itemsArray = [[NSMutableArray alloc] init];
    for (int i=0; i<[[sectionArr objectAtIndex:1] count]; i++) {
        NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
        item = [[sectionArr objectAtIndex:1] objectAtIndex:i];
        NSString* productCodeString = [item objectForKey:@"code"];
        int productCount = [[item objectForKey:@"num"] intValue];
        NSString *eachItem = [NSString stringWithFormat:@"{\"count\":%d,\"code\":\"%@\"}",productCount,productCodeString];
        [itemsArray addObject:eachItem];
    }
    
    NSString * requestStart = @"[";
    NSString * combinedString = [itemsArray componentsJoinedByString:@","];
    NSString * concatAddress = [requestStart stringByAppendingString:combinedString];
    itemsParam = [concatAddress stringByAppendingString:@"]"];
    
    NSLog(@"jsonRequestParam : %@",itemsParam);
    return itemsParam;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[sectionArr objectAtIndex:section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return sectionArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    
    if (indexPath.section == 0) {
        if (addressArr.count == 0) {
            static NSString *Cell = @"identity";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Cell];
                cell.backgroundColor = RGB(247, 247, 247);
                
                UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0,10, kScreen_Width, 44)];
                lab.text = @"    请填写收货地址";
                lab.font = [UIFont systemFontOfSize:15];
                lab.textColor = [CommonMethod hexColor:@"#333333"];
                lab.backgroundColor = [UIColor whiteColor];
                [cell.contentView addSubview:lab];
                
                UIImageView *rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(kScreen_Width-25, 25, 8, 14)];
                rightImg.image = [UIImage imageNamed:@"shop_unfurled_icon"];
                [cell.contentView addSubview:rightImg];
                
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            XAddressDefaultShowTableViewCell *addresscell = [tableView dequeueReusableCellWithIdentifier:@"address"];
            if (addresscell == nil) {
                addresscell = [[[NSBundle mainBundle] loadNibNamed:@"XAddressDefaultShowTableViewCell" owner:self options:nil] lastObject];
            }
            
            
            addresscell.dic = [addressArr objectAtIndex:0];
            addresscell.selectionStyle = UITableViewCellSelectionStyleNone;
            return addresscell;
        }
        
    }else if (indexPath.section == 1){
        XCartOrderTableViewCell *carcell = [tableView dequeueReusableCellWithIdentifier:@"carcell"];
        
        if (carcell == nil) {
            carcell = [[[NSBundle mainBundle] loadNibNamed:@"XCartOrderTableViewCell" owner:self options:nil] lastObject];
        }
        
        
        if (![self.titelStr isEqualToString:@"购物车进入"]) {
//            carcell.labNum.hidden = YES;
        }else{
            carcell.labNum.hidden = NO;
        }
        carcell.selectionStyle = UITableViewCellSelectionStyleNone;
        carcell.dic = gotoPayArr[indexPath.row];
        return carcell;
    }
    if (immedetialyCell == 0) {
        
    }else{
        if (indexPath.section == 2){
            XChangeImmediatelyNumTableViewCell *changecell = [tableView dequeueReusableCellWithIdentifier:@"changecell"];
            if (changecell == nil) {
                changecell = [[[NSBundle mainBundle] loadNibNamed:@"XChangeImmediatelyNumTableViewCell" owner:self options:nil] lastObject];
                changecell.xchangeDelegate = self;
                
            }
            changecell.dic = [gotoPayArr objectAtIndex:0];
            changecell.selectionStyle = UITableViewCellSelectionStyleNone;
            return changecell;
        }
    }
    
    if (indexPath.section == 2+immedetialyCell){
        XLogisticsTableViewCell *logcell = [tableView dequeueReusableCellWithIdentifier:@"logcell"];
        if (logcell == nil) {
            logcell = [[[NSBundle mainBundle] loadNibNamed:@"XLogisticsTableViewCell" owner:self options:nil] lastObject];
            logcell.postLogPriceDelegate = self;
        }
        
        logcell.changeWULIU = @"SF";//self->logCoded;
        logcell.tempBalanceArr = gotoPayArr;
        logcell.immdetilyTempStr = self.immdetilyBtnStr;
        logcell.selectionStyle = UITableViewCellSelectionStyleNone;
        return logcell;
    }else if (indexPath.section == 3+immedetialyCell){
        PaymentTableViewCell *paycell = [tableView dequeueReusableCellWithIdentifier:@"paycell"];
        if (paycell == nil) {
            
            paycell = [[[NSBundle mainBundle] loadNibNamed:@"PaymentTableViewCell" owner:self options:nil] lastObject];
            paycell.paymentDelegate = self;
        }
        
        
        paycell.saveBtnStatusStr = payType;
        paycell.selectionStyle = UITableViewCellSelectionStyleNone;
        return paycell;
    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    /*
     默认地址：120
     */
    if (indexPath.section == 0) {
        if (addressArr.count == 0) {
            return 64.0;
        }else{
            return 119.0;
        }
        
    }else if (indexPath.section == 1){
        return 104.0;
    }
    
    if (immedetialyCell == 1) {
        if (indexPath.section == 2) {
            return 47;
        }
    }
    if (indexPath.section == 2+immedetialyCell){
        return 75.0;
    }else if (indexPath.section == 3+immedetialyCell){
        return 176.0;
    }else{
        return 44.0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && addressArr.count == 0) {
        DCNewAdressViewController *new = [[DCNewAdressViewController alloc] init];
        [self.navigationController pushViewController:new animated:YES];
    }else if (indexPath.section == 0 && addressArr.count >0){
        DCReceivingAddressViewController *all = [[DCReceivingAddressViewController alloc] init];
        [self.navigationController pushViewController:all animated:YES];
    }
}


//点击表格后需要刷新的数据（不考虑默认地址）
- (void)clickCellChangeAddress:(NSMutableDictionary *)replaceDic{
    isNullWithRefresh = @"replaceDic";
    
    if (replaceDic != nil) {
        [self publicRefreshAddress:replaceDic];
    }
}


- (void)publicRefreshAddress:(NSMutableDictionary *)refreshDic{
    if (refreshDic != nil) {
        addressArr = [[NSMutableArray alloc] initWithObjects:refreshDic, nil];
    }else{
        addressArr = [NSMutableArray arrayWithContentsOfFile:[CommonMethod getAddressPath]];
        if (addressArr == nil) {
            addressArr = [[NSMutableArray alloc] initWithCapacity:0];
        }else{
            
            BOOL isSelectFlag = NO;
            
            for (int i=0; i<addressArr.count; i++) {
                
                /*
                 当没有默认地址时为plist中的第一个
                 */
                if ([[[addressArr objectAtIndex:i] objectForKey:@"isSelected"] isEqualToString:@"1"]){
                    addressArr = [[NSMutableArray alloc] initWithObjects:[addressArr objectAtIndex:i], nil];
                    isSelectFlag = YES;
                    break;
                }
            }
            
            if (isSelectFlag == NO) {
                
                if (addressArr.count != 0) {
                    addressArr = [[NSMutableArray alloc] initWithObjects:[addressArr objectAtIndex:0], nil];
                }
                
            }
        }
        
    }
    
    
    [self.myTableView reloadData];
}


/*
 立即购买进行时增减商品数量时刷新表格更新价格
 */
- (void)selectBtnChangeNum:(NSString *)addOrDel{
    NSMutableDictionary *dic = [gotoPayArr objectAtIndex:0];
    int changeNum = [[dic objectForKey:@"num"] intValue];
    if ([addOrDel isEqualToString:@"add"]) {
        changeNum+=1;
        [dic setObject:[NSString stringWithFormat:@"%d",changeNum] forKey:@"num"];
        
        
    }else if ([addOrDel isEqualToString:@"del"]){
        if ([[dic objectForKey:@"num"] intValue] != 1) {
            changeNum-=1;
            [dic setObject:[NSString stringWithFormat:@"%d",changeNum] forKey:@"num"];
        }
    }
    
    [self.myTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)postPrice:(float)price logCode:(NSString *)logCode{
    
    self->logCoded = logCode;
    self.labHJ.text = [NSString stringWithFormat:@"¥%.0f",price];
}


- (void)witchPayClick:(NSString *)btnClickIdentifier{
    if ([btnClickIdentifier isEqualToString:@"zfb"]) {
        payType = @"ZF";
    }else if ([btnClickIdentifier isEqualToString:@"wx"]){
        payType = @"WX";
    }else if ([btnClickIdentifier isEqualToString:@"yl"]){
        payType = @"YL";
    }
}
- (IBAction)btnBuyClick:(id)sender {
    if([addressArr count] == 0){
        [CommonMethod hudShow:self hudText:@"请填写收货地址"];
    }else if ([self->logCoded isEqualToString:@""]){
        [CommonMethod hudShow:self hudText:@"请选择物流类型"];
    }else if ([[self postItem] isEqualToString:@""]){
        [CommonMethod hudShow:self hudText:@"您没有要结算的商品"];
    }
    else{

//        [DataRequestManager methodPostBody:[NSString stringWithFormat:@"%@yds/newOrder",YXRequestUrl] params:[NSString stringWithFormat:@"{\"payType\":\"%@\",\"name\":\"%@\",\"phone\":\"%@\",\"address\":\"%@\",\"zipCode\":\"%@\",\"logisticsCode\":\"%@\",\"items\":%@}",payType,[[addressArr objectAtIndex:0] objectForKey:@"SHR"],[[addressArr objectAtIndex:0] objectForKey:@"phone"],[NSString stringWithFormat:@"%@%@",[[addressArr objectAtIndex:0] objectForKey:@"city"],[[addressArr objectAtIndex:0] objectForKey:@"detailAddress"]],[[addressArr objectAtIndex:0] objectForKey:@"zip"],@"SF", [self postItem]] HUDView:self HUDText:@"正在提交订单" success:^(id JSON){
//
//            NSLog(@"pay-------%@",JSON);
//            if ([[JSON valueForKey:@"statusCode"] intValue] == 200) {
//                if ([self->payType isEqualToString:@"WX"]) {
//                    [self payWX:[[JSON valueForKey:@"contents"] valueForKey:@"appid"] sign:[[JSON valueForKey:@"contents"] valueForKey:@"sign"] partnerid:[[JSON valueForKey:@"contents"] valueForKey:@"partnerid"] prepayid:[[JSON valueForKey:@"contents"] valueForKey:@"prepayid"] package:[[JSON valueForKey:@"contents"] valueForKey:@"package"] timestamp:[[JSON valueForKey:@"contents"] valueForKey:@"timestamp"] nocestr:[[JSON valueForKey:@"contents"] valueForKey:@"noncestr"]];
//                }else if ([self->payType isEqualToString:@"ZF"]){
//                    [self payWithZFB:[[JSON valueForKey:@"contents"] valueForKey:@"partner "] seller:[[JSON valueForKey:@"contents"] valueForKey:@"seller_id"] notifyurl:[[JSON valueForKey:@"contents"] valueForKey:@"notify_url"] payprice:[[JSON valueForKey:@"contents"] valueForKey:@"total_fee"] describ:[[JSON valueForKey:@"contents"] valueForKey:@"subject"] traderno:[[JSON valueForKey:@"contents"] valueForKey:@"out_trade_no"]];
//                }else if ([self->payType isEqualToString:@"YL"]){
////                    [UPPayPlugin startPay:[JSON valueForKey:@"contents"] mode:[NSString stringWithFormat:@"00"] viewController:self delegate:self];
//
////                     [[UPPaymentControl defaultControl] startPay:[JSON valueForKey:@"contents"] fromScheme:@"UPPayDemo" mode:[NSString stringWithFormat:@"00"] viewController:self];
//                }
//            }else {
//                [CommonMethod hudShow:self hudText:[JSON objectForKey:@"errorMessage"]];
//
//            }
//
//
//        }failure:^(NSError *error){
//
//        }];
    }
}

- (void)payWX:(NSString *)appid sign:(NSString *)sign partnerid:(NSString *)partnerid prepayid:(NSString *)prepayid package:(NSString *)package timestamp:(NSString *)timestamp nocestr:(NSString *)noncestr{
    
    NSLog(@"---appid=%@,sigin=%@,partnerid=%@,prepayid=%@,package=%@,timestamp=%@,nocestr=%@",appid,sign,partnerid,prepayid,package,timestamp,noncestr);
//    //创建支付签名对象
//    payRequsestHandler *req = [[payRequsestHandler alloc] init];
//    //初始化支付签名对象
//    [req init:appid mch_id:partnerid];
//    //设置密钥
//    [req setKey:sign];
//
    NSString *stamp  = timestamp;//[dict objectForKey:@"timestamp"];
    
    //调起微信支付
    PayReq* reqs             = [[PayReq alloc] init];
    reqs.openID              = appid;//[dict objectForKey:@"appid"];
    reqs.partnerId           = partnerid;//[dict objectForKey:@"partnerid"];
    reqs.prepayId            = prepayid;//[dict objectForKey:@"prepayid"];
    reqs.nonceStr            = noncestr;//[dict objectForKey:@"noncestr"];
    reqs.timeStamp           = stamp.intValue;
    reqs.package             = package;//[dict objectForKey:@"package"];
    reqs.sign                = sign;//[dict objectForKey:@"sign"];
    
    [WXApi sendReq:reqs];
    
    NSLog(@"reqs---%d",[WXApi sendReq:reqs]);
    //    }
    
}

- (void)payWithZFB:(NSString *)partners seller:(NSString *)sellers notifyurl:(NSString *)notifyurls payprice:(NSString *)payprices describ:(NSString *)describs traderno:(NSString *)tradernos{
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = partners;
    NSString *seller = sellers;
    NSString *appID = @"2018041902580777";
    NSString *rsa2PrivateKey = @"MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCFkCpp/rwB8ai7gr677A8tb06VjR7sadOPryKLzaEmcLkvFK3Ud+H+6DRfQ73sjpa42VD+8MwR9gw6laDj7PSHfMTLiFwelpO1wg8bzRxsW9DdmAOMeYaeYJo/C970+bSYSeedO7M9ZqPC/j7N9aNepgPLBErOI7PGRVjBkMfiZs4Skh6K9XVe0UCYXd5oG80OL90AYmyp4ZrvQ48tujYo4F6Hs5mG2IhZS+MvQjOzyvXp7W17V+Fjn8KOzyrdNOauSNG79Op6ScJqn2lc3Ee4afv5CqTArRQ7/qBuVR206eGk6+loZyYU5vsHCXiFNKeXF0rc7PlIrTEZ8FGYzSSjAgMBAAECggEAXtfy5nXXd+HtGcpMOxHz7SWfPh+KGANGEkAhXflVOADP35jln3zJ5MNrfUKTeYn/iZ/4HjFMGG0KXgemynOXaSa2cHmSQL5YgbceF3Xdeyzv8oth6bzaVVjv71k0p+0xyvqgGE0uiKl8HJmCa6rEqg9lniKcJCnCHUddMYboCeJAjpQGhLgyJF5wtPgUmd57KAodE9iybKsmWIdSvZDqIcmDKfvvX1KEcrR+5/s89lxOSXQ1X7F3Wmts1O9uu0WYrrWQkcQIkpFGksEdSWz7MTzji+kiHsPjzKW2kJsNMXloJ4US6Y61BhWyV+tghA42ADLlwHP98DYsWPqWXfk+4QKBgQDa+UFe8SXDKsHbzmOSvfjljDVY/PtmQbewiodENoHsTFth5vQYBA7ZVNgcTEgMie+szcUWs0N2wVLr+twB4ARrtOvLmKhwbngnnlvhFRjV6HkuNqtB3kEzZqwAIRX01c2xFzh9eyRG0d6CaLOM90H/xrP/UUVVTDePSsjKYRb8uwKBgQCcJbuzmAOb0ppzNy1HtEj2+/38cFUGT7WLXK8d4vewFf6gybk9Cj38C4VtBYhsLgTvSCxDFsVO4I4J69HIWH2++WrCFazcf2SjD2BS3/MI6MVrY1uOt04xQNLbJf6aOEPdMvZrgVjW5WpGQ/rNF/51yWhmcsrScgu0OxZpvaYtOQKBgQDKMNF9uyllNrveHIqw2p1SR86SprXzy8azSpZwE+yPpknS8pB9BHI5lzAdoQn+GfenFjFgLpKiuwu4PeCcEp/CXEJFsmYFuttTqdOo1/QgwBH07CHiJjkKH0m+rM47TpgpZwmQQ/5RLkRJIih4h273oCBgJkjg5AmBVEpnJJM3NQKBgHP5gqQtb+C4V4bjoHn1aYwoNcjdFgmOAmTz/gzQmu7qJyj9KtwvU0J0vDDxPxY6R+gBTv61Vu7y0gyEXlfTgfHqBmUI/E75P6HstbpYI4amfJr6PPKPK0BhyTqDycp5p84PH/9RHs7drkVqEElsXM7XPPd6ozITCqZejJMVDOvhAoGABXkJsRV8rGP/TKKroqBZ2OhO8UJxoY+7MGF1OrjsVfMuxKK4SDcCHT5KbUOZjBLABe/8GSWshbk8usdpSPkeUR1Kn5etRtGEvpjzMwswT9CEHKwubp4NskQhiBjFGDCD6aOKhBUps5jhySXtpAoPblMNAlg6fxGSVo7JcV9FP9I=";
    
    NSString *rsaPrivateKey = @"";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [rsa2PrivateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    /**/
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    
    
    APOrderInfo *order = [APOrderInfo new];
    order.app_id = appID;
    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";
    
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    
    // NOTE: 支付版本
    order.version = @"1.0";
    
    // NOTE: sign_type 根据商户设置的私钥来决定
    order.sign_type = (rsa2PrivateKey.length > 1)?@"RSA2":@"RSA";
    
    // NOTE: 商品数据
    order.biz_content = [APBizContent new];
    order.biz_content.body = describs;
    order.biz_content.subject = @"测试";//商品标题
    order.biz_content.out_trade_no = tradernos; //订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    //[NSString stringWithFormat:@"%.2f",[payprices floatValue]]; //商品价格
    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", 0.01]; //商品价格
    
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@",orderInfo);
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    NSString *signedString = nil;
    APRSASigner* signer = [[APRSASigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
    if ((rsa2PrivateKey.length > 1)) {
        signedString = [signer signString:orderInfo withRSA2:YES];
    } else {
        signedString = [signer signString:orderInfo withRSA2:NO];
    }
    
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"alisdkdemotest";
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];
        
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            if ([[resultDic objectForKey:@"resultStatus"] intValue] == 9000) {
                AlertViewShow(@"支付成功", @"确定", nil)
            }else{
                AlertViewShow(@"支付失败，请重试", @"确定", nil)
            }
        }];
    }

}
- (void)UPPayPluginResult:(NSString *)result{
    
}
@end
