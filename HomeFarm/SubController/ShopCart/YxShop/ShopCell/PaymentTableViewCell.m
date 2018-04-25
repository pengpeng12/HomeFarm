//
//  PaymentTableViewCell.m
//  ChatDemo-UI2.0
//
//  Created by dfbe on 15/12/14.
//  Copyright © 2015年 dfbe. All rights reserved.
//

#import "PaymentTableViewCell.h"

@implementation PaymentTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.zfbLineHeightConstraint.constant = 1.0/[UIScreen mainScreen].scale;
    self.wxLineHeightConstraint.constant = 1.0/[UIScreen mainScreen].scale;
}

- (void)layoutSubviews{
    if (self.saveBtnStatusStr == nil || [self.saveBtnStatusStr isEqualToString:@"ZF"]) {
        [self ZFBPay:self.btnZFB];
    }else if ([self.saveBtnStatusStr isEqualToString:@"WX"]){
        [self WXPay:self.btnWX];
    }
//    else if ([self.saveBtnStatusStr isEqualToString:@"YL"]){
//        [self YLPay:self.btnYL];
//    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnYLClick:(id)sender {
   
}
//- (IBAction)YLPay:(id)sender {
//
//    [self.btnYL setBackgroundImage:[UIImage imageNamed:@"choose"] forState:UIControlStateNormal];
//    [self.btnZFB setBackgroundImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
//    [self.btnWX setBackgroundImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
//
//    [self.paymentDelegate witchPayClick:@"yl"];
//}

- (IBAction)btnZFBClick:(id)sender {
    
}
- (IBAction)ZFBPay:(id)sender {
    
    [self.btnZFB setBackgroundImage:[UIImage imageNamed:@"default_select"] forState:UIControlStateNormal];
//    [self.btnYL setBackgroundImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
    [self.btnWX setBackgroundImage:[UIImage imageNamed:@"default_normal"] forState:UIControlStateNormal];
    
    [self.paymentDelegate witchPayClick:@"zfb"];
}

- (IBAction)btnWXClick:(id)sender {
    
}
- (IBAction)WXPay:(id)sender {
    [self.btnWX setBackgroundImage:[UIImage imageNamed:@"default_select"] forState:UIControlStateNormal];
    [self.btnZFB setBackgroundImage:[UIImage imageNamed:@"default_normal"] forState:UIControlStateNormal];
//    [self.btnYL setBackgroundImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
    
    [self.paymentDelegate witchPayClick:@"wx"];
}
@end
