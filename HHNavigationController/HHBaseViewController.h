//
//  HHBaseViewController.h
//  HuiHui
//
//  Created by buaacss on 15/3/7.
//  Copyright (c) 2015年 HuiHui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHBaseViewController : UIViewController 

@property (nonatomic, strong) UINavigationBar *navBar;

- (BOOL)useTransparentNavigationBar;
- (void)showTempTitle:(NSString *)title;
- (void)hideTempTitle;

@end
