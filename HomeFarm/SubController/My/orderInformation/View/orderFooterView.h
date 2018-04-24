//
//  orderFooterView.h
//  ChatDemo-UI2.0
//
//  Created by 宋鹏鹏 on 15/12/15.
//  Copyright © 2015年 宋鹏鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "orderGroup.h"

#define footerH 47

@interface orderFooterView : UITableViewHeaderFooterView
+ (instancetype)footerWithTableView:(UITableView *)tableView;
@property (strong,nonatomic)orderGroup *group;
@property (nonatomic,strong)UILabel *footLabel;
@end
