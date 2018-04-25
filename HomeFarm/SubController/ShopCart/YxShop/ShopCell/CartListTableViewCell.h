//
//  CartListTableViewCell.h
//  ChatDemo-UI2.0
//
//  Created by dfbe on 15/12/21.
//  Copyright © 2015年 dfbe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XButtonSingle.h"
#import "XAddButton.h"
#import "XDelButton.h"
#import "XRemoveButton.h"

@class CartListTableViewCell;

@protocol cartlistCellDelegate <NSObject>

- (void) removeCart:(CartListTableViewCell*)cell;
//选中按钮点击
-(void)carSelectButtonClicked:(NSDictionary *)item WithSectionIndexPath:(NSInteger)section WithIndexPath:(NSInteger)row addOrDel:(NSString *)addOrDel;

@end

@interface CartListTableViewCell : UITableViewCell

@property(nonatomic, assign)id<cartlistCellDelegate>CartListTableViewCellDelegate;

@property (nonatomic, assign)BOOL isCheck;

@property (nonatomic,strong) NSMutableDictionary     *itemData;
- (void)reloadData;
@property (nonatomic,strong) XButtonSingle    *selectButton;
@property (nonatomic, strong)XAddButton *addButton;
@property (nonatomic, strong)XDelButton *delButton;
@property (nonatomic, strong)XRemoveButton *removeButton;
@property (nonatomic,strong) UIImageView     *imgMain;
@property (nonatomic,strong) UILabel     *desLable;
@property (nonatomic,strong) UILabel     *priceLable;
@property (nonatomic,strong) UIView     *grayView;
@property (nonatomic,strong) UITextField     *textField;
@property (nonatomic,strong) UIButton     *btnAdd;
@property (nonatomic,strong) UIButton     *btnDel;
//@property (nonatomic,strong) UIButton     *btnRemove;
@end
