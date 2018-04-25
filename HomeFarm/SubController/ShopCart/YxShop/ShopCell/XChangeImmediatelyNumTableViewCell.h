//
//  XChangeImmediatelyNumTableViewCell.h
//  ChatDemo-UI2.0
//
//  Created by dfbe on 15/12/29.
//  Copyright © 2015年 dfbe. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol xchangeImmediatelyDelegate <NSObject>

- (void)selectBtnChangeNum:(NSString *)addOrDel;

@end

@interface XChangeImmediatelyNumTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineHConstrain;

- (IBAction)btnDelNumClick:(id)sender;

- (IBAction)btnAddNumClick:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *textFieldNum;

@property(nonatomic, strong)NSMutableDictionary *dic;

@property(nonatomic, strong)id<xchangeImmediatelyDelegate>xchangeDelegate;
@end
