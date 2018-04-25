//
//  XShopViewController.h
//  ChatDemo-UI2.0
//
//  Created by dfbe on 15/12/21.
//  Copyright © 2015年 dfbe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartListTableViewCell.h"

@interface XShopViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *myTableView;



//@property (weak, nonatomic) IBOutlet XButtonSingle *singleAllBtn;

@property (weak, nonatomic) IBOutlet UILabel *labTotalPrice;
- (IBAction)isOkPurchaseBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *isOkBtn;


@property (weak, nonatomic) IBOutlet XButtonSingle *singleAllBtn;


@end
