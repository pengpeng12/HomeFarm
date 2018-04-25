//
//  XOrderPayViewController.h
//  ChatDemo-UI2.0
//
//  Created by dfbe on 15/12/24.
//  Copyright © 2015年 dfbe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaymentTableViewCell.h"
#import "XLogisticsTableViewCell.h"
#import "XCartOrderTableViewCell.h"
#import "XAddressDefaultShowTableViewCell.h"
#import "DCNewAdressViewController.h"
#import "DCReceivingAddressViewController.h"
#import "XChangeImmediatelyNumTableViewCell.h"

@interface XOrderPayViewController : UIViewController<postPriceDelegate,paymentButtonClickImageDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UILabel *topLine;

@property (weak, nonatomic) IBOutlet UILabel *hejiLabel;
@property (weak, nonatomic) IBOutlet UILabel *labHJ;
@property (weak, nonatomic) IBOutlet UIButton *btnBuy;
//底部确认购买view
@property (weak, nonatomic) IBOutlet UIView *bottomView;
- (IBAction)btnBuyClick:(id)sender;

@property(nonatomic, copy)NSString *immdetilyBtnStr;//立即购买时保存一个临时变量
@property(nonatomic, strong)NSMutableArray *tempPlistArr;

@property(nonatomic, retain)NSString *titelStr;
@end
