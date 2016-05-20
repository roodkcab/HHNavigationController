//
//  HHBaseViewController.m
//  HuiHui
//
//  Created by buaacss on 15/3/7.
//  Copyright (c) 2015年 HuiHui. All rights reserved.
//

#import "HHNavigationBar.h"
#import "HHNavigationController.h"
#import "HHBaseViewController.h"

typedef NS_ENUM(NSInteger, HHViewAction) {
    HHViewAppear,
    HHViewDisappear
};

static NSNumber *s_appearanceBarTranslucent;

@interface HHBaseViewController ()

@property (nonatomic, strong) UINavigationBar *bar;

@end

@implementation HHBaseViewController

- (UINavigationBar *)navBar
{
    if (!_navBar) {
        _navBar = [[HHNavigationBar alloc] init];
        [_navBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        _navBar.barStyle = UINavigationBar.appearance.barStyle;
        _navBar.translucent = YES;
        _navBar.items = @[[[UINavigationItem alloc] init]];
        [self.view addSubview:_navBar];
        [_navBar setFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 64)];
    }
    return _navBar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)useTransparentNavigationBar
{
    return NO;
}

- (void)addFakeNavBar:(HHViewAction)action
{
    _bar = [[HHNavigationBar alloc] init];
    _bar.shadowImage = [UIImage new];
    if ([self useTransparentNavigationBar]) {
        [_bar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        _bar.translucent = YES;
    } else {
        [_bar setBackgroundImage:[UINavigationBar.appearance backgroundImageForBarMetrics:UIBarMetricsDefault] forBarMetrics:UIBarMetricsDefault];
        _bar.translucent = s_appearanceBarTranslucent.boolValue;
    }
    _bar.barStyle = UINavigationBar.appearance.barStyle;
    [self.view addSubview:_bar];
    [_bar setFrame:CGRectMake(0, _bar.translucent ? 0 : (action == HHViewAppear ? 0 : -64), UIScreen.mainScreen.bounds.size.width, 64)];
}

- (void)removeFakeNavBar
{
    if (_bar) {
        [_bar removeFromSuperview];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.userInteractionEnabled = NO;
    if (nil == s_appearanceBarTranslucent) {
        s_appearanceBarTranslucent = @(self.navigationController.navigationBar.translucent);
    }
    self.navigationController.navigationBar.translucent = YES;
    [self removeFakeNavBar];
    if (((HHNavigationController *)self.navigationController).shouldAddFakeNavigationBar) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [self addFakeNavBar:HHViewAppear];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self removeFakeNavBar];
    if (((HHNavigationController *)self.navigationController).shouldAddFakeNavigationBar) {
        [self addFakeNavBar:HHViewDisappear];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.userInteractionEnabled = YES;
    if (![self useTransparentNavigationBar]) {
        self.navigationController.navigationBar.barStyle = UINavigationBar.appearance.barStyle;
        self.navigationController.navigationBar.translucent = s_appearanceBarTranslucent.boolValue;
        [self.navigationController.navigationBar setBackgroundImage:[UINavigationBar.appearance backgroundImageForBarMetrics:UIBarMetricsDefault] forBarMetrics:UIBarMetricsDefault];
    } else {
        self.navigationController.navigationBar.translucent = YES;
    }
    [self removeFakeNavBar];
}

- (void)showTempTitle:(NSString *)title
{
    return;
}

- (void)hideTempTitle
{
    return;
}

@end
