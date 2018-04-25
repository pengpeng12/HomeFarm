//
//  XAddressDefaultShowTableViewCell.h
//  ChatDemo-UI2.0
//
//  Created by dfbe on 15/12/24.
//  Copyright © 2015年 dfbe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XAddressDefaultShowTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labDefaultDes;

@property (weak, nonatomic) IBOutlet UILabel *labDefaultPhone;
@property (weak, nonatomic) IBOutlet UILabel *labDefaultName;

@property (nonatomic, strong)NSMutableDictionary *dic;
@end
