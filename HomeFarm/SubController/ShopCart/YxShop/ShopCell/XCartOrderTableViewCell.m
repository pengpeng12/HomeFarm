//
//  XCartOrderTableViewCell.m
//  ChatDemo-UI2.0
//
//  Created by dfbe on 15/12/24.
//  Copyright © 2015年 dfbe. All rights reserved.
//

#import "XCartOrderTableViewCell.h"

@implementation XCartOrderTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.bottomLineHeightConstrain.constant = 1.0/[UIScreen mainScreen].scale;
}

- (void)layoutSubviews{
//    self.imgMain.image = [CommonMethod getImageFromURLwithUrl:[self.dic objectForKey:@"imageUrl"]];
    //
    [self.imgMain sd_setImageWithURL:[self.dic objectForKey:@"imageUrl"]];
    self.labDesc.frame = CGRectMake(110, 8, kScreen_Width-self.imgMain.frame.origin.x-self.imgMain.frame.size.width-10-5, 39);
    self.labDesc.font = [UIFont systemFontOfSize:14];
    self.labDesc.numberOfLines = 2;
    self.labDesc.text = [self.dic objectForKey:@"descirb"];
//    self.labDesc.numberOfLines = 0;
    self.labPrice.text = [NSString stringWithFormat:@"¥%@",[self.dic objectForKey:@"price"]];
    self.labNum.text = [NSString stringWithFormat:@"x%@",[self.dic objectForKey:@"num"]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
