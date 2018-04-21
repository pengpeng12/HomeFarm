//
//  MyCenterTopToolView.h
//  HomeFarm
//
//  Created by 易信 on 2018/4/21.
//  Copyright © 2018年 北京易信科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCenterTopToolView : UIView
/** 右边Item点击 */
@property (nonatomic, copy) dispatch_block_t rightItemClickBlock;
@end
