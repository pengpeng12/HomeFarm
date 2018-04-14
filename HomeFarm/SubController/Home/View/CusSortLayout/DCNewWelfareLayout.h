//
//  DCNewWelfareLayout.h
//  CDDStoreDemo
//
//  Created by dashen on 2017/11/29.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DCNewWelfareLayoutDelegate <NSObject>

@optional;

/* 头部高度 */
-(CGFloat)heightOfSectionHeaderForIndexPath:(NSIndexPath *)indexPath;
/* 尾部高度 */
-(CGFloat)heightOfSectionFooterForIndexPath:(NSIndexPath *)indexPath;

@end

@interface DCNewWelfareLayout : UICollectionViewFlowLayout


@property (nonatomic, assign) id<DCNewWelfareLayoutDelegate>delegate;

@end
