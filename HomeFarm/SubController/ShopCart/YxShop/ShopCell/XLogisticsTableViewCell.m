//
//  XLogisticsTableViewCell.m
//  ChatDemo-UI2.0
//
//  Created by dfbe on 15/12/24.
//  Copyright © 2015年 dfbe. All rights reserved.
//

#import "XLogisticsTableViewCell.h"

@implementation XLogisticsTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.lineHeightConstrain.constant = 1.0/[UIScreen mainScreen].scale;
}

- (void)layoutSubviews{
    
    self.totalPrice = 0;//若有快递选择时需注意修改
    
    NSMutableArray *plistArr = [[NSMutableArray alloc] initWithCapacity:0 ];
    
    if ([self.immdetilyTempStr isEqualToString:@"临时结算物品"]) {
        plistArr = self.tempBalanceArr;
    }else{
        plistArr = [NSMutableArray arrayWithContentsOfFile:[CommonMethod getFilePath]];
    }
    
    for (int i=0; i<plistArr.count; i++) {
        if ([[[plistArr objectAtIndex:i] objectForKey:@"selected"] boolValue] == YES) {
            self.totalPrice += [[[plistArr objectAtIndex:i] objectForKey:@"price"] intValue] * [[[plistArr objectAtIndex:i] objectForKey:@"num"] intValue];
        }
    }

    
//    UIViewController *view = [[UIViewController alloc] init];
//    [DataRequestManager methodPostBody:[NSString stringWithFormat:@"%@manage/logistics",YXRequestUrl] params:nil HUDView:view HUDText:@"" success:^(id JSON){
//        NSLog(@"---login----%@",JSON);
//
//        if([[JSON valueForKey:@"statusCode"] intValue] == 200){
//            self.logArr = [[NSMutableArray alloc] initWithCapacity:0];
//
//            [self.logArr removeAllObjects];
//
//            for (int i=0; i<[[JSON objectForKey:@"contents"] count]; i++) {
//                NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
//                [dic setObject:[[[JSON objectForKey:@"contents"] objectAtIndex:i] objectForKey:@"price"] forKey:[[[JSON objectForKey:@"contents"] objectAtIndex:i] objectForKey:@"code"]];
//
//                [self.logArr addObject:dic];
//            }
//
//
//            if ([self.changeWULIU isEqualToString:@"ZT"]) {
////                [self btnZTClick:self.btnZT];
//            }else if ([self.changeWULIU isEqualToString:@"SF"]){
//                [self btnSFClick];
//            }else{
//                if (self.logArr.count != 0) {
//                    [self btnSFClick];
//                }
//            }
//        }
//    }failure:^(NSError *error){
//        [self.logArr addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"15",@"SF", nil]];
//        [self.logArr addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"15",@"ZT", nil]];
//
//        if (self.logArr.count != 0) {
////            [self btnSFClick:self.btnSF];
//        }
//    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)btnSFClick{

    [self.postLogPriceDelegate postPrice:self.totalPrice logCode:@"SF"];
}

//- (IBAction)btnZTClick:(id)sender{
//    [self.btnZT setImage:[UIImage imageNamed:@"choose.png"] forState:UIControlStateNormal];
//    [self.btnSF setImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
//
//    self.labHJ.text = [NSString stringWithFormat:@"¥%.0f",self.totalPrice];
//
//    self.labYF.text = @"¥ 0";//[NSString stringWithFormat:@"¥%.1f",[[[self.logArr objectAtIndex:1] objectForKey:@"ZT"] floatValue]];
//
//    [self.postLogPriceDelegate postPrice:self.totalPrice logCode:@"ZT"];
//}
//- (IBAction)btnSFAllClick:(id)sender {
//    [self btnSFClick:sender];
//}
//
//- (IBAction)btnZTAllClick:(id)sender {
//    [self btnZTClick:sender];
//}
@end
