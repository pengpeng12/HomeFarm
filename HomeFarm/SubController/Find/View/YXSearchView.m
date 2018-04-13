//
//  YXSearchView.m
//  HomeFarm
//
//  Created by 易信 on 2018/4/13.
//  Copyright © 2018年 北京易信科技. All rights reserved.
//

#import "YXSearchView.h"

@implementation YXSearchView

-(id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.placeholder = @"床品焕新抢购,四件套领券领券立减400";
        self.font = [UIFont systemFontOfSize:13];
        UIImageView *searchIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        searchIcon.width = 30;
        searchIcon.height = 30;
        self.leftView = searchIcon;
        searchIcon.contentMode = UIViewContentModeCenter;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

+(instancetype)searchBar {
    return [[self alloc]init];
}

@end
