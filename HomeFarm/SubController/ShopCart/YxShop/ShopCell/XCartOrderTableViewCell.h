//
//  XCartOrderTableViewCell.h
//  ChatDemo-UI2.0
//
//  Created by dfbe on 15/12/24.
//  Copyright © 2015年 dfbe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCartOrderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLineHeightConstrain;

@property (weak, nonatomic) IBOutlet UIImageView *imgMain;
@property (weak, nonatomic) IBOutlet UILabel *labDesc;
@property (weak, nonatomic) IBOutlet UILabel *labPrice;
@property (weak, nonatomic) IBOutlet UILabel *labNum;


@property(nonatomic, strong)NSMutableDictionary *dic;
@end
