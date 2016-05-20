//
//  HHNavigationBar.m
//  HuiHui
//
//  Created by shuoshichen on 15/12/30.
//  Copyright © 2015年 HuiHui. All rights reserved.
//

#import "HHNavigationBar.h"

@implementation HHNavigationBar

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
            if (obj.subviews.count > 1) {
                UIImageView *shadow = obj.subviews[1];
                shadow.hidden = YES;
            }
        }
    }];
}

@end
