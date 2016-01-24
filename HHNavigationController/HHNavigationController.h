//
//  HHNavController.h
//  HuiHui
//
//  Created by buaacss on 14-6-14.
//  Copyright (c) 2014年 HuiHui. All rights reserved.
//

#import "HHBaseViewController.h"

@interface UINavigationController (HHNavController)

@property (nonatomic, strong) void(^hh_completionBlock)();

- (void)pushViewController:(UIViewController *)viewController;
- (void)pushViewController:(UIViewController *)viewController completion:(void(^)())completionBlock;

- (UIViewController *)popViewController;
- (UIViewController *)popViewControllerWithCompletion:(void(^)())completionBlock;

@end

@interface HHNavigationController : UINavigationController <UINavigationControllerDelegate>

@property (nonatomic, assign) BOOL shouldPopWhenSlideFromLeft;
@property (nonatomic, assign) BOOL shouldAddFakeNavigationBar;

@end