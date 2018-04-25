//
//  XChangeImmediatelyNumTableViewCell.m
//  ChatDemo-UI2.0
//
//  Created by dfbe on 15/12/29.
//  Copyright © 2015年 dfbe. All rights reserved.
//

#import "XChangeImmediatelyNumTableViewCell.h"

@implementation XChangeImmediatelyNumTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.lineHConstrain.constant = 1.0/[UIScreen mainScreen].scale;
}

- (void)layoutSubviews{
    self.textFieldNum.text = [self.dic objectForKey:@"num"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnDelNumClick:(id)sender {
    if ([self.xchangeDelegate respondsToSelector:@selector(selectBtnChangeNum:)]) {
        [self.xchangeDelegate selectBtnChangeNum:@"del"];
    }
}

- (IBAction)btnAddNumClick:(id)sender {
    if ([self.xchangeDelegate respondsToSelector:@selector(selectBtnChangeNum:)]) {
        [self.xchangeDelegate selectBtnChangeNum:@"add"];
    }
}
@end
