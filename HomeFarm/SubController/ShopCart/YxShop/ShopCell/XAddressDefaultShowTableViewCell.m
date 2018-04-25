//
//  XAddressDefaultShowTableViewCell.m
//  ChatDemo-UI2.0
//
//  Created by dfbe on 15/12/24.
//  Copyright © 2015年 dfbe. All rights reserved.
//

#import "XAddressDefaultShowTableViewCell.h"

@implementation XAddressDefaultShowTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)layoutSubviews{
    
    self.labDefaultDes.frame = CGRectMake(18, 42, kScreen_Width-36, 35);
    self.labDefaultDes.numberOfLines = 2;
    self.labDefaultDes.adjustsFontSizeToFitWidth = YES;
    self.labDefaultDes.text = [NSString stringWithFormat:@"%@ %@",[self.dic objectForKey:@"city"],[self.dic objectForKey:@"detailAddress"]];
    self.labDefaultName.text = [NSString stringWithFormat:@"  收货人:%@",[self.dic objectForKey:@"SHR"]];
    self.labDefaultPhone.text = [self.dic objectForKey:@"phone"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
