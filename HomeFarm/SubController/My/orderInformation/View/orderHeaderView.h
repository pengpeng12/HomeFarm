//
//  orderHeaderView.h
//  ChatDemo-UI2.0
//
//  Created by 宋鹏鹏 on 15/12/15.
//  Copyright © 2015年 宋鹏鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "orderGroup.h"

#define headerH 54

@interface orderHeaderView : UITableViewHeaderFooterView
+ (instancetype)headerWithTableView:(UITableView *)tableView;
@property (strong,nonatomic)orderGroup *group;
@property (nonatomic,strong)UILabel *topline;
@property (nonatomic,strong)UILabel *topLeftLabel;
@property (nonatomic,strong)UIImageView *topMiddleImage;
@property (nonatomic,strong)UILabel *topRightLabel;
@end
