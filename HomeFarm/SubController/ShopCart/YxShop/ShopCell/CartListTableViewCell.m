//
//  CartListTableViewCell.m
//  ChatDemo-UI2.0
//
//  Created by dfbe on 15/12/21.
//  Copyright © 2015年 dfbe. All rights reserved.
//

#import "CartListTableViewCell.h"


@implementation CartListTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        //grayView
        UIView *topgrayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 10)];
        topgrayView.backgroundColor = RGB(247, 247, 247);
        [self addSubview:topgrayView];
       
        
        self.imgMain = [[UIImageView alloc] initWithFrame:CGRectMake(50, 16, 76, 91)];
        self.imgMain.image = [UIImage imageNamed:@"loading_animation"];
        
        [self addSubview:self.imgMain];
        
        self.selectButton = [XButtonSingle buttonWithType:UIButtonTypeCustom];
        self.selectButton.frame = CGRectMake(0, (71-31)/2+16, 50, 31);
        self.selectButton.showsTouchWhenHighlighted = YES;
        [self.selectButton setImage:[UIImage imageNamed:@"default_normal.png"] forState:UIControlStateNormal];
        [self.selectButton setImage:[UIImage imageNamed:@"default_select.png"] forState:UIControlStateSelected];
        [self.selectButton addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.selectButton];

        
        self.desLable = [[UILabel alloc] initWithFrame:CGRectMake(133, 11, kScreen_Width-self.imgMain.frame.origin.x-self.imgMain.frame.size.width-10, 46)];
        self.desLable.font = [UIFont systemFontOfSize:14];
        self.desLable.numberOfLines = 2;
        self.desLable.textColor = [CommonMethod hexColor:@"#333333"];
//        self.desLable.adjustsFontSizeToFitWidth = YES;
        
        [self addSubview:self.desLable];
        
        
        self.priceLable = [[UILabel alloc] initWithFrame:CGRectMake(133, 55, kScreen_Width-143, 21)];
        self.priceLable.textColor = [CommonMethod hexColor:@"#FF5E00"];
        [self addSubview:self.priceLable];
        
        
        UILabel *buyCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(137, self.priceLable.bottom + 5, 70, 26)];
        buyCountLabel.text = @"购买数量";
        buyCountLabel.font = [UIFont systemFontOfSize:14];
        buyCountLabel.textColor = [CommonMethod hexColor:@"#333333"];
        [self addSubview:buyCountLabel];
        
        self.grayView = [[UIView alloc] initWithFrame:CGRectMake(buyCountLabel.right + 3, buyCountLabel.top, 97, 26)];
        self.grayView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.grayView];
        
        self.addButton = [XAddButton buttonWithType:UIButtonTypeCustom];//[UIButton buttonWithType:UIButtonTypeCustom];
        self.addButton.frame = CGRectMake(73, 1, 24, 24);
        [self.addButton setTitle:@"+" forState:UIControlStateNormal];
        [self.addButton setTitleColor:[CommonMethod hexColor:@"#AAAAAA"] forState:UIControlStateNormal];
        [self.addButton setBackgroundColor:RGB(230, 230, 230)];
        [self.addButton addTarget:self action:@selector(addBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.grayView addSubview:self.addButton];

        
        self.delButton = [XDelButton buttonWithType:UIButtonTypeCustom];//[UIButton buttonWithType:UIButtonTypeCustom];
        self.delButton.frame = CGRectMake(1, 1, 24, 24);
        [self.delButton setTitle:@"-" forState:UIControlStateNormal];
        [self.delButton setBackgroundColor:RGB(230, 230, 230)];
        [self.delButton setTitleColor:[CommonMethod hexColor:@"#AAAAAA"] forState:UIControlStateNormal];
        [self.delButton addTarget:self action:@selector(deleteBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.grayView addSubview:self.delButton];
        
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(25, 1, 49, 24)];
        self.textField.textAlignment = NSTextAlignmentCenter;
        self.textField.backgroundColor = [UIColor whiteColor];
        self.textField.enabled = NO;
        self.textField.textColor = [CommonMethod hexColor:@"#333333"];
        [self.grayView addSubview:self.textField];
        
        self.removeButton = [XRemoveButton buttonWithType:UIButtonTypeCustom];
        self.removeButton.frame = CGRectMake(kScreen_Width-27, 101, 23, 23);
        [self.removeButton setImage:[UIImage imageNamed:@"shop_delete_icon.png"] forState:UIControlStateNormal];
        [self.removeButton addTarget:self action:@selector(transBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.removeButton];
        self.removeButton.hidden = YES;
        
        
        //line
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, self.grayView.bottom + 10, kScreen_Width-30, 1.0/[UIScreen mainScreen].scale)];
        lineView.backgroundColor = RGB(247, 247, 247);
        [self addSubview:lineView];
    }
    return self;
}


- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (void)reloadData
{
    if (self.itemData) {
        
        self.selectButton.selected = [[self.itemData objectForKey:@"selected"] boolValue];

        self.desLable.text = [self.itemData objectForKey:@"descirb"];
        int tPrice = [[self.itemData objectForKey:@"price"] intValue];
        int tNum = [[self.itemData objectForKey:@"num"] intValue];
        self.priceLable.text = [NSString stringWithFormat:@"¥%d",tPrice*tNum];
        self.textField.text = [self.itemData objectForKey:@"num"];
        [self.imgMain sd_setImageWithURL:[self.itemData objectForKey:@"imageUrl"]];

    }
}

- (void)selectAction:(XButtonSingle *)button{
    if ([self.CartListTableViewCellDelegate respondsToSelector:@selector(carSelectButtonClicked:WithSectionIndexPath:WithIndexPath:addOrDel:)]) {
        [self.CartListTableViewCellDelegate carSelectButtonClicked:self.itemData WithSectionIndexPath:button.tag-100 WithIndexPath:button.rowTag addOrDel:@""];
    }

}


- (void)addBtn:(XAddButton *)button{
    if ([self.CartListTableViewCellDelegate respondsToSelector:@selector(carSelectButtonClicked:WithSectionIndexPath:WithIndexPath:addOrDel:)]) {
        [self.CartListTableViewCellDelegate carSelectButtonClicked:self.itemData WithSectionIndexPath:button.tag-100 WithIndexPath:button.addTag addOrDel:@"add"];
    }

}

- (void)deleteBtn:(XDelButton *)button{
    if ([self.CartListTableViewCellDelegate respondsToSelector:@selector(carSelectButtonClicked:WithSectionIndexPath:WithIndexPath:addOrDel:)]) {
        [self.CartListTableViewCellDelegate carSelectButtonClicked:self.itemData WithSectionIndexPath:button.tag-100 WithIndexPath:button.delTag addOrDel:@"del"];
    }
}

- (void)transBtn:(XRemoveButton *)button{
    if ([self.CartListTableViewCellDelegate respondsToSelector:@selector(carSelectButtonClicked:WithSectionIndexPath:WithIndexPath:addOrDel:)]) {
        [self.CartListTableViewCellDelegate carSelectButtonClicked:self.itemData WithSectionIndexPath:button.tag-100 WithIndexPath:button.removeTag addOrDel:@"remove"];
    }

}

@end
