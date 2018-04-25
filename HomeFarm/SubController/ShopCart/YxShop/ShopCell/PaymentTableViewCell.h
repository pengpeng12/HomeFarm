//
//  PaymentTableViewCell.h
//  ChatDemo-UI2.0
//
//  Created by dfbe on 15/12/14.
//  Copyright © 2015年 dfbe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol paymentButtonClickImageDelegate <NSObject>

- (void)witchPayClick:(NSString *)btnClickIdentifier;

@end

@interface PaymentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *zfbLineHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *wxLineHeightConstraint;

//@property (weak, nonatomic) IBOutlet UIButton *btnYL;
@property (weak, nonatomic) IBOutlet UIButton *btnZFB;
@property (weak, nonatomic) IBOutlet UIButton *btnWX;
//- (IBAction)btnYLClick:(id)sender;
- (IBAction)btnZFBClick:(id)sender;
- (IBAction)btnWXClick:(id)sender;

@property(nonatomic, assign) id<paymentButtonClickImageDelegate>paymentDelegate;

@property(nonatomic, copy)NSString *saveBtnStatusStr;
@end
