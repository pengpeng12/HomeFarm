//
//  XLogisticsTableViewCell.h
//  ChatDemo-UI2.0
//
//  Created by dfbe on 15/12/24.
//  Copyright © 2015年 dfbe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol postPriceDelegate <NSObject>

- (void)postPrice:(float)price logCode:(NSString *)logCode;

@end

@interface XLogisticsTableViewCell : UITableViewCell

@property(nonatomic, strong)id<postPriceDelegate>postLogPriceDelegate;

//- (IBAction)btnSFClick:(id)sender;
//- (IBAction)btnZTClick:(id)sender;

//@property (weak, nonatomic) IBOutlet UIButton *btnSF;
//@property (weak, nonatomic) IBOutlet UIButton *btnZT;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineHeightConstrain;

@property (weak, nonatomic) IBOutlet UILabel *labYF;//运费
//@property (weak, nonatomic) IBOutlet UILabel *labHJ;//合计

@property(nonatomic ,strong)NSMutableArray *logArr;//保存请求的运费
@property(nonatomic ,assign)float totalPrice;//保存请求的运费
@property(nonatomic, strong)NSMutableArray *tempBalanceArr;
@property(nonatomic, copy)NSString *immdetilyTempStr;
@property(nonatomic, copy)NSString *changeWULIU;//保存改变的物流

//- (IBAction)btnSFAllClick:(id)sender;
//- (IBAction)btnZTAllClick:(id)sender;

@end
