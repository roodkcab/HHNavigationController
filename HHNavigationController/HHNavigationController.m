//
//  HHNavController.m
//  HuiHui
//
//  Created by buaacss on 14-6-14.
//  Copyright (c) 2014年 HuiHui. All rights reserved.
//

#import "HHNavigationController.h"
#import "HHNavigationBar.h"
#import <objc/runtime.h>

#define kDuration 0.5f

#pragma mark - UINavigationController (HHNavController)

static NSString * const HHNavCompletionBlock = @"HHNavCompletionBlock";

@implementation UINavigationController (HHNavController)

@dynamic hh_completionBlock;
- (void(^)())hh_completionBlock
{
    return objc_getAssociatedObject(self, &HHNavCompletionBlock);
}

- (void)setHh_completionBlock:(void (^)())hh_completionBlock
{
    objc_setAssociatedObject(self, &HHNavCompletionBlock, hh_completionBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)pushViewController:(UIViewController *)viewController
{
    [self pushViewController:viewController completion:nil];
}

- (void)pushViewController:(UIViewController *)viewController completion:(void(^)())completionBlock
{
    [self _performSelector:@selector(pushViewController:animated:)
                withCompletion:completionBlock
                      animated:YES
    togetherWithViewController:viewController];
}

- (UIViewController *)popViewController
{
    return [self popViewControllerAnimated:YES];
}

- (UIViewController *)popViewControllerWithCompletion:(void (^)())completionBlock
{
    return [self popViewControllerWithCompletion:completionBlock animated:YES];
}

- (UIViewController *)popViewControllerWithCompletion:(void (^)())completionBlock animated:(BOOL)animated
{
    return [self _performSelector:@selector(popViewControllerAnimated:) withCompletion:completionBlock animated:animated togetherWithViewController:nil];
}

- (id)_performSelector:(SEL)selector withCompletion:(void(^)())completionBlock animated:(BOOL)animated togetherWithViewController:(UIViewController *)viewController
{
    NSMethodSignature *signature = [UINavigationController.class instanceMethodSignatureForSelector:selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = selector;
    int argIdx = 2;
    if (viewController) {
        [invocation setArgument:&viewController atIndex:argIdx];
        argIdx++;
    }
    [invocation setArgument:&animated atIndex:argIdx];
    [invocation retainArguments];
    self.hh_completionBlock = completionBlock;
    [invocation retainArguments];
    [invocation invoke];
    
    const char *returnType = signature.methodReturnType;
    if (strcmp(returnType, @encode(void)) == 0) {
        return nil;
    } else {
        void *ret;
        [invocation getReturnValue:&ret];
        return (__bridge id)ret;
    }
}

@end

#pragma mark - HHNavigationController

@interface HHNavigationController () <UINavigationControllerDelegate>

@end

@implementation HHNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithNavigationBarClass:HHNavigationBar.class toolbarClass:UIToolbar.class];
    if (self) {
        [self pushViewController:rootViewController animated:NO];
        __weak HHNavigationController *weakSelf = self;
        self.delegate = weakSelf;
    }
    return self;
}

- (void)pushViewController:(HHBaseViewController *)viewController animated:(BOOL)animated
{
    HHBaseViewController *currentVC = self.viewControllers.lastObject;
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    if (![viewController useTransparentNavigationBar] && ![currentVC useTransparentNavigationBar]) {
        [self setShouldAddFakeNavigationBar:NO];
    } else {
        [self setShouldAddFakeNavigationBar:YES];
    }
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    HHBaseViewController *previousVC = self.viewControllers[self.viewControllers.count - 2];
    HHBaseViewController *currentVC = self.viewControllers.lastObject;
    if (![currentVC useTransparentNavigationBar] && ![previousVC useTransparentNavigationBar]) {
        [self setShouldAddFakeNavigationBar:NO];
    } else {
        [self setShouldAddFakeNavigationBar:YES];
    }
    return [super popViewControllerAnimated:animated];
}

- (void)setShouldAddFakeNavigationBar:(BOOL)should
{
    _shouldAddFakeNavigationBar = should;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    void(^completionBlock)() = self.hh_completionBlock;
    if (completionBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock();
            if ([completionBlock isEqual:self.hh_completionBlock]) {
                self.hh_completionBlock = nil;
            }
        });
    }
}

@end