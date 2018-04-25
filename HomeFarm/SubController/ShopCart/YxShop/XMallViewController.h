//
//  XMallViewController.h
//  ChatDemo-UI2.0
//
//  Created by dfbe on 16/3/18.
//  Copyright © 2016年 dfbe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopItem.h"
#import "XOrderPayViewController.h"

@interface XMallViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIScrollView *mallScroller;
@property (weak, nonatomic) IBOutlet UIImageView *imgHead;
@property (weak, nonatomic) IBOutlet UILabel *labDes;
@property (weak, nonatomic) IBOutlet UILabel *labPrice;
@property (weak, nonatomic) IBOutlet UILabel *labExpress;//快递
@property (weak, nonatomic) IBOutlet UILabel *labSales;//销量

//- (IBAction)btnAddNumClick:(id)sender;
//- (IBAction)btnDelNumClick:(id)sender;

- (IBAction)btnCartClick:(id)sender;
- (IBAction)btnLiJiClick:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btnCart;
@property (strong, nonatomic) IBOutlet UIButton *btnLiJi;

//@property (weak, nonatomic) IBOutlet UITextField *textFieldNum;

@property(nonatomic, weak)ShopItem *shopItemData;
@end
